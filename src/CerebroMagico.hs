module CerebroMagico where

vocales :: String
vocales = "aeiouAEIOU"

esVocal :: Char -> Bool
esVocal letra = elem letra vocales

primeraLetra :: String -> Char
primeraLetra = head

ultimaLetra :: String -> Char
ultimaLetra = last

empiezaConVocal :: String -> Bool
empiezaConVocal = esVocal.primeraLetra 

terminaConConsonante :: String -> Bool
terminaConConsonante = not.esVocal.ultimaLetra

gradoMayorASiete :: String -> Bool
gradoMayorASiete palabra = length palabra > 7

esParticular :: String -> Bool
esParticular nombre = empiezaConVocal nombre || gradoMayorASiete nombre

esMagico :: String -> Bool
esMagico nombre = esParticular nombre && terminaConConsonante nombre