import wollok.game.*
import enemigos.*
import Plantas.*
import config.*
import Elemento.*

 object cursor {

	var property seEstaMoviendo = true
	// Guarda posiciones del juego ya ocupadas por una planta
	var posicionesOcupadas =#{}

	var property planta = null
	
	method position(){
		return planta.position()
	}
	

	method image() {
		return planta.image()
	}
	// Revisa si la posicion ya esta ocupada
	method estaOcupada(posicion) = posicionesOcupadas.contains(posicion)
	method morir(){}
	//Le agregue el condicional para que chequee si la posicion esta libre o no, si lo esta la agrega a la lista de 
	// ocupadas, sino te tira un mensaje en el juego (este metodo deberia delegarse
	method posicionarPlanta(){
		if(!self.estaOcupada(self.position())){
		game.addVisual(planta)
		game.removeVisual(self)
		seEstaMoviendo = false
		posicionesOcupadas.add(self.position())
		} else{
			game.say(cursor,"La posicion ya se encuentra ocupada, elija otra")
		}

	}
	// Elimina la posicion de la planta que recibe, para que pueda volver a usarse por otra planta
	//( la invoca el metodo morir de las plantas
	method eliminarPosicion(posicion){
		posicionesOcupadas.remove(posicion)
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
