import wollok.game.*
import enemigos.*
import Plantas.*
import config.*
import Elemento.*

 object cursor {

	var property seEstaMoviendo = true

	var property planta = null
	
	method position(){
		return planta.position()
	}
	

	method image() {
		return planta.image()
	}
	
	method morir(){}
	method posicionarPlanta(){
		game.addVisual(planta)
		game.removeVisual(self)
		seEstaMoviendo = false
	}

	 method moverHaciaArriba(){
		if(self.seEstaMoviendo())	 	
	 	planta.position(planta.position().up(1))
	}
	method moverHaciaAbajo(){
		if(self.seEstaMoviendo())
	 	planta.position(planta.position().down(1))
	}
	method moverHaciaLaDerecha(){
		if(self.seEstaMoviendo())
	 	planta.position(planta.position().right(1))
	}
	method moverHaciaLaIzquierda(){
		if(self.seEstaMoviendo())
	 	planta.position(planta.position().left(1))
	} 
}
