import wollok.game.*
import zombies.*
import plantas.*

 object cursor {
 	var property position = game.center()
	var property image = "null.png"
 	
 	//El juego arranca sin seleccionar ninguna planta y con el elixir a la mitad
	var seleccionado = null
 	var elixirDisponible = 5
 	
 	//Se cuenta con una lista de creadores de plantas a seleccionar
	const creadoresDePlantas = []
	const elixires = []
	const imagenes = []
	
	method incrementarElixirDisponible() { elixirDisponible = 10.min(elixirDisponible + 1) }
	
	method agregarPlanta(creadorDePlanta, imagen, elixirNecesario){
		creadoresDePlantas.add(creadorDePlanta)
		imagenes.add(imagen)
		elixires.add(elixirNecesario)
	}
	
	method atacar(){}
	
	//Selecciona un creador de plantas de la lista y cambia su imagen a la correspondiente
	method seleccionarPlanta(index) {
		seleccionado = index
		image = imagenes.get(index % imagenes.size())
	}
	
	//Al presionar enter, se intenta posicionar la planta usando el creador seleccionado
	method posicionarPlanta(){
		if(seleccionado == null) {
			self.error("No se seleccionó ningún personaje!!")
		}
		
		if(elixires.get(seleccionado) > elixirDisponible) {
			self.error("No se cuenta con el elixir suficiente!!")
		}
		
		if(tablero.estaOcupada(position)) {
			self.error("Esta posición está ocupada, busque otra!!")
		}
		
		tablero.agregarPlanta(creadoresDePlantas.get( seleccionado % creadoresDePlantas.size() ).apply())
		elixirDisponible -= elixires.get( seleccionado % elixires.size() )
	}
	
	//Configuración de movimiento
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
	
	//Para cuando se choque con una planta o zombie
	method recibirAtaque(atacante){}
	method morir(){}
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
		planta.atacar()
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
		game.onTick(velocidadMovimiento, "Caminar a la derecha",{zombie.caminar()})
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
