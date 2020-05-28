-- Apellido y Nombre: RANIERI, Agustín

module Lib where

--Defensa
type Poder = Float
type Durabilidad = Int

data ParteDeArmadura = ParteDeArmadura {
    defensa :: Poder,
    durabilidad :: Durabilidad
} deriving Show

--Ataque
data Material = Madera | Metal deriving (Show,Eq)

type Ataque = Float
data Arma = Baculo { nombre:: String, inteligencia:: Poder} 
    | Arco { rango:: Poder, longitudHilo::Poder, dañoBase :: Poder }
    | Espada { almas :: Poder, material:: Material } deriving (Show,Eq)

--Personaje
data Personaje = Personaje {
    arma :: Arma,
    vida :: Poder,
    armadura :: [ParteDeArmadura]
} deriving Show

--Punto 1
armadurasNoRotas :: Personaje -> [ParteDeArmadura]
armadurasNoRotas unPersonaje = filter ((>0).durabilidad) (armadura unPersonaje)

poderDeDefensa :: Personaje -> Poder
poderDeDefensa unPersonaje = vida unPersonaje + (sum.armadurasNoRotas) unPersonaje

--Punto 2
poderDeAtaque :: Personaje -> Poder
poderDeAtaque = poderDeArma.arma

poderDeArma :: Arma -> Poder
poderDeArma (Baculo nom intelig) = intelig + length nom
poderDeArma (Arco rang long danio) = rang * long + danio
poderDeArma (Espada alm mat) = alm * (coeficienteDeMaterial mat)

coeficienteDeMaterial :: Material -> Poder
coeficienteDeMaterial Madera = 2
coeficienteDeMaterial Metal = 3
coeficienteDeMaterial _ = 1

--Punto 3
type Buff = Personaje -> Personaje

frenesi :: Buff
frenesi unPersonaje = unPersonaje { armadura = (buffDefensaArmadura (*1.20).armadura) unPersonaje }

buffDefensaArmadura :: (Poder->Poder) -> [ParteDeArmadura] -> [ParteDeArmadura]
buffDefensaArmadura buff unArmadura = unArmadura {defensa = ((map buff).defensa) unArmadura }

mantoEtereo :: Buff
mantoEtereo unPersonaje = unPersonaje { vida = (-100.vida) unPersonaje, armadura = (buffDefensaArmadura (+3).armadura) unPersonaje }