import wollok.game.*
import config.*

class ElementoVivo { 
	var property image = ""
	var property position = game.origin()
	
	var vida = 0
	var danio = 0
	var velocidadAtaque = 0
	var estaAtacando = false
	
	method vida() = vida
	method danio() = danio
	
	method recibirAtaque(atacante) {
		vida = 0.max(vida - atacante.danio())
		if(vida == 0) {
			atacante.detenerAtaque(self)
			self.morir()
		}
	}
	
	method morir(){}
}

class Muro {
	var property position 
	method image() = "muro.png"
	
	/* TODO: Muro.recibirAtaque(atacante)
	method recibirAtaque(atacante) {
		saludMuro.recibirAtaque(atacante)
	}*/
	
	method morir() {
		config.finalizar(self)
	}
}

/* TODO: object saludMuro
object saludMuro {
	var vida = 0
	
	
	method recibirAtaque(atacante) {
		vida = 0.max(vida - atacante.danio())
		if(vida == 0) {
			atacante.detenerAtaque(self)
			self.morir(atacante)
		}
	}
	
	method morir(atacante) {
		config.finalizar(atacante)
	}
	
}
*/


