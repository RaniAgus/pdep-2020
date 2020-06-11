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
    idiomas :: [String]
} deriving Show

--Ana: está acompañada, sin cansancio, tiene 21 de stress y habla español.
ana :: Turista
ana = Turista {
    viajaSolo = False,
    cansancio = 0,
    stress = 21,
    idiomas = ["Español"]
}

--Beto y Cathi, que hablan alemán, viajan solos, y Cathi además habla catalán. 
--Ambos tienen 15 unidades de cansancio y stress.
beto :: Turista
beto = Turista {
    idiomas = ["Alemán"],
    viajaSolo = True,
    cansancio = 15,
    stress = 15
}

cathi :: Turista
cathi = Turista {
    idiomas = ["Alemán", "Catalán"],
    viajaSolo = True,
    cansancio = 15,
    stress = 15
}

--Punto 2
type Excursion = Turista -> Turista

modificarCansancio :: Int -> Excursion
modificarCansancio val turista = turista {
    cansancio = cansancio turista + val `max` 0
}

modificarStress :: Int -> Excursion
modificarStress val turista = turista {
    stress = stress turista + val `max` 0
}

agregarIdioma :: String -> Excursion
agregarIdioma idioma turista = turista {
    idiomas = idiomas turista ++ [idioma]
}

hablaIdioma :: String -> Turista -> Bool
hablaIdioma idioma = elem idioma . idiomas

-- Ir a la playa: si está viajando solo baja el cansancio en 5 unidades, si no baja el stress 1 unidad
irAPlaya :: Excursion
irAPlaya turista 
  | viajaSolo turista = modificarCansancio (-5) turista
  | otherwise = modificarStress (-1) turista

-- Apreciar algún elemento del paisaje: reduce el stress en la cantidad de letras de lo que se aprecia. 
apreciarElementoDePaisaje :: String -> Excursion
apreciarElementoDePaisaje elemento = modificarStress (- length elemento)

-- Salir con gente que habla un idioma específico: el turista termina aprendiendo dicho idioma y continúa el viaje acompañado.
salirConGenteQueHablaUnIdioma :: String -> Excursion
salirConGenteQueHablaUnIdioma idioma = agregarIdioma idioma

{- Caminar ciertos minutos: aumenta el cansancio pero reduce el stress según la intensidad de la caminada. 
El nivel de intensidad se calcula en 1 unidad cada 4 minutos que se caminen. -}

caminar :: Int -> Excursion
caminar minutos = modificarCansancio (intensidadCaminata minutos) . modificarStress (- intensidadCaminata minutos)

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
paseoEnBarco Fuerte = modificarStress 6 . modificarCansancio 10
paseoEnBarco Moderada = id
paseoEnBarco Tranquila = caminar 10 . apreciarElementoDePaisaje "mar" . salirConGenteQueHablaUnIdioma "Alemán"


{- Hacer que un turista haga una excursión. Al hacer una excursión, el turista además de sufrir los
efectos propios de la excursión, reduce en un 10% su stress. -}
