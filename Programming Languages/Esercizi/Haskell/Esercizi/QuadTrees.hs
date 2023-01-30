{-# LANGUAGE DatatypeContexts #-}
data (Eq a, Show a) => QT a = C a | Q (QT a) (QT a) (QT a) (QT a) deriving (Eq, Show)

-- Es1: si scriva una funzione buildNSimplify che dati 4 QuadTree costruisca un QuadTree la cui immagine codificata sia quella ottenuta dalle 4 immagini corrispondenti ai 4 QuadTree
--  messe nei quadranti superiore-sinistro, superiore-destro, inferiore-sinistro, inferiore-destro, rispettivamente.
buildNSimplify :: (Eq a, Show a) => QT a -> QT a -> QT a -> QT a -> QT a
buildNSimplify q1 q2 q3 q4 = if(q1 == q2 || q1 == q3 || q1 == q4) then q1 else Q q1 q2 q3 q4


-- Es2: si scriva una funzione simplify che dato un termine di tipo QT genera il QuadTree corrispondente.
simplify :: (Eq a, Show a) => QT a -> QT a
simplify (C a) = C a
simplify (Q a b c d) = if all (a==) [b,c,d] then simplify a else Q (simplify a) (simplify b) (simplify c) (simplify d)


-- Es3: si scriva una funzione map che data una funzione f e un QuadTree q determina il QuadTree che codifica l’immagine risultante dall’applicazione di f a tutti i pixel dell’immagine codificata da q.
qMap :: (Eq a, Show a, Eq b, Show b) => (a -> b) -> QT a -> QT b
qMap f (C val) = C (f val)  --applico f al valore del singolo quadTree
qMap f (Q a b c d) = Q (qMap f a) (qMap f b) (qMap f c) (qMap f d)


-- Es4: si scriva una funzione howManyPixels che dato un QuadTree determina il numero (minimo) di pixel di quell’immagine.
howManyPixels :: (Eq a, Show a) => QT a -> Int
howManyPixels (C a) = 1
howManyPixels (Q a b c d) = maximum [howManyPixels a, howManyPixels b, howManyPixels c, howManyPixels d] * 4


-- Es5: si scriva una funzione limitAll che dato un colore c e una lista di QuadTrees costruisca la lista dei QuadTrees che codificano le immagini i cui pixels sono limitati al colore c (pixel originale se il colore è < c, c altrimenti).
limitAll :: (Num a, Eq a, Show a, Ord a) => a -> [QT a] -> [QT a]
limitAll c = map (qMap (\ col -> if col > c then c else col))