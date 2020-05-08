module Lib where

laVerdad = True

type Precio = Double
type Nombre = String
type Color = String
type CriterioPropina = Precio -> Precio

cuantoPagar :: CriterioPropina -> Precio -> Precio
cuantoPagar criterioPropina cuenta = cuenta + criterioPropina cuenta

propinaRecomendada :: CriterioPropina
propinaRecomendada cuenta = cuenta * 0.1

propinaALaMrPink :: CriterioPropina
propinaALaMrPink _ = 0

propinaConservadora :: CriterioPropina
propinaConservadora cuenta 
    | esPrecioPar cuenta = 20
    | otherwise = 25

esPrecioPar :: Precio -> Bool
esPrecioPar = even.floor

propinaTioCarlos :: Nombre -> CriterioPropina
propinaTioCarlos "Carlos" cuenta  = ((*2).propinaRecomendada) cuenta
propinaTioCarlos _ cuenta = ((/2).propinaRecomendada) cuenta

propinaPayasa :: Color -> CriterioPropina
propinaPayasa "Azul" cuenta  = propinaRecomendada cuenta
propinaPayasa "Roja" _ = 100
propinaPayasa "Negra" _  = 0

propinaSegunCosto :: CriterioPropina
propinaSegunCosto cuenta
    | cuenta < 500 = ((*3).propinaRecomendada) cuenta
    | cuenta < 1000 = propinaConservadora cuenta
    | otherwise = 0

mozoEstaSatisfecho :: CriterioPropina -> Precio -> Bool
mozoEstaSatisfecho criterioPropina cuenta = criterioPropina cuenta > cuenta * 0.15