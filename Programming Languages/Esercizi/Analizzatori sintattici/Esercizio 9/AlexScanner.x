{
    module AlexScanner (Token(..), alexScanTokens)
    where
}

%wrapper "basic"
$cifra = [0-9]  --regex

tokens :- --s è la stringa letta che è considerata come lista di Char 
    \-?($cifra)+    { \s -> TokenInt (read s) } -- la stringa letta genera un tokenInt e gli associa il valore letto (convertito in numero)
    \(              { \s -> TokenOpenRoundPar }
    \)              { \s -> TokenCloseRoundPar }
    \[              { \s -> TokenOpenSquaredPar }
    \]              { \s -> TokenCloseSquaredPar }
    [\+\-\*]         { \s -> TokenOp (head s) } -- legge solo il primo carattere letto
    "="             { \s -> TokenEqual}
    if              { \s -> TokenIf }
    case            { \s -> TokenCase}
    \n|.            ;

{
    data Token = TokenInt Int   --definisce il tipo token
        | TokenOpenRoundPar
        | TokenCloseRoundPar
        | TokenOpenSquaredPar
        | TokenCloseSquaredPar
        | TokenOp Char
        | TokenEqual
        | TokenIf
        | TokenCase
    deriving (Eq, Show)

main::IO () 
main = do s <- getContents
          print (alexScanTokens s)
}