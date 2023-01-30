-- 1. Si scriva una funzione matrix_dim che data una matrice ne calcola le dimensioni, se la matrice è ben formata, altrimenti restituisce (-1,-1).
-- una matrice è una lista di liste, quindi ogni elemento della lista è una lista a sua volta

matrixDim matrice = (foldl (\ acc new -> acc + 1) 0  matrice,   -- conto le righe
                    foldl (\ acc new -> if ((length new) == acc) then acc else -1) (length (head matrice)) (tail matrice)) --conto le colonne


-- 2. Si scriva una funzione colsums che data una matrice calcola il vettore delle somme delle colonne.

-- 1 2 3    salvata per colonna => [[1,4],[2,5],[3,6]]
-- 4 5 6    salvata per riga => [[1,2,3],[4,5,6]]

-- salvata per colonna 
sommaColonne :: (Integral a) => [[a]] -> [a]
sommaColonne (x:xs) =  (sum x):sommaColonne xs
sommaColonne [] = []

-- versione alternativa con fold

sommaColonne'' :: (Integral a) => [[a]] -> [a]
sommaColonne'' matrice = (foldl (\ acc new -> acc ++ [(sum new)]) [] matrice)   --l'accumulatore conterrà ogni volta la lista di liste e new sarà una lista, con sum ottengo la sommatoria dei suoi elementi

-- salvata per righe
sommaColonne''' :: (Integral a) => [[a]] -> [a]
sommaColonne''' matrice = foldl (\ acc new -> (sommaCoppia acc new)) [] matrice --l'accumulatore sarà una lista che conterrà per ogni colonna la somma parziale, che verrà fatta con la procedura sommaCoppia

sommaCoppia :: (Integral a) => [a] -> [a] -> [a] -- somma due a due i vettori riga
sommaCoppia (x:xs) (y:ys) = (x + y) : (sommaCoppia xs ys)
sommaCoppia [] b = b
sommaCoppia a [] = a


--3. Si scriva una funzione colaltsums che, data una matrice implementata come liste di liste per righe, calcola il vettore delle somme a segni alternati delle colonne della matrice.

--colAltSum :: (Floating a) => [[a]] -> [a]
--colAltSum matrice = sommaColonne''' (modificaSegno matrice)

modificaSegno :: (Floating a) => [[a]] -> [[a]] --funzione che moltiplica i valori della matrice
modificaSegno matrice = modificaSegnoAux matrice 2  -- la funzione richiama la funzione ausiliaria passando 2 come valore iniziale della i

modificaSegnoAux :: (Floating a) => [[a]] -> a -> [[a]]
modificaSegnoAux (x:xs) i = (prodottoRiga x ((-1)**i)) : (modificaSegnoAux xs (i+1))    -- per ogni elemento della matrice (ovvero una riga) lui moltiplica il valore per (-1)^i e concatena al successivo
modificaSegnoAux [] _ = []

prodottoRiga :: (Floating a) => [a] -> a -> [a] -- moltiplica per -1 tutti gli elementi
prodottoRiga (x:xs) a = (x*a):prodottoRiga xs a
prodottoRiga [] _ = []


-- 4. Si scriva una funzione colMinMax che, data una matrice implementata come liste di liste per righe, calcola il vettore delle coppie (minimo,massimo) delle colonne della matrice.

colMinMax :: (Integral a) => [[a]] -> [(a,a)]
colMinMax matrice = foldl(\ acc new ->(calcolaMaxMin new acc) ) [] matrice  -- l'accumulatore ogni volta ha struttura [(min,max),(min,max),...] 

calcolaMaxMin :: (Ord a) => [a] -> [(a,a)] -> [(a,a)]   --funzione che date due liste ritorna la lista con (massimo, minimo) per ogni colonna, la prima lista ha struttura [x,y,z,..] la seconda ha struttura [(max,min),(max,min),(max,min)...]
calcolaMaxMin (x:xs) (y:ys) = ((min x (fst y)),(max x (snd y))) : (calcolaMaxMin xs ys)  --ogni volta si salva nella coppia del minimo il min tra il valore delle due liste (nella seconda lista che contiene coppie il minimo è il primo membro)
calcolaMaxMin [] [] = []
calcolaMaxMin (x:xs) [] = (x,x) : (calcolaMaxMin xs [])  -- per il caso iniziale in cui si passa una lista senza coppie e ritorna la lista con le coppie, gestisce il primo passo della fold


-- 5. Si scriva un predicato lowertriangular che determina se una matrice (quadrata) è triangolare inferiore

lowerTriangular :: (Integral a) => [[a]] -> Bool
lowerTriangular matrice = lowerAux matrice ((length matrice) - 1)

-- ogni volta prendo gli ultimi (n-1) elementi di una lista (colonna) e controllo che il loro prodotto sia 0
lowerAux [] _ = True
lowerAux _ 0 = True
lowerAux (x:xs) i = if (sum (drop ((length x)-i) x) == 0) then (True && (lowerAux xs (i-1))) else False


-- 6. Si scriva un predicato uppertriangular che determina se una matrice (quadrata) `e triangolare superiore.

upperTriangular :: (Integral a) => [[a]] -> Bool
upperTriangular matrice = upperAux matrice 0

-- ogni volta prendo gli ultimi (n-1) elementi di una lista (colonna) e controllo che il loro prodotto NON sia 0
upperAux [] _ = True
upperAux _ 0 = True
upperAux (x:xs) i = if (sum (take i x) /= 0) then (True && (upperAux xs (i-1))) else False

-- 7. Si scriva un predicato diagonal che determina se una matrice (quadrata) è diagonale => se è sia t.sup che t.inf
diagonal :: (Integral a) => [[a]] -> Bool
diagonal matrice = (upperTriangular matrice) && (lowerTriangular matrice) 