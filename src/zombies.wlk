import wollok.game.*
import objetosPrincipales.*
import tablero.*

class Zombie inherits ElementoVivo {
	var estaCongelado = false
	method caminar() {
		if(not estaCongelado)
	 		position = position.right(1)
	}
	
	override method morir() {
		tablero.eliminarZombie(self)
	}
	
	method congelar(tiempoEfecto) {
		estaCongelado = true
		game.schedule(tiempoEfecto, { estaCongelado = false } )
	}
}	