import wollok.game.*
import objetosPrincipales.*
import plantas.*
import zombies.*
import tablero.*
import creadores.*
import sonidos.*
import puntaje.*

class Disparo {
	var property image
	var property position

	var rango
	var danio
	var velocidad
	
	method danio() = danio
	
	method disparar() {
 		game.addVisual(self)
		game.schedule(velocidad * rango, { if(game.hasVisual(self)) self.morir() })
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
 		game.onTick(velocidad, "MoverBala" + self.identity().toString(), { self.moverse() })
 		game.onTick(velocidad / cantImagenes, "CambiarImagenBala" + self.identity().toString(), { self.cambiarImagen() })
 		game.onCollideDo(self, 
 			{ zombi => 
 				if(tablero.esZombie(zombi)) {
					zombi.recibirAtaque(self)
					sonido.tocar("danioBala.wav")
					puntaje.sumar(4)
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
 		game.removeTickEvent("CambiarImagenBala" + self.identity().toString())
 		game.removeTickEvent("MoverBala" + self.identity().toString())
 		super()
 	}
}

 class Hielo inherits Disparo {
 	override method disparar() {
 		super()
 		game.onTick(velocidad, "MoverHielo" + self.identity().toString(), { self.moverse() })
		game.onCollideDo(self, 
			{ zombi => 
				if(tablero.esZombie(zombi)) {
					zombi.congelar(danio * 100)
					puntaje.sumar(2)
					
				}
			}
		)
 	}
 	
 	 override method morir() {
 		game.removeTickEvent("MoverHielo" + self.identity().toString())
 		super()
 	}
 }