import wollok.game.*
import config.*
import objetosPrincipales.*
import tablero.*

class Planta inherits ElementoVivo {
	// cada personaje (trampa) va a tener un elixir necesario para que éste funcione
	const property elixirNecesario 
	
	/*method atacar(atacado) {
		estaAtacando = true
		game.onTick(velocidadAtaque, "ATACAR", {atacado.recibirAtaque(self)})
	}*/

	/*method detenerAtaque(atacado) {
		game.removeTickEvent("ATACAR")
		estaAtacando = false
	}*/
	
	// Lo sobreescribo usando lo que hace su metodo padre y elimino la posicion que ocupaba
	override method morir(){
		tablero.eliminarPlanta(self)
	}

}
// La margarita sería una trampa, cuando el zombi la pisa hace un ataque
class Margarita inherits Planta {
	override method morir() {
		//game.onCollideDo(self, {zombi => self.atacar(zombi) })
		game.colliders(self).forEach({ zombi => zombi.recibirAtaque(self) })
		super()
	}
}

// El lanzaguizantes dispararía en un cierto rango, hay que ver cómo hacer eso
class Lanzaguisantes inherits Planta {
	
}