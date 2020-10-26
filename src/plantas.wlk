import wollok.game.*
import config.*
import objetosPrincipales.*
import tablero.*

class Planta inherits ElementoVivo {
	const property elixirNecesario 
	// cada personaje (trampa) va a tener un elixir necesario para que éste funcione
	
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
		//game.onCollideDo(self, {zombi => self.atacar(zombi) })
		game.colliders(self).forEach({ zombi => zombi.recibirAtaque(self) })
		tablero.eliminarPlanta(self)
	}

}
// Esta es la plantita que usabamos para las pruebas
class Margarita inherits Planta {

}

// Se me ocurrio esta planta como otra , la foto fijense si pueden invertirla porque no la consegui asi
class Lanzaguisantes inherits Planta {
	
}