import wollok.game.*
import config.*
import objetosPrincipales.*
import tablero.*

class Bala inherits ElementoVivo {
	var nroBala = 0
	method activar(lanzaguizantes) {
 		position = lanzaguizantes.position().left(1)
 		game.addVisual(self)
 		game.onTick(111, "Cambiar imagen", { self.cambiarImagen() })
 		game.onTick(250, "Moverse", { self.moverse() })
		game.onCollideDo(self, { zombi => if(tablero.esZombie(zombi)) zombi.recibirAtaque(self) })
 	}

 	method cambiarImagen() {
 		nroBala = (nroBala + 1) % 3
 		
 		image = "bala" + nroBala.toString() + ".png"
 	}
 	
 	method moverse() {
 		position = position.left(1)
 	}
}

class Planta inherits ElementoVivo {
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
	const bala = new Bala(image = "bala0.png", vida = 0, danio = 25, velocidadAtaque = 3000)
	override method atacar(){
		bala.activar(self)
	}
}

class Girasol inherits Planta {
	override method atacar(){
		game.onTick(1000, "Recolectar Elixir", {
			cursor.incrementarElixirDisponible()
			vida -= 10
			if(vida == 0) self.morir()
		})
	}
}
