import wollok.game.*
import objetosPrincipales.*
import plantas.*
import zombies.*
import tablero.*
import creadores.*
import menuInicio.*


object config {
	
	method iniciar(){
		game.addVisual(cursor)		
		menuInicio.cerrarInicio()
		self.configurarElixir()
		self.agregarTorre()	
		niveles.iniciarNuevaOleada()
		game.addVisual(contadorElixir)
	}
	
	method finalizar() {
		tablero.finalizar()
		game.removeTickEvent("IncrementarElixir")
		game.say(cursor, "FIN DEL JUEGO!")
		game.schedule(5 * 1000, { game.stop() })
	}
		
	method configurarTeclas() {
		keyboard.q().onPressDo({cursor.seleccionarPlanta(creadorDeMargaritas)})
		keyboard.w().onPressDo({cursor.seleccionarPlanta(creadorDeLanzaguizantes)})
		keyboard.e().onPressDo({cursor.seleccionarPlanta(creadorDeGirasoles)})
		keyboard.r().onPressDo({cursor.seleccionarPlanta(creadorDeHielaguisantes)})
		
		keyboard.up().onPressDo({cursor.moverHaciaArriba()})
		keyboard.down().onPressDo({cursor.moverHaciaAbajo()})
		keyboard.right().onPressDo({cursor.moverHaciaLaDerecha()})
		keyboard.left().onPressDo({cursor.moverHaciaLaIzquierda()})
		
		keyboard.enter().onPressDo({cursor.posicionarPlanta()})
		keyboard.space().onPressDo({self.iniciar()})
	}
	
	method configurarElixir() {
		game.onTick(1000, "IncrementarElixir", { contadorElixir.incrementarElixirDisponible() })
	}
	
	method agregarTorre() {
		(2 .. 9).forEach({posEnY => torre.agregarMuro(new Muro(position = game.at(19, posEnY)))})
	}
	
}

object niveles {
	var nivel = 1
	const frecuenciaZombies = 3000
	//TODO: Agregar position e image
	
	method iniciarNuevaOleada() {
		var velocidadMovimiento = 6000
		var vidaZombie = 100
		const cantidadZombies = (4 * nivel + nivel / 2).truncate(0)
		
		nivel.times({ i => 
			velocidadMovimiento = (velocidadMovimiento - velocidadMovimiento / (i+2)).truncate(0)
			vidaZombie = (vidaZombie + vidaZombie / 2).truncate(0)
		})
		
		game.onTick(
			  frecuenciaZombies
			, "Oleada"
			, {	const zombie = new Zombie (
			  		  position = game.at(0, 2.randomUpTo( game.height() ))
					, image = "zombie.png"
					, vida = vidaZombie
				)
				tablero.agregarZombie(zombie, velocidadMovimiento) }
		)
		game.schedule(cantidadZombies * frecuenciaZombies, { => game.removeTickEvent("Oleada") })
		nivel++
	}	
}