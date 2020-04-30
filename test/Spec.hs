import Test.Hspec
import Lib

main :: IO()
main = hspec $ do
   describe "Formas de pagar propina" $ do
      it "pago propina recomendada" $ do
         cuantoPagar propinaRecomendada 2000 `shouldBe` 2200
      it "no pago propina" $ do
         cuantoPagar propinaNoPaga 1000 `shouldBe` 1000
      it "pago propina conservadora para precio par" $ do
         cuantoPagar propinaConservadora 1000 `shouldBe` 1020
      it "pago propina conservadora para precio impar" $ do
         cuantoPagar propinaConservadora 1001 `shouldBe` 1026
      it "tio Carlos paga propina para mozo Carlos" $ do
         cuantoPagar (propinaTioCarlos "Carlos") 1000 `shouldBe` 1200
      it "tio Carlos paga propina para mozo de distinto nombre" $ do
         cuantoPagar (propinaTioCarlos "Juan") 1000 `shouldBe` 1050
      it "payaso paga propina a mozo con corbata Azul" $ do
         cuantoPagar (propinaPayasa "Azul") 500 `shouldBe` 550
      it "payaso paga propina a mozo con corbata Roja" $ do
         cuantoPagar (propinaPayasa "Roja") 500 `shouldBe` 600
      it "payaso paga propina a mozo con corbata Negra" $ do
         cuantoPagar (propinaPayasa "Negra") 500 `shouldBe` 500
      it "pago propina segun costo bajo" $ do
         cuantoPagar propinaSegunCosto 200 `shouldBe` 260
      it "pago propina segun costo medio" $ do
         cuantoPagar propinaSegunCosto 600 `shouldBe` 620
      it "pago propina segun costo alto" $ do
         cuantoPagar propinaSegunCosto 1200 `shouldBe` 1200
      it "mozo satisfecho con propina alta" $ do
         mozoEstaSatisfecho (\x -> x*0.15 + 0.01) 100 `shouldBe` True
      it "mozo satisfecho con propina baja" $ do
         mozoEstaSatisfecho (\x -> x*0.15 - 0.01) 100 `shouldBe` False