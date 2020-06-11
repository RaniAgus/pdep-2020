{-
Nombre: Ranieri, Agustín Ezequiel
Legajo: 167755-0
-}

module Lib where
import Text.Show.Functions

laVerdad = True

-- Punto 1
data Turista = Turista {
    cansancio :: Int,
    stress :: Int,
    viajaSolo :: Bool,
    idiomas :: [Idioma]
} deriving Show

data Idioma = Español | Aleman | Catalan | Melmacquiano deriving (Eq,Show)
{- Nota: Uso data para no tener problemas al ingresar el idioma por consola.
Tendré que agregar un idioma más por cada vez que aparezca uno distinto, pero 
ese problema me parece menor respecto al beneficio que trae hacer esto -}

--Ana: está acompañada, sin cansancio, tiene 21 de stress y habla español.
ana :: Turista
ana = Turista {
    viajaSolo = False,
    cansancio = 0,
    stress = 21,
    idiomas = [Español]
}

--Beto y Cathi, que hablan alemán, viajan solos, y Cathi además habla catalán. 
--Ambos tienen 15 unidades de cansancio y stress.
beto :: Turista
beto = Turista {
    idiomas = [Aleman],
    viajaSolo = True,
    cansancio = 15,
    stress = 15
}

cathi :: Turista
cathi = Turista {
    idiomas = [Aleman, Catalan],
    viajaSolo = True,
    cansancio = 15,
    stress = 15
}
--Podría crear a cathi usando a beto:
cathi' = beto {
    idiomas = [Aleman, Catalan]
}
--Incluso usando una función:
cathi'' = agregarIdioma Catalan beto

--Punto 2
type Excursion = Turista -> Turista

modificarCansancio :: (Int -> Int -> Int) -> Int -> Excursion
modificarCansancio f val turista = turista {
    cansancio = max 0 (cansancio turista `f` val)
}
-- Se puede hacer: (max 0.(`f` val).cansancio) turista
-- De todas maneras, me parece más expresivo hacerlo así
-- Hice que sea infija porque lo más común es hacer sumas o restas

modificarStress :: (Int -> Int -> Int) -> Int -> Excursion
modificarStress f val turista = turista {
    stress = max 0 (stress turista `f` val)
}

darCompania :: Excursion
darCompania turista = turista {
    viajaSolo = False
}

restarPorcentual :: Int -> Int -> Int
restarPorcentual val porcentaje = val - val * porcentaje `div` 100

agregarIdioma :: Idioma -> Excursion
agregarIdioma idioma turista
  | hablaIdioma idioma turista = turista
  | otherwise = turista { idiomas = idiomas turista ++ [idioma] }

hablaIdioma :: Idioma -> Turista -> Bool
hablaIdioma idioma = elem idioma . idiomas

-- Ir a la playa: si está viajando solo baja el cansancio en 5 unidades, si no baja el stress 1 unidad
irAPlaya :: Excursion
irAPlaya turista 
  | viajaSolo turista = modificarCansancio (-) 5 turista
  | otherwise = modificarStress (-) 1 turista

-- Apreciar algún elemento del paisaje: reduce el stress en la cantidad de letras de lo que se aprecia. 
apreciarElementoDePaisaje :: String -> Excursion
apreciarElementoDePaisaje elemento = modificarStress (-) (length elemento)

-- Salir con gente que habla un idioma específico: el turista termina aprendiendo dicho idioma y continúa el viaje acompañado.
salirConGenteQueHablaUnIdioma :: Idioma -> Excursion
salirConGenteQueHablaUnIdioma idioma = darCompania . agregarIdioma idioma

{- Caminar ciertos minutos: aumenta el cansancio pero reduce el stress según la intensidad de la caminada. 
El nivel de intensidad se calcula en 1 unidad cada 4 minutos que se caminen. -}

caminar :: Int -> Excursion
caminar minutos = modificarCansancio (+) (intensidadCaminata minutos) . modificarStress (-) (intensidadCaminata minutos)

intensidadCaminata :: Int -> Int
intensidadCaminata = (`div` 4)

{-Paseo en barco: depende de cómo esté la marea
- si está fuerte, aumenta el stress en 6 unidades y el cansancio en 10.
- si está moderada, no pasa nada.
- si está tranquila, el turista camina 10’ por la cubierta, aprecia la vista del “mar”, y sale a hablar 
con los tripulantes alemanes.
-}

data Marea = Fuerte | Moderada | Tranquila deriving (Show, Eq)

paseoEnBarco :: Marea -> Excursion
paseoEnBarco Fuerte = modificarStress (+) 6 . modificarCansancio (+) 10
paseoEnBarco Moderada = id
paseoEnBarco Tranquila = salirConGenteQueHablaUnIdioma Aleman . apreciarElementoDePaisaje "mar" . caminar 10

