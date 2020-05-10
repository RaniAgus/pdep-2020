module Taller where

type Desgaste = Float
type Patente = String
type Fecha = (Int, Int, Int)
type Costo = Int
 
-- Definiciones base
anio :: Fecha -> Int
anio (_, _, year) = year
 
data Auto = Auto {
    patente :: Patente,
    desgasteLlantas :: [Desgaste],
    rpm :: Float,
    temperaturaAgua :: Float,
    ultimoArreglo :: Fecha
} deriving Show

unAuto = Auto {
    patente ="AAA000",
    desgasteLlantas = [1.0, 0.1, 0, 0.2],
    rpm = 3000,
    temperaturaAgua = 1.5,
    ultimoArreglo = (17,11,1999)
} 

-- Punto 1
costoDeReparacion :: Auto -> Costo
costoDeReparacion auto
    | esPatenteNueva auto = 12500
    | esPatenteAnterior auto && (patenteEstaEntre "DJ" "NB") auto = (calculoPatental.patente) auto
    | otherwise = 15000

esPatenteNueva :: Auto -> Bool
esPatenteNueva = (==7).length.patente

esPatenteAnterior :: Auto -> Bool
esPatenteAnterior = (==6).length.patente

patenteEstaEntre :: Patente -> Patente -> Auto -> Bool
patenteEstaEntre patente1 patente2 auto = patente1 < (patente auto) && (patente auto) < patente2

calculoPatental :: Patente -> Costo
calculoPatental  patente 
    | last patente == '4' = 3000 * length patente
    | otherwise = 20000

-- Punto 2
-- Parte 1 (integrante a)
esAutoPeligroso :: Auto -> Bool
esAutoPeligroso = estaMuyDesgastada.primeraLlanta

primeraLlanta :: Auto -> Desgaste
primeraLlanta = head.desgasteLlantas

estaMuyDesgastada :: Desgaste -> Bool
estaMuyDesgastada = (>0.5)

-- Parte 2 (integrante b)
año:: Fecha -> Int
año (_,_,año) = año

necesitaRevision ::Auto ->Bool
necesitaRevision auto = ((<2015).(año.ultimoArreglo)) auto 

-- Punto 3
-- Parte 1 (integrante a)
alfa :: Auto -> Auto
alfa unAuto 
    | rpm unAuto < 2000 = unAuto
    | otherwise = unAuto { rpm = 2000 }

bravo :: Auto -> Auto
bravo unAuto = unAuto { desgasteLlantas = sinDesgaste }

sinDesgaste :: [Desgaste]
sinDesgaste = [0, 0, 0, 0]

charly :: Auto -> Auto
charly = bravo.alfa

-- Parte 2 (integrante b)