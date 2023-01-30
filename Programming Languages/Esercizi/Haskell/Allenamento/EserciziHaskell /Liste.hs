-- Es1: scrivere una funzione che data una lista ne costruisce una rimuovendo gli elementi di posizione pari
onlyOdd :: [a] -> [a]
onlyOdd = onlyOddAux True where
    onlyOddAux :: Bool -> [a] -> [a]
    onlyOddAux _  []= []
    onlyOddAux True (x:xs) = x : onlyOddAux False xs
    onlyOddAux False (x:xs) = onlyOddAux True xs

-- Es2: scrivere una funzione che calcola la somma degli elementi di posizione dispari di una lista.
sumOdd :: (Num a) => [a] -> a
sumOdd l = foldl (+) 0 (onlyOdd l)

-- Es3: Quicksort
quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = (quickSort [y | y <- xs, y < x]) ++ [x] ++ (quickSort [y | y <- xs, y > x])

-- Es4: scrivere una funzione che calcola i 2 minori elementi dispari di una lista (se esistono)
selectMinOdd :: (Integral a) => [a] -> Maybe (a,a)
selectMinOdd l = firstTwo (quickSort [elem | elem <- l, odd elem]) where
    firstTwo :: [a] -> Maybe (a,a)
    firstTwo l
        | length l < 2 = Nothing
        | otherwise = Just (head l, head (tail l))

-- Es5: scrivere una funzione che costruisce, a partire da una lista di numeri interi, una lista di coppie in cui
--  a) il primo elemento di ogni coppia è uguale all’elemento di corrispondente posizione nella lista originale
--  b) il secondo elemento di ogni coppia è uguale alla somma di tutti gli elementi conseguenti della lista originale.
makePairs :: (Integral a) => [a] -> [(a,a)]
makePairs l = [(l!!x, foldl (+) 0 (drop (x+1) l)) | x <- [0.. length l - 1]]

-- Es6: scrivere una funzione che costruisce, a partire da una lista di numeri interi
--  a) il primo elemento di ogni coppia è uguale all’elemento di corrispondente posizione nella lista originale
--  b) il secondo elemento di ogni coppia è uguale alla somma di tutti gli elementi antecedenti della lista originale
makePairs' :: (Integral a) => [a] -> [(a,a)]
makePairs' l = [(l!!x, foldl (+) 0 (take x l)) | x <- [0.. length l - 1]]

-- Es7: scrivere una funzione Haskell shiftToZero che data una lista costruisce un nuova lista che contiene gli elementi diminuiti del valore minimo.
-- La funzione non deve visitare gli elementi della lista più di una volta (si sfrutti la laziness).
shiftToZero :: (Num a, Ord a) => [a] -> [a]
shiftToZero [] = []
shiftToZero (x:xs) = snd (shiftToZeroAux (x, x:xs)) where
    shiftToZeroAux :: (Num a, Ord a) => (a,[a]) -> (a,[a])
    shiftToZeroAux (m, []) = (m, [])
    shiftToZeroAux (m, x:xs) = (min (fst (shiftToZeroAux (min x m, xs))) m, x - fst (shiftToZeroAux (min x m, xs)) : snd (shiftToZeroAux (min x m, xs)))

shiftToZero' :: (Num a, Ord a) => [a] -> [a]
shiftToZero' [] = []
shiftToZero' xs = zs
    where
    (mm, zs) = foldr aggr (head xs, []) xs
    aggr x (m, ys) = (min m x, x - mm : ys)

main :: IO ()
main = print (shiftToZero' [7,5,3,1,4,9,8])