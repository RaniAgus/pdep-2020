module Tecnicas where

type Objetivo = String
type Entrenamiento = Int
type PoderGolpe = Int

golpe :: Entrenamiento -> Objetivo -> PoderGolpe
golpe horas objetivo = poder horas `div` fortaleza objetivo

fortaleza :: Objetivo -> PoderGolpe
fortaleza = (*2).length 

poder :: Entrenamiento -> PoderGolpe
poder = (*15)

golpesNormalesConsecutivos :: Objetivo -> PoderGolpe
golpesNormalesConsecutivos = golpe 240

golpeGomuElephantTraining :: Objetivo -> PoderGolpe
golpeGomuElephantTraining = golpe 180

esDificil :: Objetivo -> Bool
esDificil = (<100).golpeGomuElephantTraining

accesibilidad :: Objetivo -> PoderGolpe
accesibilidad = (`div` 10).golpesNormalesConsecutivos.focalizar

focalizar :: Objetivo -> Objetivo
focalizar = take 7