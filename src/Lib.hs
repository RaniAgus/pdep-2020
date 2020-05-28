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

calcularDefensa :: [ParteDeArmadura] -> Poder
calcularDefensa = (sum.map defensa)

poderDeDefensa :: Personaje -> Poder
poderDeDefensa unPersonaje = vida unPersonaje + (calcularDefensa.armadurasNoRotas) unPersonaje

--Punto 2
poderDeAtaque :: Personaje -> Poder
poderDeAtaque = poderDeArma.arma

poderDeArma :: Arma -> Poder
poderDeArma (Baculo nom intelig) = intelig + (fromIntegral.length) nom
poderDeArma (Arco rang long danio) = rang * long + danio
poderDeArma (Espada alm mat) = alm * (coeficienteDeMaterial mat)

coeficienteDeMaterial :: Material -> Poder
coeficienteDeMaterial Madera = 2
coeficienteDeMaterial Metal = 3
coeficienteDeMaterial _ = 1

--Punto 3
type Buff = Personaje -> Personaje

frenesi :: Buff
frenesi unPersonaje = unPersonaje { armadura = buffDefensaArmadura (*1.20) unPersonaje }

buffDefensaArmadura :: (Poder->Poder) -> Personaje -> [ParteDeArmadura]
buffDefensaArmadura buff unPersonaje = map (\parte -> parte{defensa = (buff.defensa) parte}) (armadura unPersonaje)

mantoEtereo :: Buff
mantoEtereo unPersonaje = unPersonaje { vida = (quitarVida 100) unPersonaje, armadura = buffDefensaArmadura (+3) unPersonaje }

quitarVida :: Poder -> Personaje -> Poder
quitarVida valor unPersonaje = vida unPersonaje - valor

berserker :: Buff
berserker unPersonaje = unPersonaje { armadura = buffDefensaArmadura (\x->2) unPersonaje, arma = (transformarEnMetal.arma) unPersonaje }

transformarEnMetal :: Arma -> Arma
transformarEnMetal (Espada almas Madera) = Espada almas Metal  
transformarEnMetal unArma@(Espada _ _) = id unArma 
transformarEnMetal unArma@(Baculo _ _) = id unArma 
transformarEnMetal unArma@(Arco _ _ _) = id unArma 

espejoDeKarma :: Buff -> Buff
espejoDeKarma buff = buff.buff