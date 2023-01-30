import Data.ByteString (elemIndex)
-- 1. Scrivere una funzione che data una lista ne costruisce una rimuovendo gli elementi di posizione pari

rimuoviIndexPari :: (Integral a) => [a] -> [a]
rimuoviIndexPari lista = rimuoviIndexPariAux lista 1    --parte a contare la prima posizione come 1

rimuoviIndexPariAux :: (Integral a) => [a] -> a -> [a] --rimuove soltanto gli elementi di posizione pari
rimuoviIndexPariAux [] _ = []
rimuoviIndexPariAux (x:xs) index = if (mod index 2) == 0 then (rimuoviIndexPariAux xs (index + 1)) else (x:rimuoviIndexPariAux xs (index + 1))


-- 2. Scrivere una funzione che calcola la somma degli elementi di posizione dispari di una lista.

sommaDispari :: (Integral a) => [a] -> a
sommaDispari lista = foldl (+) 0 (rimuoviIndexPari lista)


-- 3. Scrivere il QuickSort (polimorfo).

quickSort :: (Integral a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = quickSort [y | y <- xs , y<x] ++ (x:quickSort[y | y <-xs, y>=x]) --lo applico sulla prima meta e sulla seconda meta


-- 4. Scrivere una funzione che calcola i 2 minori elementi dispari di una lista (se esistono). Ad esempio minOdd([2,3,4,6,8,7,5]) riduce a (3,5)

rimuoviElPari :: (Integral a) => [a] -> [a] --funzione per rimuovere gli elementi pari dalla lista
rimuoviElPari [] = []
rimuoviElPari (x:xs) = if (mod x 2 == 0) then (rimuoviElPari xs) else (x:rimuoviElPari xs)

trovaMinDispari :: (Integral a) => [a] -> [a] --prendo la lista, rimuovo i dispari e la riordino, ora i minimi sono i primi due valori
trovaMinDispari lista = [(head (quickSort (rimuoviElPari lista))), (head (tail (quickSort (rimuoviElPari lista))))]


-- 5. Scrivere una funzione che costruisce, a partire da una lista di numeri interi, una lista di coppie in cui
-- (a) il primo elemento di ogni coppia è uguale all’elemento di corrispondente posizione nella lista originale e
-- (b) il secondo elemento di ogni coppia è uguale alla somma di tutti gli elementi conseguenti (al primo elemento della coppia) della lista originale.

--faiCoppie :: (Integral a) => [a] -> [(a,a)]
faiCoppie lista = [(x, foldr (+) 0 (drop (getIndex lista x) lista))| x <- lista] --fisso la x e la y è la somma dei valori successivi a x

--getIndex ritorna la posizione di un elemento all'interno di una lista
getIndex :: (Integral a) => [a] -> a -> a
getIndex lista num = getIndexAux lista num 1

getIndexAux :: (Integral a) => [a] -> a -> a -> a
getIndexAux [] _ _ = -1
getIndexAux (x:xs) num pos = if (x == num) then pos else getIndexAux xs num (pos + 1) 


-- 6. Scrivere una funzione che costruisce, a partire da una lista di numeri interi (provate poi a genera- lizzare), una lista di coppie in cui
-- (a) il primo elemento di ogni coppia `e uguale all’elemento di corrispondente posizione nella lista originale e
-- (b) il secondo elemento di ogni coppia `e uguale alla somma di tutti gli elementi antecedenti della lista originale.

--faiCoppie' :: (Integral a) => [a] -> [(a,a)]
faiCoppie' lista = [(x, foldl (+) 0 (take ((getIndex lista x) - 1) lista) ) | x <- lista]   --prendo tutto l'array prima dell'indice


-- 7. Si scriva una funzione Haskell shiftToZero che data una lista costruisce un nuova lista che contiene gli elementi diminuiti del valore minimo.

shiftToZero :: (Integral a) => [a] -> [a]
shiftToZero lista = let min = minimum lista     --salvo il valore del minimo all'inizio 
                    in
                    map (\ x -> x-min) lista   --lo sottraggo da ogni cella 

