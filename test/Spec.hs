import Test.Hspec
import Lib

main :: IO()
main = hspec $ do
   describe "Tests de prueba" $ do
      it "prueba de booleanos" $ do
         not False `shouldBe` True
