import wollok.game.*
import zombies.*

 object cursor {
	const creadoresDePlantas = []
	const imagenes = []
	
	var property position = game.center()
	
	//El juego arranca sin seleccionar nada, y con la imagen transparente
	var seleccionado = null
	
	//Cuando se selecciona una imagen, se obtiene la imagen en blanco y negro de la lista
	var property image = "null.png"
	
	//Para cuando se choque con una planta o zombie
	method recibirAtaque(atacante){}
	method morir(){}
	
	
	//Al principio del juego se agregan los creadores de plantas y una imagen en blanco y negro
	method agregarPlanta(creadorDePlanta, imagen){
		creadoresDePlantas.add(creadorDePlanta)
		imagenes.add(imagen)
	}
	
	//Selecciona un creador de plantas de la lista
	method seleccionarPlanta(index) {
		seleccionado = creadoresDePlantas.get(index % creadoresDePlantas.size())
		image = imagenes.get(index % creadoresDePlantas.size())
	}
	
	//Al presionar enter, se intenta posicionar la planta usando el creador seleccionado
	method posicionarPlanta(){
		if(seleccionado == null) {
			self.error("No se seleccionó ningún personaje!!")
		}
		
		//TODO: Acá entraría el error "no se cuenta con el elixir necesario"
		
		if(tablero.estaOcupada(position)) {
			self.error("Esta posición está ocupada, busque otra!!")
		}
		
		tablero.agregarPlanta(seleccionado.apply())
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
	
	method agregarPlanta(planta) {
		plantasEnJuego.add(planta)
		game.addVisual(planta)
		game.showAttributes(planta)
	}
	
	method agregarZombie(velocidadMovimiento){
		const zombie = new Zombie (
			position = game.at(0, 2.randomUpTo( game.height() )), 
			image = "zombie.png",
			vida = 100, 
			danio = 0, 
			velocidadAtaque = 0
		)
		
		game.addVisual(zombie)
		game.showAttributes(zombie)
		game.onTick(velocidadMovimiento * 1000, "Caminar a la derecha",{zombie.caminar()})
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
