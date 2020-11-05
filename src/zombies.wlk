import wollok.game.*
import objetosPrincipales.*
import tablero.*
import sonidos.*
import puntaje.*

class Zombie inherits ElementoVivo {
	var estaCongelado = false
	
	method estaCongelado() = estaCongelado
	
	method caminar() {
		if(not estaCongelado)
	 		position = position.right(1)
	}
	
	override method morir() {
		puntaje.sumar(50)
		tablero.eliminarZombie(self)
	}
	
	method congelar(tiempoEfecto) {
		estaCongelado = true
		game.schedule(tiempoEfecto, { estaCongelado = false } )
	}
}	