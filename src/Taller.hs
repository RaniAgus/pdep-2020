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
tecnicosDejanEnCondiciones :: Auto -> [Tecnico] -> [Tecnico]
tecnicosDejanEnCondiciones auto = filter (dejaElAutoSeguro auto)

dejaElAutoSeguro :: Auto -> Tecnico -> Bool
dejaElAutoSeguro auto = not . esAutoPeligroso . ( $ auto )

-- Parte 2 (integrante b)
costoTotalDeReparacion :: [Auto] -> Costo
costoTotalDeReparacion = sum . map costoDeReparacion . filter necesitaRevision

-- Punto 7
tecnicosInfinitos = tango:tango:zulu:tecnicosInfinitos
 
autosInfinitos :: [Auto]
autosInfinitos = autosInfinitos' 0
 
autosInfinitos' :: Float -> [Auto]
autosInfinitos' n = Auto {
    patente = "AAA000",
    desgasteLlantas = [n, 0, 0, 0.3],
    rpm = 1500 + n,
    temperaturaAgua = 90,
    ultimoArreglo = (20, 1, 2013)
} : autosInfinitos' (n + 1)

-- Parte 1 (integrante a)
primerTecnicoSeguro :: Auto -> [Tecnico] -> Tecnico
primerTecnicoSeguro auto = head . tecnicosDejanEnCondiciones auto

{- Respuesta: 
Al ejecutar la función, pasándole por parámetro una lista infinita, funciona perfectamente
como se muestra en el test.
Esto ocurre porque la función "head" solamente necesita que se calcule el primer valor de 
la lista de técnicos que dejan en condiciones al auto, por lo que la evaluación diferida
permite llegar a un resultado.
-}
-- Parte 2 (integrante b)

{- Respuesta: 
Al ejecutar la función con una lista infinita, se queda ejecutando eternamente sin
obtener un resultado.
Esto pasa porque al ejecutar las funciones "sum", "map" y "filter" esperan a que
se calculen todos los valores de la lista que reciben, y, al ser infinita, esto nunca sucede.
-}

costoTotalDeReparacionV2 :: [Auto] -> Costo
costoTotalDeReparacionV2 = sum . take 3 . map costoDeReparacion . filter necesitaRevision

{- Respuesta: Sí, al agregársele la función "take 3", Haskell necesita evaluar solamente
los primeros 3 elementos de la lista. La evaluación diferida impide que se produzca un bucle.
-}