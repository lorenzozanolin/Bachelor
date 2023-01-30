-- Es1: si scriva una funzione matrix_dim che data una matrice ne calcola le dimensioni, se la matrice è ben formata, altrimenti restituisce (-1,-1)
matrixDim :: [[a]] -> (Int, Int)
matrixDim m = case matrixDimAux m of
    Just dim -> dim
    Nothing -> (-1,-1)

matrixDimAux :: [[a]] -> Maybe (Int, Int)
matrixDimAux [] = Just (0,0)
matrixDimAux (x:xs) =
    let n = foldl (\ acc new -> if (length new) == acc then acc else -1) (length x) xs
    in if n == -1 then Nothing else Just (length (x:xs), n)

-- Es2: si scriva una funzione columns che data una matrice calcola il vettore delle somme delle colonne
columns :: (Num a) => [[a]] -> [a]
columns [] = []
columns m = [ foldl (+) 0 [m!!j!!i | j <- [0..length m - 1]] | i <- [0..length (head m) - 1]]

-- Es3: si scriva una funzione colaltsums che, data una matrice implementata come liste di liste per righe, calcola il vettore delle somme a segni alternati delle colonne della matrice
colaltsums :: (Num a) => [[a]] -> [a]
colaltsums [] = []
colaltsums m = [ snd (foldl (\ acc new -> (-1 * fst acc, (new * fst acc) + snd acc)) (1,0) [m!!j!!i | j <- [0..length m - 1]]) | i <- [0..length (head m) - 1]]

-- Es4: si scriva una funzione colMinMax che, data una matrice implementata come liste di liste per righe, calcola il vettore delle coppie (minimo,massimo) delle colonne della matrice
colMinMax :: (Num a, Ord a) => [[a]] -> [(a,a)]
colMinMax [] = []
colMinMax m = [ foldl (\ acc new -> (min (fst acc) new, max (snd acc) new)) (m!!0!!i, m!!0!!i) [m!!j!!i | j <- [1..length m - 1]] | i <- [0..length (head m) - 1]]

-- Es5: si scriva un predicato lowertriangular che determina se una matrice (quadrata) è triangolare inferiore
lowertriangular :: (Num a, Eq a) => [[a]] -> Bool
lowertriangular [] = True
lowertriangular m = foldl (\ acc new -> acc && new == 0) True [m!!j!!i | j <- [0..length m - 1], i <- [j+1..length m - 1]]

--Es6: si scriva un predicato uppertriangular che determina se una matrice (quadrata) è triangolare superiore.
uppertriangular :: (Num a, Eq a) => [[a]] -> Bool
uppertriangular [] = True
uppertriangular m = foldl (\ acc new -> acc && new == 0) True [m!!j!!i | j <- [1..length m - 1], i <- [0..j-1]]

-- Es7: si scriva un predicato diagonal che determina se una matrice (quadrata) è diagonale.
diagonal :: (Num a, Eq a) => [[a]] -> Bool
diagonal [] = True
diagonal m = foldl (\ acc new -> acc && new == 0) True [m!!j!!i | j <- [0..length m - 1], i <- [0..length m - 1], i /= j]

-- Es8: una matrice quadrata M di ordine n si dice convergente con raggio r se il modulo della somma degli elementi di ogni riga, escluso quello sulla diagonale, è inferiore a r
--  Si scriva un predicato convergent m r che determina se una matrice (quadrata) m è convergente con raggio r
convergent :: (Num a, Ord a) => [[a]] -> a -> Bool
convergent [] _ = True
convergent m r = foldl (\ acc new -> acc && new < r) True [ abs (sum [m!!j!!i | j <- [0..length m - 1], i /= j]) | i <- [0..length m - 1] ]

-- Es9: si scriva una funzione che data una matrice di dimensioni m × n restituisce la corrispondente matrice trasposta (di dimensioni n × m)
transpose :: [[a]] -> [[a]]
transpose [] = []
transpose m = [ [ m!!i!!j | i <- [0..length m - 1] ] | j <- [0..length (head m) - 1] ]

-- Es10: si scriva un predicato isSymmetric che, data una matrice quadrata, determina se è simmetrica
isSymmetric :: (Eq a) => [[a]] -> Bool
isSymmetric [] = True
isSymmetric m = foldl (\ acc (a,b) -> acc && m!!a!!b == m!!b!!a) True [(i,j) | i <- [0..length m - 1], j <- [i+1..length m - 1], i /= j]

-- Es11: si scriva una funzione che data una matrice di dimensioni n × k ed una k × m restituisca la matrice prodotto corrispondente (di dimensioni n × m).
--  Si assuma di moltiplicare matrici con dimensioni compatibili e (se facesse comodo) matrici non degeneri.
dotProduct :: (Num a) => [[a]] -> [[a]] -> [[a]]
dotProduct m1 m2 = [ [ vectorProduct (row m1 i) (column m2 j) | j <- [0..length (head m2) - 1] ] | i <- [0..length m1 - 1] ] where
    column :: (Num a) => [[a]] -> Int -> [a]
    column m i = [ m!!j!!i | j <-[0..length m - 1]]
    row :: (Num a) => [[a]] -> Int -> [a]
    row m i = m!!i
    vectorProduct :: (Num a) => [a] -> [a] -> a
    vectorProduct v1 v2 = foldl (+) 0 [ x1*x2 | (x1,x2) <- zip v1 v2 ]

main :: IO()
main = print ( dotProduct [[1,0,2],[0,3,-1]] [[4,1],[-2,2],[0,3]] )

