import wollok.game.*
import objetosPrincipales.*
import tablero.*

class Zombie inherits ElementoVivo {
	method caminar() {
	 	position = position.right(1)
	}
	
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
		tablero.eliminarZombie(self)
	}
}	