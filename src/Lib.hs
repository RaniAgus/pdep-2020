-- Apellido y Nombre: RANIERI, Agustín

module Lib where

--Defensa
type Poder = Float
type Durabilidad = Int

data Parte = Parte {
    defensa :: Poder,
    durabilidad :: Durabilidad
} deriving Show

--Ataque
data Material = Madera | Metal | Otro deriving (Show,Eq)

type Ataque = Float
data Arma = Baculo { nombre:: String, inteligencia:: Poder} 
    | Arco { rango:: Poder, longitudHilo::Poder, dañoBase :: Poder }
    | Espada { almas :: Poder, material:: Material } deriving (Show,Eq)

--Personaje
data Personaje = Personaje {
    arma :: Arma,
    vida :: Poder,
    armadura :: [Parte]
} deriving Show

--Buffs
type Buff = Personaje -> Personaje

--Parte 1: Defensa
poderDeDefensa :: Personaje -> Poder
poderDeDefensa personaje = vida personaje + defensaTotal personaje

defensaTotal :: Personaje -> Poder
defensaTotal = sumarDefensa.noRotas.armadura

sumarDefensa :: [Parte] -> Poder
sumarDefensa = sum.map defensa

noRotas :: [Parte] -> [Parte]
noRotas = filter (not.estaRota) 

estaRota :: Parte -> Bool
estaRota = (==0).durabilidad

--Parte 2: Ataque
poderDeAtaque :: Personaje -> Poder
poderDeAtaque = poderDeArma.arma

poderDeArma :: Arma -> Poder
poderDeArma (Baculo nombre inteligencia) = inteligencia + (fromIntegral.length) nombre
poderDeArma (Arco rango longitud daño) = rango * longitud + daño
poderDeArma (Espada almas material) = almas * (coeficienteDeMaterial material)

coeficienteDeMaterial :: Material -> Poder
coeficienteDeMaterial Madera = 2
coeficienteDeMaterial Metal = 3
coeficienteDeMaterial _ = 1

--Parte 3: Buffs
--Funciones "transformar" a nivel Personaje
transformarArma :: (Arma->Arma)-> Buff
transformarArma f personaje = personaje {
    arma = (f.arma) personaje
}

transformarVida f personaje = personaje {
    vida = (f.vida) personaje
}

transformarArmadura :: (Parte->Parte) -> Buff
transformarArmadura f personaje = personaje {
    armadura = (map f.armadura) personaje
}

--Funciones "transformar" a nivel Parte
transformarDefensa :: (Poder->Poder) -> Parte -> Parte
transformarDefensa f parte = parte {
    defensa = (f.defensa) parte
}

transformarDurabilidad :: (Durabilidad->Durabilidad) -> Parte -> Parte
transformarDurabilidad f parte = parte {
    durabilidad = (f.durabilidad) parte
}

--Frenesí
frenesi :: Buff
frenesi = transformarArmadura (transformarDefensa (*1.20))

--Manto Etéreo
mantoEtereo :: Buff
mantoEtereo = transformarVida (quitarVida 100).transformarArmadura (transformarDefensa (+3))

quitarVida :: Poder -> Poder -> Poder
quitarVida cantidad vida = vida - cantidad

--Berserker
berserker :: Buff
berserker = transformarArmadura (transformarDefensa (\x->2)).transformarArma metalizar

metalizar :: Arma -> Arma
metalizar (Espada almas Madera) = Espada almas Metal  
metalizar arma = arma 

--Espejo de Karma
espejoDeKarma :: Buff -> Buff
espejoDeKarma buff = buff.buff

--buffCreativo
repararArmadura :: Buff
repararArmadura = transformarArmadura (transformarDurabilidad (\x->10))

--Sucesion de buffs
potenciarMultiple :: Personaje -> [Buff] -> Personaje
potenciarMultiple personaje buffs = foldl potenciar personaje buffs

--Potenciar
potenciar :: Personaje -> Buff -> Personaje 
potenciar personaje buff = buff personaje

--Es inofensivo
esInofensivo :: Buff -> [Personaje] -> Bool
esInofensivo buff = not.any (cambiaronStats buff)

cambiaronStats :: Buff -> Personaje -> Bool
cambiaronStats buff personaje = not (
    diferenciaPoder poderDeAtaque personaje (buff personaje) == 0 &&
    diferenciaPoder poderDeDefensa personaje (buff personaje) == 0 )

diferenciaPoder :: (Personaje->Poder) -> Personaje -> Personaje -> Poder
diferenciaPoder f personaje1 personaje2 = f personaje1 - f personaje2

--Parte 4: Desgaste
desgastar :: Durabilidad -> Personaje -> Personaje
desgastar intensidad personaje = personaje {
    armadura = desgastarArmadura intensidad (armadura personaje)
}

desgastarArmadura :: Durabilidad -> [Parte] -> [Parte]
desgastarArmadura _ [] = []
desgastarArmadura intensidad (x:xs) = desgastarParte intensidad x : 
    desgastarArmadura (intensidad `div` 2) xs

desgastarParte :: Durabilidad -> Parte -> Parte
desgastarParte intensidad parte = parte {
    durabilidad = max (durabilidad parte - intensidad) 0
}

--Parte 5: Clanes
data Clan = Clan {
    miembros :: [Personaje],
    buffs :: [Buff]
}

leGana :: Clan -> Clan -> Bool
leGana atacante defensor = poderTotalSegun poderDeAtaque atacante > poderTotalSegun poderDeDefensa defensor

poderTotalSegun :: (Personaje -> Poder) -> Clan -> Poder
poderTotalSegun f = ( sum . map f . potenciarClanSegun f )

potenciarClanSegun :: (Personaje -> Poder) -> Clan -> [Personaje]
potenciarClanSegun f clan = ( map ( potenciarMiembroSegun f (buffs clan) ) . miembros ) clan

potenciarMiembroSegun :: (Personaje -> Poder) -> [Buff] -> Buff
potenciarMiembroSegun f buffs miembro = potenciar miembro elegirMejorBuff
    where 
    elegirMejorBuff = foldl1 (esMejorSegun criterioAlPotenciar) buffs
    criterioAlPotenciar = (f.potenciar miembro)


esMejorSegun :: (Buff -> Poder) -> Buff -> Buff -> Buff
esMejorSegun criterio buff1 buff2
    | criterio buff1 > criterio buff2 = buff1 
    | otherwise = buff2
