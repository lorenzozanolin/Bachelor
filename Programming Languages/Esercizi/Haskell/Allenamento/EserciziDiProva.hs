fattoriale 0 = 1    --definisco la funzione a tratti (per casi), CASO BASE
fattoriale n = n * fattoriale (n-1) -- PASSO INDUTTIVO

descriviLista [] = "lista vuota" --caso base, ovvero quando diamo in input una lista vuota
descriviLista [_] = "C'è un solo elemento"
descriviLista _ = "Lista lunga"

-- il _ serve a dire che il contenuto può essere lo stesso
-- funzione che mi ritorna la lunghezza di una lista che riceve in input
length' [] = 0
length' (x:xs) = 1 + length' xs -- lista composta da ALMENO un elemento (xs può essere anche vuota)

-- ESERCIZI PER IMPARARE LA SINTASSI

-- liste
head' [] = error "Lista vuota" 
head' (x:_) = x

tail' [] = error "Lista vuota"
tail' (_:xs) = xs

last' [] = error "Lista vuota"
last' xs = head'(reverse xs)

--ritorna tutta la testa, ovvero la lista senza l'ultimo elemento
init' [] = error "Lista vuota"
init' [x] = [] --caso base, ovvero in cui ho solo un elemento (ovvero l'ultimo), perciò la init ritorna nullo
init' (x:xs) = x:init' xs

-- ritorna i primi n elementi di una lista
take' _ [] = []
take' 0 _ = []
take' n (x:xs) = x:take' (n-1) xs
   
-- elimina i primi n elementi di una lista    
drop' n (x:xs)
    | null (x:xs) = []  --caso base, controllo se la lista è vuota
    | n > 0 = drop' (n-1) xs
    | otherwise = xs

--controlla se la lista è vuota
null' (x:xs) = False
null' [] = True

-- inverte la lista
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

--cerca l'elemento in posizione i
elemAt lista i = elemAux lista i 0
elemAux (x:xs) i count 
                |   count == i = [x]
                |   count < i = elemAux xs i (count+1)
                |   otherwise = error "indice troppo grande"

--cerco se l'elemento e è presente nella lista
elem' [] _ = error "Elemento non trovato"
elem' (x:xs) e = if e == x then True else elem' xs e

--costruisce una lista contenente n volte l'elemento x
replicate' 0 _ = []
replicate' n x = x:replicate' (n-1) x 

--ritorna il massimo contenuto nella lista
maximum' lista
    | null lista = error "lista vuota"
    | otherwise = maximumAux lista 0

maximumAux lista maxAttuale 
        -- | null (x:xs) = maxAttuale  => NON VA BENE PERCHE' (x:xs) PER DEFINIZIONE E' SEMPRE NON NULLA
        | null lista = maxAttuale
        | head' lista > maxAttuale = maximumAux (tail' lista) (head' lista)
        | otherwise = maximumAux (tail' lista) maxAttuale

--ritorna il minimo contenuto nella lista
minimum' lista
    | null lista = error "lista vuota"
    | otherwise = minimumAux lista 100

minimumAux lista minAttuale
    | null lista = minAttuale
    | (head' lista) < minAttuale = minimumAux (tail' lista) (head' lista)
    | otherwise = minimumAux (tail' lista) minAttuale

--esegue la sommatoria di tutti gli elementi nella lista
sum' [] = error "lista vuota"
sum' [x] = x
sum' (x:xs) = x + sum' xs 

--esegue la produttoria
product' [] = error "lista vuota"
product' [x] = x
product' (x:xs) = x * product' xs

-- tuple
fst' (a,_) = a
snd' (_,a) = a

-- crea una lista fondendone due (vince la più corta)
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

--unzip transforms a list of pairs into a list of first components and a list of second components.
unzip' [] = ([],[])
unzip' ((a,b):xs) = (a:fst' (unzip' xs),b:snd' (unzip' xs)) 
