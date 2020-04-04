module CerebroMagico where

vocales :: String
vocales = "aeiouAEIOU"

esVocal :: Char -> Bool
esVocal letra = elem letra vocales

esParticular :: String -> Bool
esParticular nombre = (esVocal.head) nombre || length nombre > 7

esMagico :: String -> Bool
esMagico nombre = esParticular nombre && (not.esVocal.last) nombre