import wollok.game.*
import Elemento.*
import enemigos.*
import Plantas.*
import creadorPlantas.*
import cursor.*
import Zombie.*

object config {
	var plantita 
	
	// Hice este metodo para directamente cargar esto en el juego.wpgm, traten de agregar aca
	method iniciar(){
		self.configurarTeclas()
		self.configurarAcciones()
		self.agregarTorre()
	}
	
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
		// TODO delegar los bloques de codigo
		keyboard.q().onPressDo({
			cursor.planta(creadorDePlantas.agregarPlanta(1))
			game.addVisual(cursor)
			cursor.seEstaMoviendo(true)
		})
		// Se droppea la planta lanzaguisantes
		keyboard.w().onPressDo({
			cursor.planta(creadorDePlantas.agregarPlanta(2))
			game.addVisual(cursor)
			cursor.seEstaMoviendo(true)
		})
		// Con esta tecla se borra la planta que tiene el cursor actual, por si el jugador quiere droppear otra
		// planta en lugar de la que eligio
		keyboard.a().onPressDo({game.removeVisual(cursor)})
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
//Lo agrego para ir teniendo algo de base grafica
object tableroDePlantas{
	method image() ="tableroDePlantas.png"
	method position()= game.at(5,0)
	method mostrar()=game.addVisual(self)
}



