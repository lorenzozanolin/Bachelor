{-# LANGUAGE DatatypeContexts #-}
import Distribution.Simple.Command (OptDescr(BoolOpt))
data (Eq a, Show a) => QT a = C a | Q (QT a) (QT a) (QT a) (QT a) deriving (Eq, Show)
data (Eq a, Num a, Show a) => Mat a = Mat { nexp :: Int, mat :: QT a } deriving (Eq, Show)

-- Es1: si scriva un predicato lowertriangular che determina se una matrice è triangolare inferiore.
lowertriangular :: (Eq a, Show a, Num a) => Mat a -> Bool
lowertriangular matrix = (nexp matrix == 0) || checkIfLowerTriangular (mat matrix) (nexp matrix) True where
    checkIfLowerTriangular :: (Eq a, Show a, Num a) => QT a -> Int -> Bool -> Bool
    checkIfLowerTriangular (C a) _ _ = a == 0
    checkIfLowerTriangular (Q a b c d) 1 onDiag = if onDiag then checkIfLowerTriangular c 0 onDiag else all (\ quarter -> checkIfLowerTriangular quarter 0 onDiag) [a,b,c,d]
    checkIfLowerTriangular (Q a b c d) n onDiag = (n > 1) && (checkIfLowerTriangular a (n-1) onDiag && checkIfLowerTriangular b (n-1) False && checkIfLowerTriangular d (n-1) onDiag) && (not onDiag || checkIfLowerTriangular c (n-1) onDiag)

-- Es2: si scriva un predicato uppertriangular che determina se una matrice è triangolare superiore.
uppertriangular :: (Eq a, Show a, Num a) => Mat a -> Bool
uppertriangular matrix = (nexp matrix == 0) || checkIfUpperTriangular (mat matrix) (nexp matrix) True where
    checkIfUpperTriangular :: (Eq a, Show a, Num a) => QT a -> Int -> Bool -> Bool
    checkIfUpperTriangular (C a) _ _ = a == 0
    checkIfUpperTriangular (Q a b c d) 1 onDiag = if onDiag then checkIfUpperTriangular c 0 onDiag else all (\ quarter -> checkIfUpperTriangular quarter 0 onDiag) [a,b,c,d]
    checkIfUpperTriangular (Q a b c d) n onDiag = (n > 1) && (checkIfUpperTriangular a (n-1) onDiag && checkIfUpperTriangular c (n-1) False && checkIfUpperTriangular d (n-1) onDiag) && (not onDiag || checkIfUpperTriangular b (n-1) onDiag)

-- Es3: si scriva un predicato diagonal che determina se una matrice è diagonale.
diagonal :: (Eq a, Show a, Num a) => Mat a -> Bool
diagonal matrix = (nexp matrix == 0) || checkIfDiagonal (mat matrix) (nexp matrix) True where
    checkIfDiagonal :: (Eq a, Show a, Num a) => QT a -> Int -> Bool -> Bool
    checkIfDiagonal (C a) _ _ = a == 0
    checkIfDiagonal (Q a b c d) 1 onDiag = if onDiag then checkIfDiagonal b 0 onDiag && checkIfDiagonal c 0 onDiag else all (\ quarter -> checkIfDiagonal quarter 0 onDiag) [a,b,c,d]
    checkIfDiagonal (Q a b c d) n onDiag = (n > 1) && checkIfDiagonal a (n-1) onDiag && checkIfDiagonal b (n-1) False && checkIfDiagonal c (n-1) False && checkIfDiagonal d (n-1) onDiag

-- Es4: si scriva una funzione matSum che date 2 matrici calcoli la matrice somma.
matSum :: (Eq a, Show a, Num a) => Mat a -> Mat a -> Mat a
matSum matrix1 matrix2 = Mat (max (nexp matrix1) (nexp matrix2)) (zipWith' (+) (mat matrix1) (mat matrix2))

zipWith' :: (Eq a, Show a, Eq b, Show b, Eq c, Show c) => (a->b->c) -> QT a -> QT b -> QT c
zipWith' op (C x) (C y) = C (op x y)
zipWith' op (Q a b c d) (C y) = Q (zipWith' op a (C y)) (zipWith' op b (C y)) (zipWith' op c (C y)) (zipWith' op d (C y))
zipWith' op (C x) (Q a b c d) = Q (zipWith' op (C x) a) (zipWith' op (C x) b) (zipWith' op (C x) c) (zipWith' op (C x) d)
zipWith' op (Q a1 b1 c1 d1) (Q a2 b2 c2 d2) = Q (zipWith' op a1 a2) (zipWith' op b1 b2) (zipWith' op c1 c2) (zipWith' op d1 d2)

-- Es5: si scriva una funzione matMul che date 2 matrici calcoli la matrice prodotto.
matMul :: (Eq a, Show a, Num a) => Mat a -> Mat a -> Mat a
matMul matrix1 matrix2 = Mat (max (nexp matrix1) (nexp matrix2)) (multiply (mat matrix1) (mat matrix2)) where
    multiply :: (Eq a, Show a, Num a) => QT a -> QT a -> QT a
    multiply (C x) (C y) = C (x*y)
    multiply (Q a b c d) (C y) = Q (zipWith' (+) (multiply a (C y)) (multiply b (C y))) (zipWith' (+) (multiply a (C y)) (multiply b (C y))) (zipWith' (+) (multiply c (C y)) (multiply d (C y))) (zipWith' (+) (multiply c (C y)) (multiply d (C y)))
    multiply (C x) (Q a b c d) = Q (zipWith' (+) (multiply (C x) a) (multiply (C x) c)) (zipWith' (+) (multiply (C x) a) (multiply (C x) c)) (zipWith' (+) (multiply (C x) b) (multiply (C x) d)) (zipWith' (+) (multiply (C x) b) (multiply (C x) d))
    multiply (Q a1 b1 c1 d1) (Q a2 b2 c2 d2) = Q (zipWith' (+) (multiply a1 a2) (multiply b1 c2)) (zipWith' (+) (multiply a1 b2) (multiply b1 d2)) (zipWith' (+) (multiply c1 a2) (multiply d1 c2)) (zipWith' (+) (multiply c1 b2) (multiply d1 d2))

-- Es6: si scriva una funzione zong che, dati due valori x, y e una matrice A, calcola la matrice xA − yI (dove I è la matrice unitaria della giusta dimensione).
zong :: (Eq a, Show a, Num a) => a -> a -> Mat a -> Mat a
zong x y matrix = matSum (mMap (* x) matrix) (mMap (* (-y)) (createIdentity (nexp matrix))) where
    mMap :: (Eq a, Show a, Num a, Eq b, Show b, Num b) => (a -> b) -> Mat a -> Mat b
    mMap f matrix = Mat (nexp matrix) (qMap f (mat matrix)) where
        qMap :: (Eq a, Show a, Eq b, Show b) => (a -> b) -> QT a -> QT b
        qMap f (C val) = C (f val)
        qMap f (Q a b c d) = Q (qMap f a) (qMap f b) (qMap f c) (qMap f d)
    createIdentity :: (Eq a, Show a, Num a) => Int -> Mat a
    createIdentity n = Mat n (createIdentityAux n) where
        createIdentityAux :: (Eq a, Show a, Num a) => Int -> QT a
        createIdentityAux 0 = C 1
        createIdentityAux n = Q (createIdentityAux (n-1)) (C 0) (C 0) (createIdentityAux (n-1))

-- Es7: si scriva una funzione f che, dati un vettore v e una matrice A, calcola lo scalare vAv^T.
f :: (Eq a, Show a, Num a) => [a] -> Mat a -> a
f v a = takeTopLeft (mat (matMul (matMul (adapt v) a) (adaptAndRotate v))) where
    adapt :: (Eq a, Show a, Num a) => [a] -> Mat a
    adapt v = let size = length v in  Mat size (adaptAux size v) where
        adaptAux 0 [x] = C x
        adaptAux n xs = Q (adaptAux (div n 2) (take (div n 2) xs)) (C 0) (adaptAux (div n 2) (drop (div n 2) xs)) (C 0)
    adaptAndRotate :: (Eq a, Show a, Num a) => [a] -> Mat a
    adaptAndRotate v = let size = length v  in  Mat size (adaptAux size v) where
        adaptAux 0 [x] = C x
        adaptAux n xs = Q (adaptAux (div n 2) (take (div n 2) xs)) (adaptAux (div n 2) (drop (div n 2) xs)) (C 0) (C 0)
    takeTopLeft :: (Eq a, Show a, Num a) => QT a -> a
    takeTopLeft (C val) = val
    takeTopLeft (Q a b c d) = takeTopLeft a

-- Es8: si scriva una funzione colSums che data una matrice calcola il vettore delle somme delle colonne della matrice.
colSums :: (Eq a, Show a, Num a) => Mat a -> [a]
colSums matrix = colSumsAux (nexp matrix) (mat matrix) where
    colSumsAux :: (Eq a, Show a, Num a) => Int -> QT a -> [a]
    colSumsAux n (C val) = replicate (2^n) ((2^n) * val)
    colSumsAux n (Q a b c d) = zipWith (+) (colSumsAux (n-1) a) (colSumsAux (n-1) c) ++ zipWith (+) (colSumsAux (n-1) b) (colSumsAux (n-1) d)

-- Es9: si scriva una funzione rowSums che data una matrice calcola il vettore delle somme delle righe della matrice.
rowSums :: (Eq a, Show a, Num a) => Mat a -> [a]
rowSums matrix = rowSumsAux (nexp matrix) (mat matrix) where
    rowSumsAux :: (Eq a, Show a, Num a) => Int -> QT a -> [a]
    rowSumsAux n (C val) = replicate (2^n) ((2^n) * val)
    rowSumsAux n (Q a b c d) = zipWith (+) (rowSumsAux (n-1) a) (rowSumsAux (n-1) b) ++ zipWith (+) (rowSumsAux (n-1) c) (rowSumsAux (n-1) d)

-- Es10: si scriva una funzione colMinMax che data una matrice calcola il vettore delle coppie (minimo,massimo) delle colonne della matrice.
colMinMax :: (Eq a, Show a, Num a, Ord a) => Mat a -> [(a,a)]
colMinMax matrix = colMinMaxAux (nexp matrix) (mat matrix) where
    colMinMaxAux :: (Eq a, Show a, Num a, Ord a) => Int -> QT a -> [(a,a)]
    colMinMaxAux n (C val) = replicate (2^n) (val, val)
    colMinMaxAux n (Q a b c d) = let f = (\ (min1, max1) (min2, max2) -> (min min1 min2, max max1 max2)) in zipWith f (colMinMaxAux (n-1) a) (colMinMaxAux (n-1) c) ++ zipWith f (colMinMaxAux (n-1) b) (colMinMaxAux (n-1) d)

-- Es11: si scriva una funzione colVar che, data una matrice, calcola il vettore delle variazioni delle colonne della matrice.
colVar :: (Eq a, Show a, Num a, Ord a) => Mat a -> [a]
colVar matrix = map (\ (min, max) -> max - min) (colMinMax matrix)

-- Es12: si scriva una funzione colAltSums che calcola il vettore delle somme a segni alternati delle colonne della matrice.
colAltSums :: (Eq a, Show a, Num a) => Mat a -> [a]
colAltSums matrix = colAltSumsAux (nexp matrix) (mat matrix) where
    colAltSumsAux :: (Eq a, Show a, Num a) => Int -> QT a -> [a]
    colAltSumsAux n (C val) = if n == 0 then [val] else replicate (2^n) 0
    colAltSumsAux 1 (Q (C a) (C b) (C c) (C d)) = [a-c, b-d]
    colAltSumsAux n (Q a b c d) = zipWith (+) (colAltSumsAux (n-1) a) (colAltSumsAux (n-1) c) ++ zipWith (+) (colAltSumsAux (n-1) b) (colAltSumsAux (n-1) d)

-- Es13: si scriva una funzione transpose che calcola la matrice trasposta.
transpose :: (Eq a, Show a, Num a) => Mat a -> Mat a
transpose matrix = Mat (nexp matrix) (transposeAux (mat matrix)) where
    transposeAux :: (Eq a, Show a, Num a) => QT a -> QT a
    transposeAux (C val) = C val
    transposeAux (Q a b c d) = Q (transposeAux a) (transposeAux c) (transposeAux b) (transposeAux d)

-- Es14: si scriva un predicato isSymmetric che determina se una matrice è simmetrica.
isSymmetric :: (Eq a, Show a, Num a) => Mat a -> Bool
isSymmetric matrix = matrix == transpose matrix

-- Es15: si scriva una funzione foldMat con tipo
--      foldMat :: (Num a) => (Int -> b -> b -> b -> b -> b) -> (Int -> a -> b) -> Mat a -> b
foldMat :: (Eq a, Show a, Num a) => (Int -> b -> b -> b -> b -> b) -> (Int -> a -> b) -> Mat a -> b
foldMat f g matrix = foldMatAux f g (mat matrix) (nexp matrix) where
    foldMatAux :: (Eq a, Show a, Num a) => (Int -> b -> b -> b -> b -> b) -> (Int -> a -> b) -> QT a -> Int -> b
    foldMatAux _ g (C val) n = g n val
    foldMatAux f g (Q a b c d) n = f n (foldMatAux f g a (n-1)) (foldMatAux f g b (n-1)) (foldMatAux f g c (n-1)) (foldMatAux f g d (n-1))

prova = let z=C 0; u=C 1; d=C 2 in colAltSums $ Mat 3 $ Q (Q (Q u u d d) d d (Q u u d d)) z u d

main :: IO()
main = print prova

