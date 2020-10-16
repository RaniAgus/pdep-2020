  
import wollok.game.*
import objetosBasicos.*
import enemigos.*
import trampas.*
// probando branches
object config {
	
	method finalizar(murito) {
		game.say(murito, "FIN DEL JUEGO!")
		game.schedule(2 * 1000, { game.stop() })
	}
	
	method chocar(zombi){
	}

	method configurarTeclas(){
		keyboard.q().onPressDo({game.addVisual(plantita)})
	}
	
	method configurarAcciones(){
		game.onTick(1000, "mover aleatoriamente", { zombie.caminar()})
	}
	
	method agregarTorre(){

		const torre = []
		(1 .. 9).forEach({posEnY => torre.add(new Muro(vida= 500, position = game.at(19, posEnY)))})
		
		torre.forEach({murito => game.addVisual(murito)})
		
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
