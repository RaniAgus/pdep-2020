import Test.Hspec
import CerebroMagico

main :: IO()
main = hspec $ do
  describe "esVocal" $ do
     it "letra es vocal" $ do
        expectationFailure "Falta implementar" 
     it "letra no es vocal" $ do
        expectationFailure "Falta implementar" 
  describe "esParticular" $ do
     it "nombre que comienza con vocal es particular" $ do
        expectationFailure "Falta implementar" 
     it "nombre largo es particular" $ do
        expectationFailure "Falta implementar" 
     it "nombre no es particular" $ do
        expectationFailure "Falta implementar" 
  describe "esMagico" $ do
     it "nombre que termina en vocal no es magico" $ do
        expectationFailure "Falta implementar" 
     it "nombre que no es particular no es magico" $ do
        expectationFailure "Falta implementar" 
     it "nombre es magico" $ do
        expectationFailure "Falta implementar" 
