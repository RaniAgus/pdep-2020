module CerebroMagico where

vocales :: String
vocales = "aeiouAEIOU"

esVocal :: Char -> Bool
esVocal letra = elem letra vocales

primeraLetra :: String -> Char
primeraLetra = head

ultimaLetra:: String -> Char
ultimaLetra = last

gradoMayorASiete :: String -> Bool
gradoMayorASiete palabra = length palabra > 7

esParticular :: String -> Bool
esParticular nombre = (esVocal.primeraLetra) nombre || gradoMayorASiete nombre

esMagico :: String -> Bool
esMagico nombre = esParticular nombre && (not.esVocal.ultimaLetra) nombre