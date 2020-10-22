import wollok.game.*
import objetosBasicos.*
import enemigos.*
import trampas.*
import creadorPlantas.*

object config {
	
	
	method finalizar(murito) {
		game.say(murito, "FIN DEL JUEGO!")
		game.schedule(2 * 1000, { game.stop() })
	}
	
	/*method chocar(){
		game.onCollideDo(zombie,{algo=>algo.morir()})
	} */
	method agregarZombie(){
		const zombi=new Zombie()
		game.addVisual(zombi)
		game.onTick(2000,"Caminar a la derecha",{zombi.caminar()})
	}
		
	method configurarTeclas(){
		var plantita 
		keyboard.q().onPressDo({plantita=creadorDePlantas.agregarPlanta(1)})
		keyboard.up().onPressDo({plantita.moverHaciaArriba()})
		keyboard.down().onPressDo({plantita.moverHaciaAbajo()})
		keyboard.right().onPressDo({plantita.moverHaciaLaDerecha()})
		keyboard.left().onPressDo({plantita.moverHaciaLaIzquierda()})
		keyboard.enter().onPressDo({plantita.seEstaMoviendo(false)})
		
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

/* object plantita {

	var property seEstaMoviendo = true
	var property position = game.center()

	method image() {
		return "plantita2.png"
	}

	 method moverHaciaArriba(){
		if(self.seEstaMoviendo())
	 	position =position.up(1)
	}
	method moverHaciaAbajo(){
		if(self.seEstaMoviendo())
	 	position =position.down(1)
	}
	method moverHaciaLaDerecha(){
		if(self.seEstaMoviendo())
	 	position =position.right(1)
	}
	method moverHaciaLaIzquierda(){
		if(self.seEstaMoviendo())
	 	position =position.left(1)
	} */

