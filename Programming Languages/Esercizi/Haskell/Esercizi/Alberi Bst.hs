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

-- per creare un albero => <nomeVar> = Node <num> <nodo sx> <nodo dx>
-- per visualizzare l'albero => valuto <nomeVar>

-- per esercizi: albero = Node 2 (Node 1 Void Void) (Node 3 Void Void) oppure usa la funz creaBst
creaBst :: (Integral a, Num a, Ord a, Read a, Show a) => [a] -> BST a
creaBst lista = foldl (bstInsert) Void lista

-- 1. Scrivere una funzione che calcola la somma dei valori di un albero a valori sommabili.
sommaValori :: (Num a, Ord a, Read a, Show a) => BST a -> a
sommaValori Void = 0
sommaValori (Node val left right) = val + sommaValori left + sommaValori right 

-- 2. Scrivere una funzione che calcola la somma dei valori dispari di un albero a valori sommabili su cui sia utilizzabile la funzione odd.
sommaDispari :: (Integral a, Num a, Ord a, Read a, Show a) => BST a -> a
sommaDispari Void = 0
sommaDispari (Node val left right) = (mod val 2) + (sommaDispari left ) + (sommaDispari right)

-- 3. Si scriva un predicato samesums che presa una lista di alberi [t1,...,tn] determina se le somme s1 , . . . , sn dei valori degli elementi di ogni ti sono tutte uguali fra loro.
sameSums :: (Num a, Ord a, Read a, Show a) => [BST a] -> Bool
sameSums [] = True
-- sameSums x:y:xs = ((sommaValori x) == (sommaValori y)) && sameSums xs
sameSums lista = snd (foldl (\ (acc,esito) new -> if (acc == sommaValori new) then (acc,True) else (acc,False)) (sommaValori (head lista),True) (tail lista))

-- 4. Scrivere un predicato bstElem (infisso magari) per determinare se un valore è presente in un BST.
bstElem :: (Integral a, Num a, Ord a, Read a, Show a) => BST a -> a -> Bool
--bstElem (Node val left right) x = foldl(\ acc new -> if(val == x) then acc || True else acc) False 
bstElem Void _ = False
bstElem (Node val left right) x 
    | val > x = bstElem left x
    | val == x = True
    | otherwise = bstElem right x

-- 5. Si scriva una funzione per eseguire l’inserimento di un dato x in un albero t.
bstInsert :: (Integral a, Num a, Ord a, Read a, Show a) => BST a -> a -> BST a
bstInsert Void x = (Node x Void Void)
bstInsert (Node val left right) x
            | val > x = (Node val left (bstInsert right x))
            | val < x = (Node val (bstInsert left x) right)
            | otherwise = (Node val left right)
            
-- 6. Si scriva una funzione bst2List che calcola la lista ordinata degli elementi di un BST. Ci si assicuri di scrivere una funzione lineare.
bst2List :: (Integral a, Num a, Ord a, Read a, Show a) => BST a -> [a]  -- INORDER
bst2List Void = []
bst2List (Node val left right) = bst2List left ++ [val] ++ bst2List right

-- 7. Si scriva una (semplice) funzione di ordinamento di liste come combinazione di funzioni fatte nei precedenti esercizi.
ordLista :: (Integral a, Num a, Ord a, Read a, Show a) => [a] -> [a]
ordLista lista = bst2List (creaBst lista)
