module Lib where

--PUNTO 1

data TipoPokemon = Planta | Agua | Fuego deriving (Show, Eq)

tieneVentajaContra :: TipoPokemon -> TipoPokemon -> Bool
tieneVentajaContra Planta Agua = True
tieneVentajaContra Agua Fuego = True
tieneVentajaContra Fuego Planta = True
tieneVentajaContra _ _ = False

data Pokemon = Pokemon {
    nombre :: String,
    tipo :: TipoPokemon
} deriving (Show, Eq)

bulbasaur :: Pokemon
bulbasaur = Pokemon "Bulbasaur" Planta
charmander :: Pokemon
charmander = Pokemon "Charmander" Fuego
flareon :: Pokemon
flareon = Pokemon "Flareon" Fuego
gyarados :: Pokemon
gyarados = Pokemon "Gyarados" Agua
oddish :: Pokemon
oddish = Pokemon "Oddish" Planta
squirtle :: Pokemon
squirtle = Pokemon "Squirtle" Agua

ganaContra :: Pokemon -> Pokemon -> Bool
ganaContra atacante defensor = (tipo atacante) `tieneVentajaContra` (tipo defensor)

contraQuienesGana :: Pokemon -> [Pokemon] -> [Pokemon]
contraQuienesGana atacante = filter (\defensor -> atacante `ganaContra` defensor)

--PUNTO 2

nombresPerdedores :: Pokemon -> [Pokemon] -> [String]
nombresPerdedores unPokemon = (map nombre).(contraQuienesGana unPokemon)

--PUNTO 3

cantidadVictorias :: Pokemon -> [Pokemon] -> Int
cantidadVictorias unPokemon = (length.contraQuienesGana unPokemon)

--PUNTO 4

data Destino = UnGimnasio { nombreGym:: String, siguiente:: Destino }
    | UnaLiga { contrincantes:: [Pokemon] } deriving (Show,Eq)

gymRoca :: Destino
gymRoca = UnGimnasio "Gimnasio Roca" gymAgua
gymAgua :: Destino
gymAgua = UnGimnasio "Gimnasio Agua" gymElectrico
gymElectrico :: Destino
gymElectrico = UnGimnasio "Gimnasio Eléctrico" ligaKanto
ligaKanto :: Destino
ligaKanto = UnaLiga [gyarados, squirtle, oddish]

gymFuego :: Destino
gymFuego = UnGimnasio "Gimnasio Fuego" gymPlanta
gymPlanta :: Destino
gymPlanta = UnGimnasio "Gimnasio Planta" ligaGali
ligaGali :: Destino
ligaGali = UnaLiga [flareon, charmander, bulbasaur]

estaAlHorno :: Pokemon -> Destino -> Bool
estaAlHorno _ (UnGimnasio _ _) = True
estaAlHorno pokemon (UnaLiga rivales) = all (\rival -> rival `ganaContra` pokemon) rivales

--PUNTO 5

puedoViajar :: Destino -> Destino -> Bool
puedoViajar origen@(UnaLiga _) destino = origen == destino
puedoViajar origen destino = origen == destino || puedoViajar (siguiente origen) destino

--PUNTO 6

elMasPicante :: [Pokemon] -> Pokemon
elMasPicante pokelista = foldl1 (masPicanteDeDos pokelista) pokelista

masPicanteDeDos :: [Pokemon] -> Pokemon -> Pokemon -> Pokemon
masPicanteDeDos pokelista atacante1 atacante2 
    | cantidadVictorias atacante1 pokelista >= cantidadVictorias atacante2 pokelista = atacante1
    | otherwise = atacante2 