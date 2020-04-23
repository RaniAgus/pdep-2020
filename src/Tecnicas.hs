module Tecnicas where

type Objetivo = String

golpe :: Int -> String -> Int
golpe horas objetivo = poder horas `div` fortaleza objetivo

fortaleza :: String -> Int
fortaleza = (*2).length 

poder :: Int -> Int
poder = (*15)

golpesNormalesConsecutivos :: String -> Int
golpesNormalesConsecutivos = golpe 240

golpeGomuElephantTraining :: String -> Int
golpeGomuElephantTraining = golpe 180

esDificil :: String -> Bool
esDificil = (<100).golpeGomuElephantTraining

accesibilidad :: String -> Int
accesibilidad = (`div` 10).golpesNormalesConsecutivos.focalizar

focalizar :: String -> String
focalizar = take 7