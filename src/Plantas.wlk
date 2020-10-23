import wollok.game.*
import enemigos.*
import config.*
import Elemento.*
import cursor.*

class Planta inherits Elemento {
//	const property id 
	const property elixirNecesario // cada personaje (trampa) va a tener un elixir necesario para que éste funcione
	var property seEstaMoviendo =true
	
	
	var danio
	var velocidadAtaque
	var estaAtacando = false

	method danio() = danio
	
	
	method atacar(atacado) {
		estaAtacando = true
		game.onTick(velocidadAtaque, "ATACAR", {atacado.recibirAtaque(self)})
	}
	
	method detenerAtaque(atacado) {
		game.removeTickEvent("ATACAR")
		estaAtacando = false
	}
	
	method moverHaciaArriba(){
		if(self.seEstaMoviendo())
	 	position =position.up(1)
	}
	method moverHaciaAbajo(){
		if(self.seEstaMoviendo())
	 	position =position.down(1)
	}
	method moverHaciaLaDerecha(){
		if(self.seEstaMoviendo())
	 	position =position.right(1)
	}
	method moverHaciaLaIzquierda(){
		if(self.seEstaMoviendo())
	 	position =position.left(1)
	}
	override method morir(){
		super()
		cursor.eliminarPosicion(self)
	}

}
// Esta es la plantita que usabamos para las pruebas
class Margarita inherits Planta{
	override method image()= "margarita.png"
}
// Se me ocurrio esta planta como otra , la foto fijense si pueden invertirla porque no la consegui asi
class Lanzaguisantes inherits Planta{
	override method image()= "lanzaguisantes.png"
}