import wollok.game.*
import objetosBasicos.*
import enemigos.*
import trampas.*


object config {
	
	method finalizar() {
		//game.say(torre, "FIN DEL JUEGO!")
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

	
}

object plantita inherits Planta {

	override method position() {
		return game.at(1,5)
	}

	override method image() {
		return "plantita2.png"
	}

}
