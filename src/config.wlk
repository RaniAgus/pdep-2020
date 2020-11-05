import wollok.game.*
import objetosPrincipales.*
import plantas.*
import zombies.*
import tablero.*
import creadores.*
import sonidos.*
import puntaje.*
import menuInicio.*

object config {
	var property juegoIniciado=false
	method iniciar(){
		juegoIniciado=true
		game.addVisual(cursor)		
		menuInicio.cerrarInicio()
		self.configurarElixir()
		self.agregarTorre()	
		niveles.iniciarNuevaOleada()
		game.addVisual(contadorElixir)
		puntaje.iniciarPuntaje()
	}
	
	method finalizar() {
		tablero.finalizar()
		sonido.pararMusicaFondo()
		game.removeTickEvent("IncrementarElixir")
		game.say(cursor, "FIN DEL JUEGO!")
		sonido.tocar("gameOver.mp3")
		game.addVisual(gameOver)
		game.schedule(10 * 1000, { game.stop() })
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
		
		keyboard.space().onPressDo({self.iniciar() sonido.arrancarMusicaFondo()})
	}
	
	method configurarElixir() {
		game.onTick(1000, "IncrementarElixir", { contadorElixir.incrementarElixirDisponible() })
	}
	
	method agregarTorre() {
		(2 .. 9).forEach({posEnY => torre.agregarMuro(new Muro(position = game.at(19, posEnY)))})
	}
	
}

object gameOver{
	method image()="gameOver.png"
	method position()=game.at(4,4)}