{- Hacer que un turista haga una excursión. Al hacer una excursión, el turista además de sufrir los
efectos propios de la excursión, reduce en un 10% su stress. -}

hacerExcursion :: Turista -> Excursion -> Turista
hacerExcursion turista excursion = (modificarStress restarPorcentual 10.excursion) turista

{-Definir la función deltaExcursionSegun que a partir de un índice, un turista y una excursión determine cuánto 
varió dicho índice después de que el turista haya hecho la excursión.  Llamamos índice a cualquier función que
devuelva un número a partir de un turista-}
deltaSegun :: (a -> Int) -> a -> a -> Int
deltaSegun f algo1 algo2 = f algo1 - f algo2

type Indice = Turista -> Int

deltaExcursionSegun :: Indice -> Excursion -> Turista -> Int
deltaExcursionSegun indice excursion turista = deltaSegun indice (hacerExcursion turista excursion) turista

--Usar la función anterior para resolver cada uno de estos puntos:

-- Saber si una excursión es educativa para un turista, que implica que termina aprendiendo algún idioma.
esExcursionEducativa :: Excursion -> Turista -> Bool
esExcursionEducativa excursion = esEducativa . deltaExcursionSegun (length.idiomas) excursion
    where esEducativa = (>0)

-- Conocer las excursiones desestresantes para un turista. Estas son aquellas que le reducen al menos 3 unidades de stress al turista.
esExcursionDesestresante :: Excursion -> Turista -> Bool
esExcursionDesestresante excursion = esDesestresante . deltaExcursionSegun stress excursion
    where esDesestresante = (<= -3)

{- Para mantener a los turistas ocupados todo el día, la empresa vende paquetes de excursiones llamados tours. 
Un tour se compone por una serie de excursiones. -}
type Tour = [Excursion]

{-Completo: Comienza con una caminata de 20 minutos para apreciar una "cascada", luego se camina 40 minutos hasta una playa,
 y finaliza con una salida con gente local que habla "melmacquiano"-}

tourCompleto :: Tour
tourCompleto = [
    caminar 20,
    apreciarElementoDePaisaje "cascada",
    caminar 40,
    irAPlaya,
    salirConGenteQueHablaUnIdioma Melmacquiano
    ]

{-Lado B: Este tour consiste en ir al otro lado de la isla a hacer alguna excursión (de las existentes) que elija el turista. 
Primero se hace un paseo en barco por aguas tranquilas (cercanas a la costa) hasta la otra punta de la isla, luego realiza 
la excursión elegida y finalmente vuelve caminando hasta la otra punta, tardando 2 horas.-}

tourLadoB :: Excursion -> Tour
tourLadoB excursion = [
    paseoEnBarco Tranquila,
    excursion,
    caminar 120
    ]

{-Isla Vecina: Se navega hacia una isla vecina para hacer una excursión. Esta excursión depende de cómo esté la marea al
llegar a la otra isla: si está fuerte se aprecia un "lago", sino se va a una playa. En resumen, este tour implica hacer un
paseo en barco hasta la isla vecina, luego llevar a cabo dicha excursión, y finalmente volver a hacer un paseo en barco de
regreso. La marea es la misma en todo el camino.-}

islaVecina :: Marea -> Tour
islaVecina marea = [
    paseoEnBarco marea,
    elegirExcursionSegunMarea marea,
    paseoEnBarco marea
    ]

elegirExcursionSegunMarea :: Marea -> Excursion
elegirExcursionSegunMarea Fuerte = apreciarElementoDePaisaje "lago"
elegirExcursionSegunMarea _ = irAPlaya

{-Hacer que un turista haga un tour. Esto implica, primero un aumento del stress en tantas unidades como cantidad de
excursiones tenga el tour, y luego realizar las excursiones en orden.-}

hacerTour :: Tour -> Turista -> Turista
hacerTour tour turista = foldl hacerExcursion turista (pagarTour:tour)
    where pagarTour = modificarStress (+) (length tour)

{-Dado un conjunto de tours, saber si existe alguno que sea convincente para un turista. Esto significa que el tour
tiene alguna excursión desestresante la cual, además, deja al turista acompañado luego de realizarla.-}

--hayAlgunTourConvincente :: Turista -> [Tour] -> Bool
--hayAlgunTourConvincente turista = any . map (esTourConvincente turista)

esTourConvincente :: Turista -> Tour -> Bool
esTourConvincente turista = any (esExcursionConvincente turista)

esExcursionConvincente :: Turista -> Excursion -> Bool
esExcursionConvincente turista excursion = undefined
    --(.esExcursionDesestresante excursion) 
