import Test.Hspec
import Lib

unaEspada = Espada {
   almas = 3,
   material = Metal
}

unArco = Arco {
   rango = 2,
   longitudHilo = 3,
   dañoBase = 5
}

unBaculo = Baculo {
   nombre = "unbaculo",
   inteligencia = 5
}

unArmadura = [Parte{defensa = 1, durabilidad = 10},
    Parte{defensa= 2, durabilidad = 10},
    Parte{defensa= 3, durabilidad = 0},
    Parte{defensa= 4, durabilidad = 10}]

unPersonaje = Personaje {
   arma = unaEspada,
   vida = 100,
   armadura = unArmadura
}

main :: IO()
main = hspec $ do
   describe "Tests de prueba" $ do
      it "la verdad y la verdad" $ do
         True `shouldBe` True
