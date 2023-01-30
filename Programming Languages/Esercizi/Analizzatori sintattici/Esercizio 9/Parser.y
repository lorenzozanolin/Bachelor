{
module Main(main) where
import AlexScanner
}

%name parse -- funzione chiamata nel main per fare il parsing
%tokentype {Token}
%error {parseError}

%token  --definisci i token
    NUMBER  { TokenInt $$ } -- quando ricevo un TokeInt con valore $$, questo viene associato a NUMBER (espressione che denota un valore)
    '('     { TokenOpenRoundPar }
    ')'     { TokenCloseRoundPar }
    '['     { TokenOpenSquaredPar }
    ']'     { TokenCloseSquaredPar }
    OP      { TokenOp $$ }
    UGUALE  { TokenEqual }
    IF      { TokenIf }
    CASE    { TokenCase }

%%  -- GRAMMATICA

P   : exp                                       { [$1] }    -- ritorna una lista contenente il valore di exp ($1)
    | P exp                                     { $2:$1 }   -- concatena i due valori calcolati

exp : '(' expParentesi ')'                      { $2 }
    | NUMBER                                    { $1 }

expParentesi    : OP exp exp                    { if $1 == '+' then ($2 + $3) else if $1 == '-' then ($2 - $3) else ($2 * $3) }
                | UGUALE exp exp                { if $2 == $3 then 1 else 0 }
                | IF exp exp exp                { if ($2 == 1) then $3 else $4 }
                | CASE exp clausole             { trovaClausola $2 $3 }

clausole    : clausole '[' clausola ']'         { $3:$1 }   -- lista di coppie -> (elenco valori (lista), espressione associata)
            | '[' clausola ']'                  { [$2] }

clausola    : '(' listaNumeri ')' exp           { ($2,$4) } --listaNumeri contiene i numeri della clausola, exp è l'espressione associata

listaNumeri : NUMBER                            { [$1] }
            | listaNumeri NUMBER                { $2:$1 }

{
trovaClausola :: Int -> [([Int], Int)] -> Int   --exp è l'espressione del case, ((nums,res):xs) è la lista di clausole
trovaClausola exp ((nums,res):xs) = if (elem exp nums) then res else (trovaClausola exp xs) -- res è l'espressione associata
trovaClausola exp [] = 0

parseError :: [Token] -> a
parseError e = error (show e ++ "Errore durante il parsing")

main :: IO()
main = do   s <- getContents
            print (reverse (parse (alexScanTokens s)))
}