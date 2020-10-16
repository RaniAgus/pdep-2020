  
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
	
	method chocar(zombie){
	}
	method agregarZombie(){
		const zombi=new Zombie()
		game.addVisual(zombi)
		game.onTick(2000,"Caminar a la derecha",{zombi.caminar()})
	}
 
	method configurarTeclas(){
		keyboard.q().onPressDo({game.addVisual(plantita)})
	}
	
	method configurarAcciones(){

		game.onTick(3000,"Agregar zombies",{self.agregarZombie()})
		
		game.schedule(16000, { => game.removeTickEvent("Agregar zombies") })
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