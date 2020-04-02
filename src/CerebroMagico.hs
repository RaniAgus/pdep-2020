module CerebroMagico where

vocales :: String
vocales = "aeiouAEIOU"

esVocal :: Char -> Bool
esVocal letra = elem letra vocales

esParticular :: String -> Bool
esParticular nombre = esVocal(head nombre) || length nombre > 7

ultimaLetra :: String -> Char
ultimaLetra palabra = palabra !! (length palabra - 1)

esVocalUltimaLetra :: String -> Bool
esVocalUltimaLetra = esVocal.ultimaLetra

esMagico :: String -> Bool
esMagico nombre = esParticular nombre && not (esVocalUltimaLetra nombre)