{-# LANGUAGE DatatypeContexts #-}
data (Eq a, Show a) => QT a = C a | Q (QT a) (QT a) (QT a) (QT a) deriving (Eq, Show)

-- Es1: si scriva una funzione buildNSimplify che dati 4 QuadTree costruisca un QuadTree la cui immagine codificata sia quella ottenuta dalle 4 immagini corrispondenti ai 4 QuadTree
--  messe nei quadranti superiore-sinistro, superiore-destro, inferiore-sinistro, inferiore-destro, rispettivamente.
buildNSimplify :: (Eq a, Show a) => QT a -> QT a -> QT a -> QT a -> QT a
buildNSimplify a b c d = if all (a==) [b,c,d] then a else Q a b c d

-- Es2: si scriva una funzione simplify che dato un termine di tipo QT genera il QuadTree corrispondente.
simplify :: (Eq a, Show a) => QT a -> QT a
simplify (C a) = C a
simplify (Q a b c d) = if all (a==) [b,c,d] then simplify a else Q (simplify a) (simplify b) (simplify c) (simplify d)

-- Es3: si scriva una funzione map che data una funzione f e un QuadTree q determina il QuadTree che codifica l’immagine risultante dall’applicazione di f a tutti i pixel dell’immagine codificata da q.
qMap :: (Eq a, Show a, Eq b, Show b) => (a -> b) -> QT a -> QT b
qMap f (C val) = C (f val)
qMap f (Q a b c d) = Q (qMap f a) (qMap f b) (qMap f c) (qMap f d)

-- Es4: si scriva una funzione howManyPixels che dato un QuadTree determina il numero (minimo) di pixel di quell’immagine.
howManyPixels :: (Eq a, Show a) => QT a -> Int
howManyPixels (C a) = 1
howManyPixels (Q a b c d) = maximum [howManyPixels a, howManyPixels b, howManyPixels c, howManyPixels d] * 4

-- Es5: si scriva una funzione limitAll che dato un colore c e una lista di QuadTrees costruisca la lista dei QuadTrees che codificano le immagini i cui pixels sono limitati al colore c (pixel originale se il colore è < c, c altrimenti).
limitAll :: (Num a, Eq a, Show a, Ord a) => a -> [QT a] -> [QT a]
limitAll c = map (qMap (\ col -> if col > c then c else col))

-- Es6: si scriva una funzione occurrencies che dato un QuadTree ed un colore determina il numero (minimo) di pixel di quel colore
occurrencies :: (Eq a, Show a) => QT a -> a -> Int
occurrencies qTree col = qSum (howManyPixels qTree) (qMap (\ c -> if c == col then 1 else 0) qTree) where
    qSum :: Int -> QT Int -> Int
    qSum size (C val) = val * size
    qSum size (Q a b c d) = sum (map (qSum (div size 4)) [a,b,c,d])

-- Es7: si scriva una funzione Haskell difference che dato un colore c ed un QuadTree q determina la differenza fra il numero di pixel dell’immagine codificata da q che hanno un colore maggiore di c e quelli minori di c.
difference :: (Eq a, Show a, Ord a) => a -> QT a -> Int
difference col qTree = qSum (howManyPixels qTree) (qMap (\ c -> if c > col then 1 else (-1)) qTree) where
    qSum :: Int -> QT Int -> Int
    qSum size (C val) = val * size
    qSum size (Q a b c d) = sum (map (qSum (div size 4)) [a,b,c,d])

-- Es8: si scriva una funzione Haskell overColor che dato un colore c ed un QuadTree q determina il numero (minimo) di pixel dell’immagine codificata da q che hanno un colore maggiore di c.
overColor :: (Eq a, Show a, Ord a) => a -> QT a -> Int
overColor col qTree = qSum (howManyPixels qTree) (qMap (\ c -> if c > col then 1 else 0) qTree) where
    qSum :: Int -> QT Int -> Int
    qSum size (C val) = val * size
    qSum size (Q a b c d) = sum (map (qSum (div size 4)) [a,b,c,d])

-- Es9: si scriva una generalizzazione della funzione foldr delle liste per i termini di tipo QT che abbia il seguente tipo:
--      fold :: (Eq a, Show a) => (b->b->b->b->b) -> (a->b) -> QT a -> b
fold :: (Eq a, Show a) => (b->b->b->b->b) -> (a->b) -> QT a -> b
fold _ g (C val) = g val
fold f g (Q a b c d) = f (fold f g a) (fold f g b) (fold f g c) (fold f g d)

-- Es10: si scriva una funzione height che dato un QuadTree ne determina l’altezza usando opportunamente fold.
height :: (Eq a, Show a) => QT a -> Int
height = fold (\ a b c d -> maximum [a,b,c,d] + 1) (const 0)

-- Es11: si scriva una funzione length che dato un QuadTree ne determina il numero di nodi usando opportunamente fold.
length :: (Eq a, Show a) => QT a -> Int
length = fold (\ a b c d -> sum [a,b,c,d] + 1) (const 1)

-- Es12: si riscriva la funzione simplify dell’Esercizio 2 usando opportunamente fold.
simplify' :: (Eq a, Show a) => QT a -> QT a
simplify' = fold (\ a b c d -> if all (a==) [b,c,d] then a else Q a b c d) C

-- Es13: si riscriva la funzione map dell’Esercizio 3 usando opportunamente fold
qMap' :: (Eq a, Show a, Eq b, Show b) => (a -> b) -> QT a -> QT b
qMap' f = fold Q (C . f)

{-- DA TESTARE DA QUA IN POI!!!!!! --}

-- Es14: si scrivano due funzioni flipHorizontal/flipVertical che costruiscono il QuadTree dell’immagine simmetrica rispetto all’asse orizzontale/verticale.
flipHorizontal :: (Eq a, Show a) => QT a -> QT a
flipHorizontal = fold (\ a b c d -> Q b a d c) C

flipVertical :: (Eq a, Show a) => QT a -> QT a
flipVertical = fold (\ a b c d -> Q c d a b) C

-- Es15: si scrivano tre funzioni rotate90Right, rotate90Left e rotate180 che costruiscono il QuadTree dell’immagine ruotata di −π/2, +π/2 e π
rotate90Left :: (Eq a, Show a) => QT a -> QT a
rotate90Left = fold (\ a b c d -> Q b d a c) C

rotate90Right :: (Eq a, Show a) => QT a -> QT a
rotate90Right = fold (\ a b c d -> Q c a d b) C

rotate180 :: (Eq a, Show a) => QT a -> QT a
rotate180 = rotate90Left . rotate90Left

-- Es16: si scrivano tre predicati isHorizontalSymmetric, isVerticalSymmetric e isCenterSymmetric che determinano se un QuadTree codifica un’immagine simmetrica rispetto all’asse orizzontale, all’asse verticale o al centro.
isHorizontalSymmetric :: (Eq a, Show a) => QT a -> Bool
isHorizontalSymmetric tree = tree == flipHorizontal tree

isVerticalSymmetric :: (Eq a, Show a) => QT a -> Bool
isVerticalSymmetric tree = tree == flipVertical tree

isCenterSymmetric :: (Eq a, Show a) => QT a -> Bool
isCenterSymmetric tree = tree == flipHorizontal tree && tree == flipVertical tree

-- Es17: si scriva un predicato elem_or_mele che dati un QuadTree t e una lista di QuadTrees ts determina se
--  t, o il QuadTree che codifica l’immagine di t ribaltata rispetto all’asse orizzontale, sono elementi della lista ts.
elemOrMele :: (Eq a, Show a) => QT a -> [QT a] -> Bool
elemOrMele t ts = any (t ==) ts || any (flipHorizontal t ==) ts

-- Es18: si scriva un predicato isRotatedIn che dati un QuadTree t e una lista di QuadTrees ts
--  determina se uno dei QuadTrees che codificano l’immagine di t ruotata di 0, 90, 180 o 270 gradi è un elemento della lista ts.
isRotatedIn :: (Eq a, Show a) => QT a -> [QT a] -> Bool
isRotatedIn t ts = any (t ==) ts
    || any (rotate90Left t ==) ts
    || any (rotate90Left (rotate90Left t) ==) ts
    || any (rotate90Left (rotate90Left (rotate90Left t)) ==) ts

-- Es19: si riscriva la funzione howManyPixels dell’Esercizio 4 usando opportunamente fold.
howManyPixels' :: (Eq a, Show a) => QT a -> Int
howManyPixels' = fold (\ a b c d -> maximum [a,b,c,d] * 4) (const 1)

-- Es20: si riscriva la funzione occurrencies dell’Esercizio 6 usando opportunamente fold.
occurrencies' :: (Eq a, Show a) => QT a -> a -> Int
occurrencies' qTree col = fst (fold (\ a b c d -> let maxLev = maximum (map snd [a,b,c,d]) in (sum (map (\ (num,lev) -> 4^(maxLev-lev) * num) [a,b,c,d]),maxLev+1)) (\ c -> if c == col then (1,1) else (0,1)) qTree)

-- Es21: si scriva una funzione zipWith per QuadTrees che, analogamente alla zipWith per le liste, data un’operazione binaria ⊕ e due QuadTrees q1 e q2
--  costruisce il QuadTree che codifica l’immagine risultante dall’applicazione di ⊕ a tutti i pixel della stessa posizione nelle immagini codificate da q1 e q2.
zipWith' :: (Eq a, Show a, Eq b, Show b, Eq c, Show c) => (a->b->c) -> QT a -> QT b -> QT c
zipWith' op (C x) (C y) = C (op x y)
zipWith' op (Q a b c d) (C y) = Q (zipWith' op a (C y)) (zipWith' op b (C y)) (zipWith' op c (C y)) (zipWith' op d (C y))
zipWith' op (C x) (Q a b c d) = Q (zipWith' op (C x) a) (zipWith' op (C x) b) (zipWith' op (C x) c) (zipWith' op (C x) d)
zipWith' op (Q a1 b1 c1 d1) (Q a2 b2 c2 d2) = Q (zipWith' op a1 a2) (zipWith' op b1 b2) (zipWith' op c1 c2) (zipWith' op d1 d2)

-- Es22: si scriva una funzione Haskell insertPict che dati i QuadTrees di due immagini qt, qf ed un QuadTree “maschera” a valori booleani,
--  costruisce il QuadTree dell’immagine risultante mantenendo i pixel di qt in corrispondenza del valore True (della maschera) oppure di qf in corrispondenza del valore False.
insertPict :: (Eq a, Show a) => QT a -> QT a -> QT Bool -> QT a
insertPict (C x) (C y) (C bool) = C (if bool then x else y)
insertPict qt qf mask = Q (insertPict (first qt) (first qf) (first mask)) (insertPict (second qt) (second qf) (second mask)) (insertPict (third qt) (third qf) (third mask)) (insertPict (fourth qt) (fourth qf) (fourth mask)) where
    first :: (Eq a, Show a) => QT a -> QT a
    first (C a) = C a
    first (Q a b c d) = a
    second :: (Eq a, Show a) => QT a -> QT a
    second (C a) = C a
    second (Q a b c d) = b
    third :: (Eq a, Show a) => QT a -> QT a
    third (C a) = C a
    third (Q a b c d) = c
    fourth :: (Eq a, Show a) => QT a -> QT a
    fourth (C a) = C a
    fourth (Q a b c d) = d

-- Es23: si scriva una funzione Haskell insertLogo che dati i QuadTrees di due immagini ql, qp ed un QuadTree “maschera” a valori booleani,
--  costruisce il QuadTree dell’immagine risultante inserendo la figura ql all’interno del quadrante marcato ⋆ di qp scegliendo i pixel di ql o qp in corrispondenza del valore True o False della maschera.
insertLogo :: (Eq a, Show a) => QT a -> QT a -> QT Bool -> QT a
insertLogo logo picture mask = insertPict picture (adjust logo mask) mask where
    adjust :: (Eq a, Show a) => QT a -> QT Bool -> QT a
    adjust logo (C _) = logo
    adjust logo (Q a b c d) = Q (adjust logo a) (adjust logo b) (adjust logo c) (adjust logo d)

-- Es24: si scriva una funzione Haskell commonPoints che data una lista non-vuota di QuadTrees l costruisce il QuadTree “maschera”, a valori booleani,
--  che ha “un pixel” a True se nella medesima posizione tutte le immagini di l hanno pixels uguali, False altrimenti
commonPoints :: (Eq a, Show a) => [QT a] -> QT Bool
commonPoints [] = C False
commonPoints (x:xs) = snd (foldl (\ (first, bool) new -> (first, zipWith' (&&) (zipWith' (==) first new) bool)) (x, C True) xs)

