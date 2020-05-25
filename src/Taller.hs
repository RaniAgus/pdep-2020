module Taller where

type Desgaste = Float
type Patente = String
type Fecha = (Int, Int, Int)
type Costo = Int
type Tecnico = Auto -> Auto
 
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
anioUltimoArreglo::Auto->Int
anioUltimoArreglo =(anio.ultimoArreglo)

antesOigual ::Int->Int->Bool
antesOigual anio  = (<=anio)

necesitaRevision ::Auto ->Bool
necesitaRevision  =(antesOigual 2015).anioUltimoArreglo  

-- Punto 3
-- Parte 1 (integrante a)
alfa :: Tecnico
alfa auto = auto { rpm = min (rpm auto) 2000 }

bravo :: Tecnico
bravo auto = auto { desgasteLlantas = (quitarDesgaste.desgasteLlantas) auto }

quitarDesgaste :: [Desgaste] -> [Desgaste]
quitarDesgaste = map (\x -> 0)

charly :: Tecnico
charly = bravo.alfa

-- Parte 2 (integrante b)
tango:: Tecnico
tango  = id

zulu:: Tecnico
zulu  = trabajoZulu.lima

trabajoZulu:: Tecnico
trabajoZulu auto=auto{temperaturaAgua=90}

lima:: Tecnico
lima auto = auto {desgasteLlantas =cambioDelantero auto}

cambioDelantero::Auto->[Desgaste]
cambioDelantero auto = concat [[0,0] ,drop  2 (desgasteLlantas auto)]

-- Punto 4
cantidadDesgaste :: Auto -> Int
cantidadDesgaste  = round.(*10).sum.desgasteLlantas 

compararPosicionyDesgaste :: Int -> [Int] -> Bool
compararPosicionyDesgaste pos [x] = even pos == even x 
compararPosicionyDesgaste pos (x:xs) = even pos == even x && compararPosicionyDesgaste (pos+1) xs

estaOrdenadoTOC :: [Auto] -> Bool
estaOrdenadoTOC = (compararPosicionyDesgaste 1).(map cantidadDesgaste)

-- Punto 5
ordenReparacion :: Auto -> [Tecnico] -> Fecha -> Auto
ordenReparacion auto tecnicos fecha = foldr ($) auto (nuevaFecha fecha:tecnicos)

nuevaFecha :: Fecha -> Tecnico
nuevaFecha fecha auto = auto{ultimoArreglo = fecha}

-- Punto 6
-- Parte 1 (integrante a)

-- Parte 2 (integrante b)

-- Punto 7
-- Parte 1 (integrante a)

-- Parte 2 (integrante b)
