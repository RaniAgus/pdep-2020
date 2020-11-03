import wollok.game.*
import zombies.*
import plantas.*
import config.*

 object cursor {
 	var property position = game.at(10,5)
	var property image = "null.png"
 	
 	//El juego arranca sin seleccionar ninguna planta y con el elixir a la mitad
	var creadorSeleccionado = null
	
	//Selecciona un creador de plantas de la lista y cambia su imagen a la correspondiente
	method seleccionarPlanta(unCreador) {
		creadorSeleccionado = unCreador
		image = unCreador.seleccionarImagen()
	}
	
	//Al presionar enter, se intenta posicionar la planta usando el creador seleccionado
	method posicionarPlanta(){
		if(creadorSeleccionado == null) {
			self.error("No se seleccionó ningún personaje!!")
		}
		contadorElixir.gastarElixir(creadorSeleccionado.elixirNecesario())
		tablero.agregarPlanta(creadorSeleccionado.crearPlanta())
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
	
	//Para cuando se choque con una bala o zombie
	method recibirAtaque(atacante){}
	method morir(){}
}

object tablero {
	const plantasEnJuego = []
	const property zombiesEnJuego = []
	
	method estaOcupada(posicion) {
		return plantasEnJuego.any({ planta => planta.position() == posicion }) 
			|| zombiesEnJuego.any({ zombie => zombie.position() == posicion })
	}
	
	method agregarPlanta(planta) {
		if(self.estaOcupada(planta.position())) {
			cursor.error("Esta posición está ocupada, busque otra!!")
		}
		plantasEnJuego.add(planta)
		game.addVisual(planta)
		game.showAttributes(planta)
		planta.iniciar()
	}
	
	method agregarZombie(zombie, velocidadMovimiento){
		game.addVisual(zombie)
		game.showAttributes(zombie)
		game.onTick(velocidadMovimiento, "Caminar a la derecha",{zombie.caminar()})
		game.onCollideDo(zombie,{algo => algo.morir()})
		zombiesEnJuego.add(zombie)
	}
	
	method eliminarPlanta(planta){
		planta.detenerAtaque()
		plantasEnJuego.remove(planta)
		game.removeVisual(planta)
	}
	
	method eliminarZombie(zombie){
		zombiesEnJuego.remove(zombie)
		game.removeVisual(zombie)
		if(zombiesEnJuego.isEmpty()) {
			niveles.iniciarNuevaOleada()
		}
	}
	
	method esZombie(objeto) = zombiesEnJuego.contains(objeto)
	method esPlanta(objeto) = plantasEnJuego.contains(objeto)
	
	method finalizar() {
		zombiesEnJuego.forEach({ zombie => if(zombie.position().x() < 19) game.removeVisual(zombie) })
		plantasEnJuego.forEach({ planta => game.removeVisual(planta) })
	}
}

object contadorElixir{
	var property image = "elixir.png"
	var property position = game.at(-1,-2)
	
 	var elixirDisponible = 5
 	
 	method incrementarElixirDisponible() { 
		elixirDisponible = 10.min(elixirDisponible + 1)
		self.imagenSegunCantElixir()
	}
	
	method gastarElixir(elixir) {
		if(elixir > elixirDisponible) {
			cursor.error("No se cuenta con el elixir suficiente!!")
		}
		elixirDisponible -= elixir
		self.imagenSegunCantElixir()
	}
	
	method imagenSegunCantElixir(){
		image = "elixir" + elixirDisponible.toString() + ".png"
	}
}

