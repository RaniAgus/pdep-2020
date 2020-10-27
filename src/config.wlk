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
		self.configurarPlantas()
		self.configurarNiveles()
		self.configurarElixir()
		self.agregarTorre()
	}
	
	method finalizar() {
		game.say(cursor, "FIN DEL JUEGO!")
		game.schedule(2 * 1000, { game.stop() })
	}
		
	method configurarTeclas() {

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
	
	method configurarPlantas() {
		//Se agregan los creadores de Plantas con sus variables iniciales
		cursor.agregarPlanta( ({ => new Margarita(
			danio = 25,
			velocidadAtaque = 3000, 
			vida = 0, 
			position = cursor.position(),
			image = "margarita.png"
		) }), "margarita-gris.png", 2)
		
		cursor.agregarPlanta( ({ => new Lanzaguisantes(
			danio = 25, 
			velocidadAtaque = 3000, 
			vida = 0, 
			position = cursor.position(),
			image = "lanzaguisante.png"
		) }), "lanzaguisante-gris.png", 5) 
	}
	
	method configurarNiveles(){
		//NIVEL 1 - 5 Zombies (velocidad 1 / 2000)
		game.onTick(3*1000,"Agregar zombies nivel 1",{tablero.agregarZombie(2000)})
		game.schedule(16*1000, { => game.removeTickEvent("Agregar zombies nivel 1") })
		//NIVEL 2 - 10 Zombies (velocidad 1 / 1300)
		game.schedule(26*1000, { => game.onTick(3000,"Agregar zombies nivel 2",{tablero.agregarZombie(1300)}) })
		game.schedule(60*1000, { => game.removeTickEvent("Agregar zombies nivel 2") })
		//NIVEL 3 - 15 Zombies (velocidad 1 / 9000)
	    game.schedule(70*1000, { => game.onTick(3000,"Agregar zombies nivel 3",{tablero.agregarZombie(900)}) })
	    game.schedule(119*1000, { => game.removeTickEvent("Agregar zombies nivel 3") })
	}
	
	method configurarElixir() {
		game.onTick(1000, "Incrementar elixir", { cursor.incrementarElixirDisponible() })
	}
	
	method agregarTorre() {
		(2 .. 9).forEach({posEnY => torre.agregarMuro(new Muro(position = game.at(19, posEnY)))})
	}
	
}