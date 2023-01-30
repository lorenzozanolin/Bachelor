{-# LANGUAGE DatatypeContexts #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-simplifiable-class-constraints #-}
import Data.List
data (Eq a,Show a) => Tree a = Void | Node a [Tree a] deriving Eq

instance (Eq a, Show a) => Show (Tree a) where
    show = showsTree []

showsTree :: (Eq a, Show a) => [Bool] -> Tree a -> String
showsTree xs Void = createTreeStructure xs ++ "VOID\n"
showsTree xs (Node val []) = createTreeStructure xs ++ show val ++ "\n"
showsTree xs (Node val children) = createTreeStructure xs ++ show val ++ "\n" ++ concatMap (showsTree (xs ++ [True])) (init children) ++ showsTree (xs ++ [False]) (last children)

createTreeStructure :: [Bool] -> String
createTreeStructure [] = ""
createTreeStructure xs = foldl (\ acc new -> if new then acc ++ "│ " else acc ++ "  ") "" (init xs) ++ if last xs then "├─" else "└─"

-- Es1: si scriva una generalizzazione della funzione foldr delle liste per Alberi Generici che abbia il seguente tipo:
--  treefold :: (Eq a, Show a) => (a->[b]->b) -> b -> Tree a -> b
treefold :: (Eq a, Show a) => (a -> [b] -> b) -> b -> Tree a -> b
treefold _ z Void = z
treefold f z (Node val []) = f val [z]
treefold f z (Node val children) = f val (map (treefold f z) children)

-- Es2: si scriva una funzione height per calcolare l’altezza di un albero usando opportunamente la treefold dell’Esercizio 1.
--  Si attribuisca altezza -1 all’albero vuoto
height :: (Eq a, Show a) => Tree a -> Int
height = treefold (\ _ childrenHeights -> maximum childrenHeights + 1) (-1)

-- Es3: si scriva una funzione simplify per eliminare i figli Void ridondanti usando opportunamente la treefold dell’Esercizio 1.
simplify :: (Eq a, Show a) => Tree a -> Tree a
simplify = treefold (\ val children -> Node val (simplifyVoids children)) Void where
    simplifyVoids :: [Tree a] -> [Tree a]
    simplifyVoids [] = []
    simplifyVoids (Void:xs) = simplifyVoids xs
    simplifyVoids (x:xs) = x : simplifyVoids xs

-- Es4: si scrivano le generalizzazioni delle funzioni foldr e foldl delle liste per Alberi Generici aventi i seguenti tipi
--  (abbiamo bisogno di due “zeri” corrispondenti all’albero vuoto e alla lista di alberi vuota):
--      treefoldr :: (Eq a,Show a) => (a->b->c)->c->(c->b->b)->b->Tree a->c
--      treefoldl :: (Eq a,Show a) => (b->a->c)->c->(c->b->b)->b->Tree a->c
-- Con queste fold non c’è bisogno di costruire la lista intermedia a cui applicare la funzione di “aggregazione” ma si esegue il lavoro man mano.
treefoldr :: (Eq a, Show a) => (a -> b -> c) -> c -> (c -> b -> b) -> b -> Tree a -> c
treefoldr _ x _ _ Void = x
treefoldr f x g y (Node val []) = f val y
treefoldr f x g y (Node val children) = f val (foldr (g . treefoldr f x g y) y children)

treefoldl :: (Eq a, Show a) => (b -> a -> c) -> c -> (c -> b -> b) -> b -> Tree a -> c
treefoldl _ x _ _ Void = x
treefoldl f x g y (Node val []) = f y val
treefoldl f x g y (Node val children) = f (foldr (g . treefoldl f x g y) y children) val

-- Es5: si riscriva la funzione height per calcolare l’altezza di un albero usando opportunamente la treefoldr dell’Esercizio 4.
height' :: (Eq a, Show a) => Tree a -> Int
height' = treefoldr (\ _ h -> h + 1) (-1) max (-1)

-- Es6: si riscriva la funzione simplify per eliminare i figli Void ridondanti usando opportunamente la treefoldr dell’Esercizio
simplify' :: (Eq a, Show a) => Tree a -> Tree a
simplify' = treefoldr Node Void (\ c acc -> case c of
    Void -> acc
    _ -> c:acc ) []

