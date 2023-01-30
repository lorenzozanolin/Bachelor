-- Es1: Si scriva la funzione fattorial. Si verifichi il funzionamento calcolando 10000!
factorial :: (Integral a) => a -> a
factorial n
    | n <= 0 = 1
    | otherwise = n * factorial (n-1)

factorial' :: (Integral a) => a -> a
factorial' n = foldl (*) 1 [2..n]

-- Es2: Si scriva la funzione per calcolare il coefficiente binomiale (n k)
binCoeff :: (Integral a) => a -> a -> a
binCoeff n 0 = 1
binCoeff n k
    | n == k = 1
    | otherwise = (binCoeff (n-1) (k-1)) + (binCoeff (n-1) k)

binCoeff' :: (Integral a) => a -> a -> a
binCoeff' n k = div (factorial n) (factorial k * factorial (n-k))

-- Es3: Si scriva una funzione che calcoli una lista con tutte le combinazioni su n elementi. Si usi opportunamente map.
allComb :: (Integral a) => a -> [(a,a)]
allComb x = foldl (++) [] (map (\ m -> [(m,n) | n <- [1..x]]) [1..x])

main :: IO ()
main = print (allComb 4)

