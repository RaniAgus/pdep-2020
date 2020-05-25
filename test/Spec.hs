import Test.Hspec
import Taller

unAuto = Auto {
    patente = "",
    desgasteLlantas = [],
    rpm = 0,
    temperaturaAgua = 0,
    ultimoArreglo = (0,0,0)
} 
autoImpar = unAuto{
    desgasteLlantas = [0.3,0.5,0.1]
}
autoPar = unAuto{
    desgasteLlantas = [0.3,0.5,0.2]
}
autoAReparar = Auto{
    patente="AAA000",
    desgasteLlantas= [0.2,0.2,0.2,0.2],
    rpm = 3000,
    temperaturaAgua=100,
    ultimoArreglo = (24,07,1999)
}

main :: IO()
main = hspec $ do
   describe "Taller mecanico" $ do
      it "anio de una fecha" $ do
         anio (1,1,2020) `shouldBe` 2020

      it "costo de reparacion de auto con patente de 7 digitos" $ do
         costoDeReparacion unAuto { patente = "AA000AA" } `shouldBe` 12500
      it "costo de reparacion de auto con patente de 6 digitos entre \"DJ\" y \"NB\" terminada en 4" $ do
         costoDeReparacion unAuto { patente = "EAA004" } `shouldBe` 18000
      it "costo de reparacion de auto con patente de 6 digitos entre \"DJ\" y \"NB\" no terminada en 4" $ do
         costoDeReparacion unAuto { patente = "EAA000" } `shouldBe` 20000
      it "costo de reparacion de auto con patente de 6 digitos no entre \"DJ\" y \"NB\"" $ do
         costoDeReparacion unAuto { patente = "AAA000" } `shouldBe` 15000

      it "auto con primera llanta poco desgastada" $ do
         unAuto { desgasteLlantas = [0.4,1,1,1]} `shouldNotSatisfy` esAutoPeligroso
      it "auto con primera llanta muy desgastada" $ do
         unAuto { desgasteLlantas = [0.6,0,0,0]} `shouldSatisfy` esAutoPeligroso
   
      it "auto cuyo último arreglo fue hace mucho" $ do
         unAuto { ultimoArreglo = (17,11,2010)} `shouldSatisfy` necesitaRevision
      it "auto cuyo último arreglo fue hace poco" $ do
         unAuto { ultimoArreglo = (17,11,2019)} `shouldNotSatisfy` necesitaRevision

      it "auto que regula a menos de 2000 vueltas atendido por Alfa" $ do
         (rpm.alfa) unAuto { rpm = 1999 } `shouldBe` 1999
      it "auto que regula a mas de 2000 vueltas atendido por Alfa" $ do
         (rpm.alfa) unAuto { rpm = 2001 } `shouldBe` 2000

      it "auto atendido por Bravo" $ do
         (desgasteLlantas.bravo) unAuto { desgasteLlantas = [1,1,1,1] } `shouldBe` [0,0,0,0]

      it "auto atendido por Charly" $ do
         (rpm.charly) unAuto { rpm = 2001, desgasteLlantas = [1,1,1,1] } `shouldBe` 2000
         (desgasteLlantas.charly) unAuto { rpm = 2001, desgasteLlantas = [1,1,1,1] } `shouldBe` [0,0,0,0]
    
      it "auto atendido por Tango" $ do
         (patente.tango) unAuto { patente = "AAA123" } `shouldBe` "AAA123"
         (desgasteLlantas.tango) unAuto { desgasteLlantas = [1,1,1,1] } `shouldBe` [1,1,1,1]
         (rpm.tango) unAuto { rpm = 10 } `shouldBe` 10
         (temperaturaAgua.tango) unAuto { temperaturaAgua = 90 } `shouldBe` 90
         (ultimoArreglo.tango) unAuto { ultimoArreglo = (17,11,2000) } `shouldBe` (17,11,2000)

      it "auto atendido por Zulu" $ do
         (temperaturaAgua.zulu) unAuto { temperaturaAgua = 60, desgasteLlantas = [1,1,1,1] } `shouldBe` 90
         (desgasteLlantas.zulu) unAuto { temperaturaAgua = 60, desgasteLlantas = [1,1,1,1] } `shouldBe` [0,0,1,1]
         
      it "auto atendido por Lima" $ do
         (desgasteLlantas.lima) unAuto { desgasteLlantas = [1,1,1,1] } `shouldBe` [0,0,1,1]
      
      it "lista con dos autos donde el primero tiene una cantidad de desgaste impar y el segundo par está ordenada." $ do
         [autoImpar,autoPar] `shouldSatisfy` estaOrdenadoTOC
      it "lista con dos autos donde ambos tienen una cantidad de desgaste impar no está ordenada según el criterio solicitado." $ do
         [autoImpar,autoImpar] `shouldNotSatisfy` estaOrdenadoTOC
      it "lista con dos autos donde ambos tienen una cantidad de desgaste par no está ordenada según el criterio solicitado." $ do
         [autoPar,autoPar] `shouldNotSatisfy` estaOrdenadoTOC
      it "lista con un solo auto que tiene una cantidad de desgaste impar está ordenada según el criterio solicitado." $ do
         [autoImpar] `shouldSatisfy` estaOrdenadoTOC 
      it "lista con un solo auto que tiene una cantidad de desgaste par no está ordenada según el criterio solicitado." $ do
         [autoPar] `shouldNotSatisfy` estaOrdenadoTOC 
      
      it "auto reparado recibe las tareas de cada técnico" $ do
         (desgasteLlantas.ordenReparacion autoAReparar [alfa,zulu]) (25,05,2020) `shouldBe` [0,0,0.2,0.2]
         (rpm.ordenReparacion autoAReparar [alfa,zulu]) (25,05,2020) `shouldBe` 2000
      it "auto reparado recibe la nueva fecha de último arreglo" $ do
         (ultimoArreglo.ordenReparacion autoAReparar [alfa,zulu]) (25,05,2020) `shouldBe` (25,05,2020)
          


