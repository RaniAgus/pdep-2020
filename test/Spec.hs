import Test.Hspec
import Tecnicas

objetivo :: Objetivo
objetivo = "bolsa de entrenamiento"

main :: IO()
main = hspec $ do
   describe "Tecnicas de Combate" $ do
      it "presion de un golpe sobre un objetivo" $ do
         expectationFailure "Falta implementar"

      it "presion de golpes normales consecutivos" $ do
         expectationFailure "Falta implementar"

      it "presion de gomu gomu elephant gatling" $ do
         expectationFailure "Falta implementar"

      it "objetivo dificil" $ do
         expectationFailure "Falta implementar"

      it "objetivo no dificil" $ do
         expectationFailure "Falta implementar"


---------------- BORRAR ESTAS PRUEBAS AL RESOLVER EL EJERCICIO ----------------
   -- Para hacer pruebas sobre funciones que devuelven booleanos se pueden usar 
   -- shouldSatisfy y shouldNotSatisfy de la siguiente manera
      it "BORRAME" $ do
         2 `shouldSatisfy` even
      it "BORRAME" $ do
         1 `shouldNotSatisfy` even
---------------- BORRAR ESTAS PRUEBAS AL RESOLVER EL EJERCICIO ----------------


      it "accesibilidad baja" $ do
         expectationFailure "Falta implementar"

      it "accesibilidad alta" $ do
         expectationFailure "Falta implementar"