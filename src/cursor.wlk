import wollok.game.*
import Plantas.*
import config.*
import Elemento.*
import creadorPlantas.*
import tablero.*

 object cursor {

	var property seEstaMoviendo = true
	// Guarda posiciones del juego ya ocupadas por una planta
	const posicionesOcupadas =#{}

	var property planta = null
	
	method position(){
		return planta.position()
	} 
 
	method image() {
		return planta.image()
	}

	method morir(){}
	method posicionarPlanta(){
		if(!tablero.estaOcupada(self.position())){
			game.addVisual(planta)    
			game.removeVisual(self)
			seEstaMoviendo = false
			tablero.agregarPosicion(self.position())
		} else{
			game.say(self,"La posicion ya se encuentra ocupada, elija otra")
		}

	}
	method insertarPlanta(opcion){
		self.planta(creadorDePlantas.agregarPlanta(opcion))
		game.addVisual(self)
		self.seEstaMoviendo(true)
	}
	method moverHaciaArriba(){
		if(self.seEstaMoviendo() and planta.position().y() < 9 )	 	
	 	planta.position(planta.position().up(1))
	}
	method moverHaciaAbajo(){
		if(self.seEstaMoviendo() and planta.position().y() > 2)
	 	planta.position(planta.position().down(1))
	}
	method moverHaciaLaDerecha(){
		if(self.seEstaMoviendo() and planta.position().x() < 18)
	 	planta.position(planta.position().right(1))
	}
	method moverHaciaLaIzquierda(){
		if(self.seEstaMoviendo() and planta.position().x() > 4)
	 	planta.position(planta.position().left(1))
	} 
}
