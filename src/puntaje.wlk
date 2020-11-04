import config.*
import wollok.game.*

object puntaje{
	var property puntaje=0
	method iniciarPuntaje(){
		game.addVisual(unidad)
		game.addVisual(decena)
		game.addVisual(centena)
		game.addVisual(unidadMil)
		
	}
	method sumar(puntos){
		puntaje+=puntos*(niveles.nivel()-1)
	}
}

class Numero{
	method calcularValor(puntaje,cifra){
		return (puntaje/cifra).truncate(0).toString().reverse().charAt(0)
	}
}
object unidad inherits Numero{
	var cifra=1

	method position()=game.at(19,1)
	method image()=self.calcularValor(puntaje.puntaje(),cifra)+".png"
}
object decena inherits Numero{
	var cifra=10
	method position()=game.at(18,1)
	method image()=self.calcularValor(puntaje.puntaje(),cifra)+".png"
}

object centena inherits Numero{
	var cifra=100
	method position()=game.at(17,1)
	method image()=self.calcularValor(puntaje.puntaje(),cifra)+".png"
	
}

object unidadMil inherits Numero{
	var cifra=1000
	method position()=game.at(16,1)
	method image()=self.calcularValor(puntaje.puntaje(),cifra)+".png"
	}
