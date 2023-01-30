--1. Date due liste, costruire la lista di tutte le possibili coppie: elemento della prima lista, elemento della seconda
-- Definire il tipo delle funzioni costruite

-- con le list comprehension:
coppie lista1 lista2 = [(x,y) | x <- lista1, y <- lista2]
        --il tipo è [a] -> [b] -> [(a,b)]

-- senza list comprehension:
coppie2 [] ys = []
coppie2 (x:xs) ys = (creaCoppie x ys) ++ coppie2 xs ys

creaCoppie x [] = []
creaCoppie x (y:ys) = (x,y) : creaCoppie x ys 

-- con la map (prende una funzione, una lista e applica la funzione a tutti gli elementi della lista) + ricorsione
coppie3 [] ys = []
coppie3 (x:xs) ys = (map (\elementoLista2 -> (x,elementoLista2)) ys) ++ coppie3 xs ys
--NB che elementoLista2 è l'elemento che viene preso da ys ad ogni round, x invece è quello definito fuori

-- versione con la FOLDR + ricorsione
coppie4 [] ys = []
coppie4 (x:xs) ys = foldr (\ el2 acc -> (x,el2) : acc) [] ys ++ coppie4 xs ys --acc contiene mano a mano il risultato progressivo, se all'inizio è vuoto al passo successivo contiene l'ultima coppia...

-- in pratica inizialmente fa la pila di chiamate, essendo che è foldR allora la funzione verrà eseguita la prima volta sull'ultimo elemento della lista
-- l'ultimo elemento della lista finirà in el2 e in acc ci finirà []. el2 -> last(ys) (che è il primo nello stack) e acc -> [].
-- Viene quindi eseguita la prima chiamata della funzione e il risultato che otteniamo finirà, nella chiamata successiva, in acc.
-- quindi il passo successivo, acc conterrà (f [] last (ys)) e el2 conterrà il penultimo elemento della lista (che sarà il primo sullo stack). E così via..
-- quindi ad ogni passo ci sarà la concatenazione tra la nuova coppia e quelle contenute nell'accumulatore, funge da variabile di memoria, come nella ricorsione di coda.

-- versione con la FOLDL + ricorsione
coppie5 :: Foldable t => [a] -> t b -> [(a, b)]
coppie5 [] ys = []
coppie5 (x:xs) ys = foldl (\ acc el2 -> (x,el2): acc) [] ys ++ coppie4 xs ys

-- NB. uso a ++ b sse a e b sono LISTE, quindi [(a)], [(b)] e non coppie
-- uso a : b sse a è un elemento (es. coppia o el. singono) e b è lista [(b)]
-- cons (:) è lineare e (++) è quadratico

--versione map SENZA RICORSIONE, quindi non serve il caso base
coppie6 xs ys = map (\ x -> (map (\elementoLista2 -> (x,elementoLista2)) ys)) xs


--2. data una lista di liste costruire la lista di tutti gli elementi contenuti nelle varie liste

-- per casi
unfold1 [] = []
unfold1 (x:xs) = x ++ unfold1 xs

-- con list comprehension
unfold2 xxs = [x | xs <- xxs, x <- xs]

-- con la foldL
unfold3 xss = foldl (\ ys xs -> ys ++ xs) [] xss

unfold4 xss = foldl(++) [] xss 