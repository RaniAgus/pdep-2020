import wollok.game.*
import config.*

class Elemento {
	var property vida 
	var property image = ""
	var property position 
	
	method vida() = vida
	
	method recibirAtaque(atacante) {
		vida = 0.max(vida - atacante.danio())
		if(vida == 0) {
			atacante.detenerAtaque(self)
			self.morir()
		}
	}
	
	method morir(){
		game.removeVisual(self)
	}
}

class Muro inherits Elemento{
	
	
	override method image() = "muro.png"
	
	
	override method morir() {
		config.finalizar(self)
	}
	
}






	



