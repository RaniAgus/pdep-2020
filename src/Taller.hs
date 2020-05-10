module Taller where

type Desgaste = Float
type Patente = String
type Fecha = (Int, Int, Int)
 
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
ferrari =Auto{
 patente ="00aa0a0",
 desgasteLlantas = [1.0, 0.1, 0, 0.2],
 rpm = 0.5,
 temperaturaAgua = 1.5,
 ultimoArreglo = (17,11,1999)
} 

calculoPatental ::String ->Int
calculoPatental  patente 
    |last patente == '4' = ((*3000).length) patente   
    |otherwise =20000

costoDeReparacion ::Auto ->Int
costoDeReparacion auto
    |(length.patente) auto == 7 =12500
    |(length.patente) auto == 7 && (init.patente) auto == "DJ" && (tail.patente) auto ==  "NB" = (calculoPatental.patente) auto
    |otherwise =15000
--parte 2
autoPeligroso:: Auto->Bool
autoPeligroso auto = ((>0.5).(head.desgasteLlantas)) auto

año::Fecha->Int
año (_,_,año) = año

necesitaRevision ::Auto ->Bool
necesitaRevision auto = ((<2015).(año.ultimoArreglo)) auto 

--parte3





