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
--onDiag serve per capire se l'elemento è sulla diagonale o no -> sulla diagonale devono essere triangolari superiori, sotto tutte nulle e sopra va bene tutto

-- Es3: si scriva un predicato diagonal che determina se una matrice è diagonale.
diagonal :: (Eq a, Show a, Num a) => Mat a -> Bool  -- se è sia triangolare superiore che triangolare inferiore
diagonal matrice = lowertriangular matrice && uppertriangular matrice
