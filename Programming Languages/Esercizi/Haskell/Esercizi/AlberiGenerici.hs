{-# LANGUAGE DatatypeContexts #-}
{-# LANGUAGE FlexibleContexts #-}
{-# OPTIONS_GHC -Wno-simplifiable-class-constraints #-}
import Data.List
data (Eq a,Show a) => Tree a = Void | Node a [Tree a] deriving Eq
--alberi n-ari, un nodo può avere una lista di figli albero

-- es. di albero albero = Node 1 [Node 2 [], Node 3 []]

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
treefold _ z Void = z   --nodo foglia, è bottom up
treefold f z (Node val []) = f val [z]
treefold f z (Node val children) = f val (map (treefold f z) children)


-- Es2: si scriva una funzione height per calcolare l’altezza di un albero usando opportunamente la treefold dell’Esercizio 1.
--  Si attribuisca altezza -1 all’albero vuoto
height :: (Eq a, Show a) => Tree a -> Int
height albero = treefold (\ new acc -> maximum acc + 1) (-1) albero --l'albero parte dalle foglie, essendo che e' foldR allora quelle saranno le prime ad essere
                                                                                          -- analizzate. Risalendo per ogni nodo che trovo incremento. E' bottom up non top down

-- Es3: Si scriva una funzione simplify per eliminare i figli Void ridondanti usando opportunamente la treefold
simplify :: (Eq a, Show a) => Tree a -> Tree a
--simplify (Node val children) = treefold(\ new acc -> acc ++ (foldl (\ listaFigli figlio -> if(figlio == Void)then listaFigli else figlio:listaFigli) [] children)) Void albero
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
treefoldr _ acc _ _ Void = acc
treefoldr f acc g y (Node val []) = f val y   
treefoldr f acc g y (Node val children) = f val (foldr (g . treefoldr f acc g y) y children)

treefoldl :: (Eq a, Show a) => (b -> a -> c) -> c -> (c -> b -> b) -> b -> Tree a -> c
treefoldl _ acc _ _ Void = acc
treefoldl f acc g y (Node val []) = f y val
treefoldl f acc g y (Node val children) = f (foldr (g . treefoldl f acc g y) y children) val


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