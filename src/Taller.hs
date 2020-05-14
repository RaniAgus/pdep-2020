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
    | esPatente 7 auto = 12500
    | esPatente 6 auto && patenteEstaEntre "DJ" "NB" auto = (calculoPatental.patente) auto
    | otherwise = 15000

esPatente :: Int -> Auto -> Bool
esPatente n = (==n).length.patente

patenteEstaEntre :: Patente -> Patente -> Auto -> Bool
patenteEstaEntre patente1 patente2 auto = patente1 < (patente auto) && (patente auto) < patente2

calculoPatental :: Patente -> Costo
calculoPatental  patente 
    | last patente == '4' = 3000 * length patente
    | otherwise = 20000

calculoPatental' :: Patente -> Costo
calculoPatental'  patente 
    | ((== '4').last) patente = ((*3000).length) patente
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
alfa auto = auto { rpm = min (rpm auto) 2000 }

bravo :: Auto -> Auto
bravo auto = auto { desgasteLlantas = (quitarDesgaste.desgasteLlantas) auto }

quitarDesgaste :: [Desgaste] -> [Desgaste]
quitarDesgaste = map (\x -> 0)

charly :: Auto -> Auto
charly = bravo.alfa

-- Parte 2 (integrante b)
tango::Auto->Auto
tango  = id

zulu::Auto->Auto
zulu  = trabajoZulu.lima

trabajoZulu::Auto->Auto
trabajoZulu auto=auto{temperaturaAgua=90}

lima::Auto ->Auto
lima auto = auto {desgasteLlantas =cambioDelantero auto}

cambioDelantero::Auto->[Desgaste]
cambioDelantero auto = concat [[0,0] ,drop  2 (desgasteLlantas auto)]