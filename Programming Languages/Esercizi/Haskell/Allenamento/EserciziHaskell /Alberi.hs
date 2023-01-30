{-# LANGUAGE DatatypeContexts #-}
data (Ord a, Read a, Show a) => BST a = Void | Node {
    val :: a,
    left, right :: BST a
} deriving (Eq, Ord, Read)

instance (Ord a, Read a, Show a) => Show (BST a) where
    show = showsBTree []

showsBTree :: (Ord a, Read a, Show a) => [Bool] -> BST a -> String
showsBTree xs Void = createTreeStructure xs ++ "VOID\n"
showsBTree xs (Node val left right) = createTreeStructure xs ++ show val ++ "\n" ++ showsBTree (xs++[True]) left ++ showsBTree (xs++[False]) right

createTreeStructure :: [Bool] -> String
createTreeStructure [] = ""
createTreeStructure xs = foldl (\ acc new -> if new then acc ++ "│ " else acc ++ "  ") "" (init xs) ++ if last xs then "├─" else "└─"

-- Es1: scrivere una funzione che calcola la somma dei valori di un albero a valori sommabili.
treeSum :: (Num a, Ord a, Read a, Show a) => BST a -> a
treeSum Void = 0
treeSum (Node val left right) = val + treeSum left + treeSum right

-- Es2: scrivere una funzione che calcola la somma dei valori dispari di un albero a valori sommabili su cui sia utilizzabile la funzione odd.
oddSum :: (Integral a, Ord a, Read a, Show a) => BST a -> a
oddSum Void = 0
oddSum (Node val left right) = (mod val 2 * val) + oddSum left + oddSum right

-- Es3: si scriva un predicato samesums che presa una lista di alberi [t1,...,tn] determina se le somme s1 , . . . , sn dei valori degli elementi di ogni ti sono tutte uguali fra loro.
sameSums :: (Num a, Ord a, Read a, Show a) => [BST a] -> Bool
sameSums [] = True
sameSums l = snd (foldl (\ (acc, ret) new -> if treeSum new == acc && ret then (acc, True) else (acc, False)) (treeSum (head l), True) (tail l))

-- Es4: scrivere un predicato bstElem (infisso magari) per determinare se un valore è presente in un BST.
--  Per la notazione infissa è sufficiente usare i backtick nell'uso del predicato: tree `bstElem` elem
bstElem :: (Ord a, Read a, Show a) => BST a -> a -> Bool
bstElem Void _ = False
bstElem (Node val left right) key
    | key == val = True
    | key > val = bstElem right key
    | otherwise = bstElem left key

-- Es5: si scriva una funzione per eseguire l’inserimento di un dato x in un albero t.
bstInsert :: (Ord a, Read a, Show a) => BST a -> a -> BST a
bstInsert Void key = Node key Void Void
bstInsert (Node val left right) key
    | key == val = Node val left right
    | key > val = Node val left (bstInsert right key)
    | otherwise = Node val (bstInsert left key) right

-- Es6: si scriva una funzione bst2List che calcola la lista ordinata degli elementi di un BST. Ci si assicuri di scrivere una funzione lineare
bst2List :: (Ord a, Read a, Show a) => BST a -> [a]     -- NB: questa funzione non opera in tempo lineare
bst2List Void = []
bst2List (Node val left right) = bst2List left ++ [val] ++ bst2List right

bst2List' :: (Ord a, Read a, Show a) => BST a -> [a]
bst2List' = bst2ListAux [] where
    bst2ListAux acc Void = acc
    bst2ListAux acc (Node val left right) = bst2ListAux (val:bst2ListAux acc right) left

-- Es 7: si scriva una (semplice) funzione di ordinamento di liste come combinazione di funzioni fatte nei precedenti esercizi.
treeSort :: (Ord a, Read a, Show a) => [a] -> [a]
treeSort xs = bst2List (foldl bstInsert Void xs)

-- Es8: si scriva una funzione filtertree p t che costruisce una lista (ordinata) di tutti gli elementi dell’albero t che soddisfano il predicato p
filterTree :: (Ord a, Read a, Show a) => (a -> Bool) -> BST a -> [a]
filterTree _ Void = []
filterTree p (Node val left right)
    | p val = filterTree p left ++ [val] ++ filterTree p right
    | otherwise = filterTree p left ++ filterTree p right

-- Es9: si scriva una funzione annotate che costruisca un nuovo BST che in ogni nodo contenga, al posto del valore originale, una coppia composta dal medesimo valore e dall’altezza del nodo stesso (la lunghezza del massimo cammino, cioè 1 + max(height(sx), height(dx)).
--  Si scelga di attribuire all’albero vuoto 0 o -1 a seconda delle preferenze.
annotate :: (Ord a, Read a, Show a) => BST a -> BST (a,Int)
annotate Void = Void
annotate (Node val left right) = Node (val, (max (height lt) (height rt)) + 1) lt rt where
    height :: (Ord a, Read a, Show a) => BST (a,Int) -> Int
    height Void = -1
    height (Node (val,h) left right) = h
    lt = annotate left
    rt = annotate right

-- Es10: si scriva un predicato (funzione a valori booleani) almostBalanced per determinare se un albero binario ha la seguente proprietà:
--  per ogni nodo le altezze dei figli destro e sinistro differiscono al massimo di 1
almostBalanced :: (Ord a, Read a, Show a) => BST a -> Bool
almostBalanced Void = True
almostBalanced (Node val left right) = abs (height left - height right) <= 1 && almostBalanced left && almostBalanced right where
    height :: (Ord a, Read a, Show a) => BST a -> Int
    height Void = -1
    height (Node val left right) = max (height left) (height right) + 1


data WBST a = Null | WNode a Int (WBST a) (WBST a)

instance (Show a) => Show (WBST a) where
    show = showsWBTree []

showsWBTree :: (Show a) => [Bool] -> WBST a -> String
showsWBTree xs Null = createTreeStructure xs ++ "(VOID/-1)\n"
showsWBTree xs (WNode val weight left right) = createTreeStructure xs ++ "(" ++ show val ++ "/" ++ show weight ++ ")" ++ "\n" ++ (showsWBTree (xs++[True]) left) ++ (showsWBTree (xs++[False]) right)

-- Es11: data la seguente definizione del tipo di dato astratto (polimorfo) Weighted Binary Search Tree che consiste in un BST in cui in ogni nodo viene mantenuta l’altezza del nodo stesso.
--  si scriva una funzione insert che inserisce un nuovo valore in un WBST
wbstInsert :: (Ord a, Show a) => WBST a -> a -> WBST a
wbstInsert Null key = WNode key 0 Null Null
wbstInsert (WNode val weight left right) key
    | key == val = WNode val weight left right
    | key > val = WNode val (max (height left) (height (wbstInsert right key)) + 1) left (wbstInsert right key)
    | otherwise = WNode val (max (height (wbstInsert left key)) (height right) + 1) (wbstInsert left key) right
    where
        height Null = -1
        height (WNode val weight left right) = weight

-- Es12: si scriva una funzione diff2next che, dato un albero binario di ricerca, costruisce un albero binario di ricerca (annotato) di coppie dove
--  1. il primo elemento di ogni coppia è l’elemento dell’albero originale
--  2. il secondo elemento è
--      2.a Just(la differenza rispetto al valore successivo), secondo l’ordinamento dei valori contenuti
--      2.b Nothing per il nodo di valore massimo.
diff2Next :: (Ord a, Show a, Read a, Num a) => BST a -> BST (a, Maybe a)
diff2Next node = diff2NextAux node orderedTree where
    orderedTree = bst2List node
    diff2NextAux :: (Ord a, Show a, Read a, Num a) => BST a -> [a] -> BST (a, Maybe a)
    diff2NextAux Void _ = Void
    diff2NextAux (Node val left right) xs = Node (val, diff2next) (diff2NextAux left xs) (diff2NextAux right xs) where
        diff2next = if val == last xs then Nothing else Just (head [ elem | elem <- map (\ key -> key - val) xs, elem > 0 ])

-- Es13: si scriva una funzione che dato un BST ne restituisce la lista degli elementi ottenuti visitando l’albero a livelli.
bstByLevel :: (Ord a, Show a, Read a) => BST a -> [a]
bstByLevel tree = bstByLevelAux [tree] where
    bstByLevelAux :: (Ord a, Show a, Read a) => [BST a] -> [a]
    bstByLevelAux [] = []
    bstByLevelAux (Void:xs) = bstByLevelAux xs
    bstByLevelAux ((Node val left right):xs) = val : bstByLevelAux (xs ++ [left,right])


fold :: (Ord a, Show a, Read a) => (a -> b -> b -> b) -> b -> BST a -> b
fold _ z Void = z
fold f z (Node x l r) = f x (fold f z l) (fold f z r)

-- Es14: si scriva una funzione treeheight per calcolare l’altezza di un albero usando opportunamente fold.
treeHeight :: (Ord a, Show a, Read a) => BST a -> Int
treeHeight = fold (\ _ l r -> max l r + 1) (-1)

-- Es15: si riscriva la funzione annotate dell’Esercizio 9 usando opportunamente fold
annotate' :: (Ord a, Read a, Show a) => BST a -> BST (a,Int)
annotate' = fold (
    \ val l r -> case l of
        Void -> case r of
            Void                    -> Node (val,0) l r
            (Node (vr, hr) rl rr)   -> Node (val, hr+1) l r
        (Node (vl, hl) ll lr) -> case r of
            Void                    -> Node (val, hl+1) l r
            (Node (vr, hr) rl rr)   -> Node (val, max hl hr +1) l r) Void

-- Es16: si riscriva la funzione almostBalanced dell’Esercizio 10 usando opportunamente fold.
almostBalanced' :: (Ord a, Read a, Show a) => BST a -> Bool
almostBalanced' tree = snd (fold (\ _ (lh,lb) (rh,rb) -> (max lh rh + 1,lb && rb && abs (lh - rh) <= 1)) (-1,True) tree)

-- Es17: si scriva una funzione maxDiameter che data una lista l di BST determina il massimo dei diametri dei BST di l.
--  Il diametro di un BST è la lunghezza del massimo cammino fra due nodi, indipendentemente dall’orientamento degli archi.
maxDiameter :: (Ord a, Read a, Show a) => BST a -> Int
maxDiameter tree = snd (fold (\ _ (lHeight, lDiam) (rHeight, rDiam) -> (1 + max lHeight rHeight, max (1 + lHeight + rHeight) (max lDiam rDiam))) (-1, -1) tree)

-- Es18: si scriva un predicato isBST, usando opportunamente fold, che dato un albero verifica se i valori in esso contenuti soddisfano la proprietò strutturale dei Binary Search Trees.
isBST :: (Ord a, Read a, Show a, Num a) => BST a -> Bool
isBST tree = secondElem (fold
    (\ val (lVal, lBool, lVoid) (rVal, rBool, rVoid) ->
        (val, (rVoid || (lBool && lVal <= val)) && (rVoid || (rBool && rVal >= val)), False)
    )
    (0, True, True)
    tree) where
        secondElem :: (a,b,c) -> b
        secondElem (a,b,c) = b


data (Ord a) => ABST a = Nil | ANode Bal a (ABST a) (ABST a) deriving (Eq, Ord, Read, Show)
data Bal = Left | Bal | Right deriving (Eq, Ord, Read, Show)

afold :: (Eq a, Ord a, Show a, Read a) => (Bal -> a -> b -> b -> b) -> b -> ABST a -> b
afold _ z Nil = z
afold f z (ANode bal x l r) = f bal x (afold f z l) (afold f z r)

-- Es19: si scriva un predicato isAVL che dato un albero AVL determina se è ben formato, cioè se
--      1. la differenza fra le profondità dei sottoalberi destro e sinistro di un qualunque nodo è al massimo 1
--      2. le etichette Bal dei nodi sono consistenti con lo (s)bilanciamento.
isAVL :: (Eq a, Ord a, Read a, Show a) => ABST a -> Bool
isAVL tree = snd (afold (\ bal _ (heightL, boolL) (heightR, boolR) -> case bal of
    Main.Left -> (max heightL heightR + 1, boolL && boolR && heightL == heightR + 1)
    Main.Bal -> (max heightL heightR + 1, boolL && boolR && heightL == heightR)
    Main.Right -> (max heightL heightR + 1, boolL && boolR && heightL + 1 == heightR)) (-1,True) tree)


data (Ord a) => RBT a = None | RNode a Color (RBT a) (RBT a) deriving (Eq, Ord, Read, Show)
data Color = Red | Black deriving (Eq, Ord, Read, Show)

rfold :: (Eq a, Ord a, Show a, Read a) => (a -> Color -> b -> b -> b) -> b -> RBT a -> b
rfold _ z None = z
rfold f z (RNode x col l r) = f x col (rfold f z l) (rfold f z r)

-- Es20: si scriva un predicato isRBT che dato un albero RBT determina se è ben formato, cioè se
--      1. ogni nodo contiene un valore non minore dei valori del suo sottoalbero sinistro e minore dei valori del sottoalbero destro
--      2. tutti i cammini dalla radice a una foglia hanno lo stesso numero di nodi Black
--      3. i nodi Red devono avere genitore Black
--      4. la radice è Black
isRBT :: RBT Int -> Bool
isRBT tree = case tree of
    None -> True
    (RNode _ Red _ _) -> False
    _ -> last (rfold foldableIsRBT (True, (0,0), 0, False, True) tree)  where
            last :: (Bool, (Int, Int), Int, Bool, Bool) -> Bool
            last (isNull, (min, max), blacks, isRed, x) = x
            foldableIsRBT :: Int -> Color -> (Bool, (Int, Int), Int, Bool, Bool) -> (Bool, (Int, Int), Int, Bool, Bool) -> (Bool, (Int, Int), Int, Bool, Bool)
            foldableIsRBT val col leftFold rightFold = case leftFold of
                (_, _, _, _, False) -> invalidCheck
                (True, _, _, _, _) -> case rightFold of
                    (_, _, _, _, False) -> invalidCheck
                    (True, _, _, _, _) -> if col == Black then (False, (val, val), 1, False, True) else (False, (val, val), 0, True, True)
                    (False, (rMin, rMax), rBlacks, rIsRed, rValid) -> if (val >= rMin) || (rIsRed && (rBlacks /= 0 || col == Red)) then invalidCheck else
                        if col == Black then (False, (val, rMax), 1, False, True) else (False, (val, rMax), 0, False, True)
                (False, (lMin, lMax), lBlacks, lIsRed, lValid) -> case rightFold of
                    (_, _, _, _, False) -> invalidCheck
                    (True, _, _, _, _) -> if (val <= lMax) || (lIsRed && (lBlacks /= 0 || col == Red)) then invalidCheck else
                        if col == Black then (False, (lMin, val), 1, False, True) else (False, (lMin, val), 0, False, True)
                    (False, (rMin, rMax), rBlacks, rIsRed, rValid) -> if (val <= lMax) || (val >= rMin) || (col == Red && (lIsRed || rIsRed)) || (lBlacks /= rBlacks) then invalidCheck
                        else if col == Black then (False, (lMin, rMax), lBlacks+1, False, True) else (False, (lMin, rMax), lBlacks, True, True)
                where invalidCheck = (False, (0,0), 0, False, False)

-- Es21: si riscriva la funzione bst2List dell’Esercizio 6 usando opportunamente fold.
bst2List'' :: (Ord a, Read a, Show a) => BST a -> [a]
bst2List'' = fold (\ val left right -> left ++ (val:right)) []

-- Es22: si riscriva la funzione filtertree dell’Esercizio 8 usando opportunamente fold.
filterTree' :: (Ord a, Read a, Show a) => (a -> Bool) -> BST a -> [a]
filterTree' p = fold (\ val left right -> if p val then left ++ (val:right) else left ++ right) []

-- Es23: si riscriva la funzione diff2next dell’Esercizio 12 usando opportunamente fold.
diff2Next' :: (Ord a, Show a, Read a, Num a) => BST a -> BST (a, Maybe a)
diff2Next' node = diff2NextAux node orderedTree where
    orderedTree = bst2List'' node
    diff2NextAux :: (Ord a, Show a, Read a, Num a) => BST a -> [a] -> BST (a, Maybe a)
    diff2NextAux tree xs = fold (\ val l r ->
        if val == last xs then
            Node (val, Nothing) l r
        else
            Node (val, Just (head [ elem | elem <- map (\ key -> key - val) xs, elem > 0 ])) l r)
        Void tree

-- Es24: si scriva una funzione limitedVisit che dato un BST e due valori x, y costruisce la lista (ordinata) degli elementi dell’albero compresi nell’intervallo di valori da x a y
limitedVisit :: (Ord a, Show a, Read a) => BST a -> a -> a -> [a]
limitedVisit tree x y = fold (\ val lList rList -> if val <= y && val >= x then lList ++ (val:rList) else lList ++ rList) [] tree

-- Es25: si scriva una funzione shiftToZero che dato un BST t costruisce un nuovo BST isomorfo che contiene gli elementi t diminuiti del valore minimo di t.
shiftToZero :: (Ord a, Show a, Read a, Num a) => BST a -> BST a
shiftToZero Void = Void
shiftToZero (Node val left right) = reducedTree where
    (mm, reducedTree) = fold aggr (val, Void) (Node val left right)
    aggr val (lMin, lTree) (rMin, rTree) = (min val (min lMin rMin), Node (val - mm) lTree rTree)


myTree = Node 5 (Node 3 Void Void) (Node 9 (Node 7 Void Void) (Node 12 Void (Node 20 Void Void)))
myTree1 = Node 4 (Node 2 Void Void) (Node 11 (Node 7 Void Void) (Node 12 Void (Node 20 Void Void)))
myTree2 = Node 6 (Node 2 Void Void) (Node 10 (Node 7 Void Void) (Node 12 Void (Node 20 Void Void)))
myTree4 = ANode Main.Left 10 (ANode Bal 5 (ANode Bal 3 Nil Nil) (ANode Bal 6 Nil Nil)) (ANode Bal 15 Nil Nil)


main :: IO ()
main = print (shiftToZero myTree)
