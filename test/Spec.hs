import Test.Hspec
import Tecnicas

objetivo :: Objetivo
objetivo = "bolsa de entrenamiento"

main :: IO()
main = hspec $ do
   describe "Tecnicas de Combate" $ do
      it "presion de un golpe sobre un objetivo" $ do
         golpe 200 "bolsa de entrenamiento" `shouldBe` 68

      it "presion de golpes normales consecutivos" $ do
         golpesNormalesConsecutivos "bolsa de entrenamiento" `shouldBe` 81

      it "presion de gomu gomu elephant gatling" $ do
         golpeGomuElephantTraining "bolsa de entrenamiento" `shouldBe` 61

      it "objetivo dificil" $ do
         "bolsa de entrenamiento" `shouldSatisfy` esDificil

      it "objetivo no dificil" $ do
         "gatito" `shouldNotSatisfy` esDificil

      it "accesibilidad baja" $ do
         accesibilidad "bolsa de entrenamiento" `shouldBe` 25

      it "accesibilidad alta" $ do
         accesibilidad "gatito" `shouldBe` 30