-- Es25: si scriva un predicato framed che dato un predicato sui colori p ed un QuadTree determina se il bordo esterno dell’immagine codificata è tutto composto da pixels che soddisfano p.
framed :: (Eq a, Show a) => (a -> Bool) -> QT a -> Bool
framed f tree = checkUpperBorder f tree && checkLeftBorder f tree && checkRightBorder f tree && checkLowerBorder f tree where
    checkUpperBorder :: (Eq a, Show a) => (a -> Bool) -> QT a -> Bool
    checkUpperBorder f (C col) = f col
    checkUpperBorder f (Q a b c d) = checkUpperBorder f a && checkUpperBorder f b
    checkLowerBorder :: (Eq a, Show a) => (a -> Bool) -> QT a -> Bool
    checkLowerBorder f (C col) = f col
    checkLowerBorder f (Q a b c d) = checkLowerBorder f c && checkLowerBorder f d
    checkLeftBorder :: (Eq a, Show a) => (a -> Bool) -> QT a -> Bool
    checkLeftBorder f (C col) = f col
    checkLeftBorder f (Q a b c d) = checkLeftBorder f a && checkLeftBorder f c
    checkRightBorder :: (Eq a, Show a) => (a -> Bool) -> QT a -> Bool
    checkRightBorder f (C col) = f col
    checkRightBorder f (Q a b c d) = checkRightBorder f b && checkRightBorder f d

-- Es26: si scriva una funzione frame che dato un QuadTree restituisca Just c se il bordo esterno dell’immagine codificata è tutto composto da pixels di colore c
--  (Nothing altrimenti).
frame :: (Eq a, Show a) => QT a -> Maybe a
frame tree = if framed (== topLeftCorner tree) tree then Just (topLeftCorner tree) else Nothing where
    topLeftCorner :: (Eq a, Show a) => QT a -> a
    topLeftCorner (C col) = col
    topLeftCorner (Q a b c d) = topLeftCorner a

prova = let d = C 2; u = C 1; q = Q d u u u in occurrencies (Q q (C 0) (C 3) q) 1 == occurrencies' (Q q (C 0) (C 3) q) 1


main :: IO()
main = print (prova)

    