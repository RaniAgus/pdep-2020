import wollok.game.*
import objetosBasicos.*
import enemigos.*
import trampas.*

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
	
	method agregarPlanta(){
		const plantita= new Planta(elixirNecesario = 0, danio = 0, velocidadAtaque = 0, vida = 0, position = game.center())
		game.addVisual(plantita)
		// TODO revisar para implementacion
	}
 
	method configurarTeclas(){
		keyboard.up().onPressDo({plantita.caminar(plantita.position().up(1))})
		keyboard.down().onPressDo({plantita.caminar(plantita.position().down(1))})
		keyboard.right().onPressDo({plantita.caminar(plantita.position().right(1))})
		keyboard.left().onPressDo({plantita.caminar(plantita.position().left(1))})
		// TODO preguntar a santy/dany
		keyboard.enter().onPressDo({plantita.position()})
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
// esto lo quiero volar a la miercoles pero me rompe con lo de las teclas

object plantita {

	var property position = game.center()

	method image() {
		return "plantita2.png"
	}
	method caminar(nuevaPosicion){
	 	position =nuevaPosicion
	 }

}