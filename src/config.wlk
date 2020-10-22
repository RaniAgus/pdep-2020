import wollok.game.*
import objetosBasicos.*
import enemigos.*
import trampas.*
import creadorPlantas.*

object config {
	var plantita 
	
	method finalizar(murito) {
		game.say(murito, "FIN DEL JUEGO!")
		game.schedule(2 * 1000, { game.stop() })
	}
	
	method agregarZombie(){
		const zombi=new Zombie()
		game.addVisual(zombi)
		game.onTick(2000,"Caminar a la derecha",{zombi.caminar()})
		game.onCollideDo(zombi,{algo => algo.morir()})
	}
		
	method configurarTeclas(){

		keyboard.q().onPressDo({
			cursor.planta(creadorDePlantas.agregarPlanta(1))
			game.addVisual(cursor)
			cursor.seEstaMoviendo(true)
		})
		keyboard.up().onPressDo({cursor.moverHaciaArriba()})
		keyboard.down().onPressDo({cursor.moverHaciaAbajo()})
		keyboard.right().onPressDo({cursor.moverHaciaLaDerecha()})
		keyboard.left().onPressDo({cursor.moverHaciaLaIzquierda()})
		keyboard.enter().onPressDo({cursor.posicionarPlanta()})
		
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

 object cursor {

	var property seEstaMoviendo = true

	var property planta = null
	
	method position(){
		return planta.position()
	}
	

	method image() {
		return "plantita2.png"
	}
	
	method posicionarPlanta(){
		game.addVisual(planta)
		game.removeVisual(self)
		seEstaMoviendo = false
	}

	 method moverHaciaArriba(){
		if(self.seEstaMoviendo())	 	
	 	planta.position(planta.position().up(1))
	}
	method moverHaciaAbajo(){
		if(self.seEstaMoviendo())
	 	planta.position(planta.position().down(1))
	}
	method moverHaciaLaDerecha(){
		if(self.seEstaMoviendo())
	 	planta.position(planta.position().right(1))
	}
	method moverHaciaLaIzquierda(){
		if(self.seEstaMoviendo())
	 	planta.position(planta.position().left(1))
	} 
	}

