-- 1. Si scriva la funzione fattoriale. Si verifichi il funzionamento calcolando 10000!.
fattoriale :: (Integral a) => a-> a
fattoriale n  
    | n <= 0 = 1
    | n > 0 = n * fattoriale (n-1)

fattoriale' :: (Integral a) => a -> a
fattoriale' n = foldl (\ acc new -> acc * new) 1 [2..n]

-- 2. Si scriva la funzione n su k , combinazioni di k elementi su n.
binomiale n k = div (fattoriale n) ((fattoriale (n - k)) * (fattoriale k))

-- 3. Si scriva una funzione che calcoli una lista con tutte le combinazioni su n elementi. Si usi opportunamente la map.
-- map :: (a -> b) -> [a] -> [b]
allComb :: (Integral a) => a -> [(a,a)]
allComb n = foldl (++) [] (map (\ x -> [(x,y) | y <- [1..n]]) [1..n])

-- in pratica map (\ x -> [(x,y) | y <- [1..n]]) [1..n] applica ad ogni elemento di [1..n] la funzione (\x -> [(x:y) | y <- [1..n]]), dove x viene preso da [1..n], pero' ritorna 
-- una lista di liste, ovvero [(1,1),(1,2)] , [(2,1),(2,2)] e quindi poi applicando il (++) io vado ad unirle in unica lista
-- funz n = map (\ x -> [(x,y) | y <- [1..n]]) [1..n] 
-- per comporre la lista uso una list comprehension a cui ci applico la map --> (map (\ x -> [(x,y)| y <- (1..n)]) [1..n])

isPalindroma :: (Eq a) => [a] -> Bool
isPalindroma lista = fst (foldl (\ (res,acc) new -> (res && (acc == new),last lista)) (True,(last lista)) lista)