-- Es7: si scriva una funzione degree che restituisce il grado di un albero (il massimo del numero di figli per ogni nodo).
degree :: (Eq a, Show a) => Tree a -> Int
degree = treefoldr  (\ _ (numChildren, maxDegree) -> max numChildren maxDegree)
                    (-1)
                    (\ childMaxDegree (countedChildren, maxDegreeUntilNow) -> (countedChildren+1, max childMaxDegree maxDegreeUntilNow))
                    (0, 0)

-- Es8: si scriva una funzione transpose che restituisce il trasposto di un albero (per ogni nodo i trasposti dei figli in ordine inverso).
transpose :: (Eq a, Show a) => Tree a -> Tree a
transpose = treefoldr Node Void (\ newChild otherChildren -> otherChildren ++ [newChild]) []

-- Es9: si scriva un predicato issymm che stabilisce se un albero ha una forma simmetrica (cioè è uguale, non considerando il contenuto, al suo trasposto)
isSym :: (Eq a, Show a) => Tree a -> Bool
isSym tree = case tree of
    Void -> True
    Node val [] -> True
    Node val children -> all (\ (c1, c2) -> height c1 == height c2 && degree c1 == degree c2 && isSym c1 && isSym c2) (zip children (map Main.transpose children))

-- Es10: si scriva una funzione normalize che dato un albero con valori nella classe Integral costruisca un nuovo albero che in ogni nodo contenga, al posto del valore originale, tale valore moltiplicato per l’inverso dell’altezza.
normalize :: (Integral a, Show a) => Tree a -> Tree Int
normalize tree = treefold (\ val xs -> Node (div (fromIntegral val) h) xs) Void tree where
    h = height tree

-- Es11: si scriva una funzione annotate che costruisca un nuovo albero che in ogni nodo contenga, al posto del valore originale, una coppia composta dal medesimo valore e dall’altezza del nodo stesso.
annotate :: (Eq a, Show a) => Tree a -> Tree (a, Int)
annotate = treefold (\ val xs -> Node (val, maximum (map (\ x -> case x of
    (Node (v,h) xxs) -> h
    Void -> -1) xs) + 1) xs) Void

-- Es12: si scriva un predicato iscorrect che determina se un albero è un albero di parsing secondo le regole di una grammatica codificata mediante una funzione che,
--  dato un simbolo, restituisce la lista delle possibili espansioni (stringhe di simboli) secondo le produzioni.
isCorrect :: (Eq a, Show a) => (a -> [[a]]) -> Tree a -> Bool
isCorrect f Void = True
isCorrect f (Node val xs) = ([] `elem` f val) && all (isCorrect f) xs

isCorrect' :: ([Char] -> [[Char]]) -> Tree [Char] -> Bool
isCorrect' f tree = result (treefold ( \ val xs -> Node (any (\ (Node (bool, v) children) -> v `elem` f val) xs && all (\ (Node (bool, v) children) -> bool) xs, val) [] ) (Node (True, "") []) tree) where
    result (Node (bool, val) children) = bool
    result Void = True

-- Es13: si scriva una funzione diameter che determina il diametro di un albero.
--  Il diametro di un albero è la lunghezza del massimo cammino fra due nodi, indipendentemente dall’orientamento degli archi.
diameter :: (Eq a, Show a) => Tree a -> Int
diameter tree = result (treefold (\ _ children -> Node (1 + maximum (map (\ (Node (h, d) c) -> h) children), max (1 + (sum (take 2 (reverse (sort (map (\ (Node (h, d) c) -> h) children)))))) (maximum (map (\ (Node (h, d) c) -> d) children))) []) (Node (0,0) []) tree) where
    result (Node (h, d) children) = d
    result Void = -1

-- Es14: si scriva una funzione maxPathWeight che, dato un albero di valori numerici positivi, determina il massimo peso di tutti i cammini, indipendentemente dall’orientamento degli archi.
--  Il peso di un cammino è la somma dei valori dei nodi del cammino.
maxPathWeight :: Tree Int -> Int
maxPathWeight Void = 0
maxPathWeight tree = mPWAux 0 tree where
    mPWAux :: Int -> Tree Int -> Int
    mPWAux _ Void = 0
    mPWAux n (Node val children) = max (maximum (map (mPWAux n) children) + val) n + val

