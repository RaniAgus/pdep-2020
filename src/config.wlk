  
import wollok.game.*
import objetosBasicos.*
import enemigos.*
import trampas.*
// probando branches
object config {
	
	method finalizar() {
		game.say(torre, "FIN DEL JUEGO!")
		game.schedule(2 * 1000, { game.stop() })
	}
	
	method chocar(zombie){
		game.onCollideDo(zombie,{planta=>planta.morir()})
	}

	method configurarTeclas(){
		keyboard.q().onPressDo({game.addVisual(plantita)})
	}
	
	method configurarAcciones(){
		game.onTick(1000, "mover aleatoriamente", { zombie.caminar()})
	
}

	
}

object plantita inherits Planta {

	override method position() {
		return game.at(1,5)
	}

	override method image() {
		return "plantita2.png"
	}

}
