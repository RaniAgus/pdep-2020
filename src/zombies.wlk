import wollok.game.*
import objetosPrincipales.*
import tablero.*

class Zombie inherits ElementoVivo {
	var estaCongelado=false
	method caminar() {
		if(not estaCongelado)
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
	method congelar(){
		estaCongelado=true
		game.schedule(3000,{estaCongelado=false})
	}
}	