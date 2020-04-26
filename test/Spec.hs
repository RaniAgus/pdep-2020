import Test.Hspec
import CerebroMagico

main :: IO()
main = hspec $ do
  describe "esVocal" $ do
     it "letra es vocal" $ do
        esVocal 'a' `shouldBe` True
     it "letra no es vocal" $ do
        esVocal 'b' `shouldBe` False
  describe "esParticular" $ do
     it "nombre que comienza con vocal es particular" $ do
        esParticular "Ana" `shouldBe` True
     it "nombre largo es particular" $ do
        esParticular "Fernando" `shouldBe` True
     it "nombre corto que comienza con consonante no es particular" $ do
        esParticular "Beto" `shouldBe` False
  describe "esMagico" $ do
     it "nombre que termina en vocal no es magico" $ do
        esMagico "Ana" `shouldBe` False
     it "nombre que no es particular no es magico" $ do
        esMagico "Flor" `shouldBe` False
     it "nombre que es particular y termina en consonante es magico" $ do
        esMagico "Omar" `shouldBe` True
