import wollok.game.*
import objetosPrincipales.*
import plantas.*
import zombies.*
import tablero.*

object config {
	// Hice este metodo para directamente cargar esto en el juego.wpgm, traten de agregar aca
	method iniciar(){
		game.addVisual(cursor)
		
		self.configurarTeclas()
		self.configurarPersonajes()
		self.configurarAcciones()
		self.agregarTorre()
	}
	
	method finalizar(zombi) {
		game.say(zombi, "FIN DEL JUEGO!")
		game.schedule(2 * 1000, { game.stop() })
	}
		
	method configurarTeclas(){

		// Se droppea la planta lanzaguisantes
		keyboard.q().onPressDo({cursor.seleccionarPlanta(0)})
		keyboard.w().onPressDo({cursor.seleccionarPlanta(1)})
		keyboard.e().onPressDo({cursor.seleccionarPlanta(2)})
		keyboard.r().onPressDo({cursor.seleccionarPlanta(3)})
		
		
		// Con esta tecla se borra la planta que tiene el cursor actual, por si el jugador quiere droppear otra
		// planta en lugar de la que eligio
		keyboard.up().onPressDo({cursor.moverHaciaArriba()})
		keyboard.down().onPressDo({cursor.moverHaciaAbajo()})
		keyboard.right().onPressDo({cursor.moverHaciaLaDerecha()})
		keyboard.left().onPressDo({cursor.moverHaciaLaIzquierda()})
		
		keyboard.enter().onPressDo({cursor.posicionarPlanta()})
		
	}
	
	method configurarPersonajes() {
		cursor.agregarPersonaje(({ => new Margarita(elixirNecesario = 0, danio = 0, velocidadAtaque = 0, vida = 0, position = cursor.position()) }), "margarita-gris.png")
		cursor.agregarPersonaje(({ => new Lanzaguisantes(elixirNecesario = 0, danio = 0, velocidadAtaque = 0, vida = 0, position = cursor.position()) }), "lanzaguisante-gris.png")
	}
	
	method configurarAcciones(){
		game.onTick(3000,"Agregar zombies",{tablero.insertarZombie()})
		game.schedule(16000, { => game.removeTickEvent("Agregar zombies") })
	}
	
	method agregarTorre(){
		const torre = []
		(2 .. 9).forEach({posEnY => torre.add(new Muro(position = game.at(19, posEnY)))})
		
		torre.forEach({murito => game.addVisual(murito)})
	}
	
}