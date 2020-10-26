import wollok.game.*
import objetosPrincipales.*
import tablero.*

class Zombie inherits ElementoVivo {
	method caminar() {
	 	position = position.right(1)
	}
	
	method atacar(atacado) {
		estaAtacando = true
		game.onTick(velocidadAtaque, "ATACAR", {atacado.recibirAtaque(self)})
	}
	
	override method morir(){
		tablero.eliminarZombie(self)
	}
}	