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
    patente = "",
    desgasteLlantas = [],
    rpm = 0,
    temperaturaAgua = 0,
    ultimoArreglo = (0,0,0)
} 

-- Punto 1
costoDeReparacion :: Auto -> Costo
costoDeReparacion auto
    | patente7 auto = 12500
    | patente6 auto && (patenteEstaEntre "DJ" "NB") auto = (calculoPatental.patente) auto
    | otherwise = 15000

patente7 :: Auto -> Bool
patente7 = (==7).length.patente

patente6 :: Auto -> Bool
patente6 = (==6).length.patente

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

anioUltimoArreglo::Auto->Int
anioUltimoArreglo =(año.ultimoArreglo)

antesOigual ::Int->Int->Bool
antesOigual anio  = (<=anio)

necesitaRevision ::Auto ->Bool
necesitaRevision  =(antesOigual 2015).anioUltimoArreglo  

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
tango::Auto->Auto
tango  = id

zulu::Auto->Auto
zulu auto = auto {temperaturaAgua = 90,desgasteLlantas =cambioDelantero auto}

lima::Auto ->Auto
lima auto = auto {desgasteLlantas =cambioDelantero auto}

cambioDelantero::Auto->[Desgaste]
cambioDelantero auto =[0,0,obtenerLlanta 2 auto,obtenerLlanta 3 auto ]

obtenerLlanta ::Int->Auto->Float
obtenerLlanta n=(!!n).desgasteLlantas