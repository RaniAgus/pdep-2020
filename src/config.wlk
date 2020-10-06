import wollok.game.*
import objetosBasicos.*
import enemigos.*
import trampas.*

object config {
	method finalizar() {
		game.say(torre, "FIN DEL JUEGO!")
		game.schedule(2 * 1000, { game.stop() })
	}
}

object plantita {

	method position() {
		return game.at(1,5)
	}

	method image() {
		return "plantita2.png"
	}

}