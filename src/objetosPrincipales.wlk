import wollok.game.*
import config.*

class ElementoVivo { 
	var property image
	var property position
	
	var vida
	method vida() = vida
	
	method recibirAtaque(atacante) {
		vida = 0.max(vida - atacante.danio())
		if(vida == 0) {
			self.morir()
		}
	}
	
	method morir(){}
}

class Muro {
	var property position 
	method image() = "null.png"
	
	method morir() {
		config.finalizar()
	}
}

object torre inherits ElementoVivo(vida = 10000) {
	const muros = []
	
	method agregarMuro(muro) {
		muros.add(muro)
		game.addVisual(muro)
	}	
		
		
	override method morir() {
		config.finalizar()
	}	
}



