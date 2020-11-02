import wollok.game.*
import objetosPrincipales.*
import plantas.*
import zombies.*
import tablero.*
import creadores.*

class Disparo {
	var property image
	var property position
	
	var id
	var rango
	var danio
	var velocidadAtaque
	
	method danio() = danio
	
	method disparar() {
 		game.addVisual(self)
		game.schedule(velocidadAtaque * rango, { if(game.hasVisual(self)) self.morir() })
	}
	
	method moverse() {
 		position = position.left(1)
 	}
	
	method morir() {
		game.removeVisual(self)
	}
}

class Bala inherits Disparo {
	var nroImagen = 0
	const cantImagenes = 3
	
	override method disparar() {
		super()
 		game.onTick(velocidadAtaque, "MoverBala" + id, { self.moverse() })
 		game.onTick(velocidadAtaque / cantImagenes, "CambiarImagenBala" + id, { self.cambiarImagen() })
 		game.onCollideDo(self, 
 			{ zombi => 
 				if(tablero.esZombie(zombi)) {
					zombi.recibirAtaque(self)
					self.morir()
				}
			}
		)
 	}
 
 	method cambiarImagen() {
 		nroImagen = (nroImagen + 1) % cantImagenes
 		image = "bala" + nroImagen.toString() + ".png"
 	}

 	
 	override method morir() {
 		game.removeTickEvent("CambiarImagenBala" + id)
 		game.removeTickEvent("MoverBala" + id)
 		super()
 	}
}

 class Hielo inherits Disparo {
 	var tiempoEfecto
 	
 	override method disparar() {
 		super()
 		game.onTick(200, "MoverHielo" + id, { self.moverse() })
		game.onCollideDo(self, 
			{ zombi => 
				if(tablero.esZombie(zombi)) {
					zombi.congelar(tiempoEfecto)
				}
			}
		)
 	}
 	
 	 override method morir() {
 		game.removeTickEvent("MoverHielo" + id)
 		super()
 	}
 }