import wollok.game.*
import zombies.*

 object cursor {
	const creadoresDePlantas = []
	const imagenes = []
	
	var seleccionado = -1
	
	var property position = game.at(10, 10)
	
	method image() = if(seleccionado < 0) "null.png" else imagenes.get(seleccionado)
	
	//Para cuando se choque con zombie
	method morir(){}
	
	//Agrega una planta seleccionable, junto con su imagen en blanco y negro
	method agregarPersonaje(creadorDePlanta, imagen){
		creadoresDePlantas.add(creadorDePlanta)
		imagenes.add(imagen)
		
	}
	
	// Guarda posiciones del juego ya ocupadas por una planta
	method seleccionarPlanta(index){
		seleccionado = index % creadoresDePlantas.size()
	}
	
	method posicionarPlanta(){
		if(seleccionado < 0) {
			self.error("No se seleccionó ningún personaje!!")
		}
		if(tablero.estaOcupada(position)) {
			self.error("Esta posición está ocupada!!")
		}
		tablero.insertarPlanta( creadoresDePlantas.get(seleccionado).apply() )
	}
	
	method moverHaciaArriba() {
		if(position.y() < 9) {
	 		self.position(position.up(1))
		}	 	
	}
	method moverHaciaAbajo(){
		if(position.y() > 2) {
	 		self.position(position.down(1))
		}	 	
	}
	method moverHaciaLaDerecha(){
		if(position.x() < 18) {
	 		self.position(position.right(1))
		}
	}
	method moverHaciaLaIzquierda(){
		if(position.x() > 4) {
	 		self.position(position.left(1))
		}
	} 
}

object tablero {
	const plantasEnJuego = []
	const property zombiesEnJuego=[]
	
	method estaOcupada(posicion) {
		return plantasEnJuego.any({ planta => planta.position() == posicion }) 
			|| zombiesEnJuego.any({ zombie => zombie.position() == posicion })
	}
	
	method insertarPlanta(planta) {
		plantasEnJuego.add(planta)
		game.addVisual(planta)
		game.showAttributes(planta)
	}
	
	method insertarZombie(){
		const zombie = new Zombie (
			position = game.at(0, 2.randomUpTo( game.height() )), 
			image = "zombie.png",
			vida = 100, 
			danio = 0, 
			velocidadAtaque = 0
		)
		
		game.addVisual(zombie)
		game.showAttributes(zombie)
		game.onTick(2000,"Caminar a la derecha",{zombie.caminar()})
		game.onCollideDo(zombie,{algo => algo.morir()})
		zombiesEnJuego.add(zombie)
	}
	
	method eliminarPlanta(planta){
		plantasEnJuego.remove(planta)
		game.removeVisual(planta)
	}
	
	method eliminarZombie(zombie){
		zombiesEnJuego.remove(zombie)
		game.removeVisual(zombie)
	}
}
