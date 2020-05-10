import Test.Hspec
import Taller

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
      -- aca irian tests punto 2 parte 2
      it "auto que regula a menos de 2000 vueltas atendido por alfa" $ do
         (rpm.alfa) unAuto { rpm = 1999 } `shouldBe` 1999
      it "auto que regula a mas de 2000 vueltas atendido por alfa" $ do
         (rpm.alfa) unAuto { rpm = 2001 } `shouldBe` 2000
      it "auto atendido por bravo" $ do
         (desgasteLlantas.bravo) unAuto { desgasteLlantas = [1,1,1,1] } `shouldBe` [0,0,0,0]
      it "auto atendido por charly" $ do
         (rpm.charly) unAuto { rpm = 2001, desgasteLlantas = [1,1,1,1] } `shouldBe` 2000
         (desgasteLlantas.charly) unAuto { rpm = 2001, desgasteLlantas = [1,1,1,1] } `shouldBe` [0,0,0,0]
      -- aca irian tests punto 3 parte 2