-- Es15: si scriva una funzione preorder che restituisce la lista degli elementi di una visita in preordine.
preorder :: (Eq a, Show a) => Tree a -> [a]
preorder Void = []
preorder (Node val children) = val : foldl (++) [] (map preorder children)

-- Es16: si scriva una funzione frontier che restituisce la frontiera di un albero (la lista degli elementi delle foglie).
frontier :: (Eq a, Show a) => Tree a -> [a]
frontier Void = []
frontier (Node val []) = [val]
frontier (Node val children) = if (filter (Void /=) children) == [] then [val] else foldl (++) [] (map frontier children)

-- Es17: si scriva una funzione smallParents che restituisce la lista dei (valori dei) nodi che son genitori ma non nonni di qualche altro nodo.
--  La lista deve essere prodotta rispettando l’ordine di comparizione nell’albero.
smallParents :: (Eq a, Show a) => Tree a -> [a]
smallParents Void = []
smallParents (Node val []) = []
smallParents (Node val children) = if all isLeaf children then [val] else foldl (++) [] (map smallParents children) where
    isLeaf :: (Eq a, Show a) => Tree a -> Bool
    isLeaf Void = False
    isLeaf (Node val children) = filter (Void /=) children == []

-- Es18: si scriva un predicato arithmSmallParents che determina se i (valori dei) nodi che son genitori ma non nonni di qualche altro nodo sono una progressione aritmetica (∃y, z : ∀i. xi = y + i ∗ z).
arithmSmallParents :: Tree Int -> Bool
arithmSmallParents tree = case smallParents tree of
    [] -> True
    [x] -> True
    (x1:x2:xs) -> let f = (\ x -> x * (x2 - x1) + x1) in all (\ (index, elem) -> f index == elem) (zip [0..1 + length xs] (x1:x2:xs))

-- Es19: codificando un’espressione e in notazione polacca inversa mediante una lista di tipo
--      Num a =>[Either a (op,Int)],
--  si scriva una funzione rpn2tree che data e costruisca un opportuno albero di sintassi astratta. La componente intera della coppia che identifica un'operazione ne stabilisce l’arità.
rpn2Tree :: (Num a, Eq (Either a Char), Show (Either a Char)) => [Either a (Char, Int)] -> Tree (Either a Char)
rpn2Tree list = rpn2TreeAux [] list where
    rpn2TreeAux :: (Num a, Eq (Either a Char), Show (Either a Char)) => [Tree (Either a Char)] -> [Either a (Char, Int)] -> Tree (Either a Char)
    rpn2TreeAux stack [] = head stack
    rpn2TreeAux stack (x:xs) = case x of
        Left variable ->  rpn2TreeAux (stack ++ [Node (Left variable) []]) xs
        Right (op, arity) -> rpn2TreeAux (removeElements arity stack ++ [Node (Right op) (takeElements arity stack)]) xs where
            removeElements :: (Num a) => Int -> [Tree (Either a op)] -> [Tree (Either a op)]
            removeElements 0 list = list
            removeElements n list = removeElements (n-1) (init list)
            takeElements :: (Num a) => Int -> [Tree (Either a op)] -> [Tree (Either a op)]
            takeElements 0 list = []
            takeElements n list = last list : takeElements (n-1) (init list)


myTree = Node 10 [(Node 5 []), (Node 6 [Void, Void]), (Node 15 [(Node 20 [Void]), (Node 12 [(Node 30 []), (Node 35 [])])]), (Node 16 [(Node 8 []), (Node 9 [])]), (Node 20 [(Node 10 []), (Node 12 [])])]
myTree' = Node 10 [ (Node 5 []), (Node 6 [])]
myList :: (Num a) => [Either a (Char, Int)]
myList = [Left 1, Left 2, Left 3, Right ('s', 2), Right ('m', 2)]


main :: IO()
main = print (rpn2Tree myList)