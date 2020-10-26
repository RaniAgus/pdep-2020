import wollok.game.*
import Elemento.*
import Plantas.*
import creadorPlantas.*
import cursor.*
import Zombie.*

object config {
	// Hice este metodo para directamente cargar esto en el juego.wpgm, traten de agregar aca
	var velocidad
	method iniciar(){
		self.configurarTeclas()
		self.configurarAcciones()
		self.agregarTorre()
	}
	
	/*method finalizar(murito) {
		game.say(murito, "FIN DEL JUEGO!")
		game.schedule(2 * 1000, { game.stop() })
	}*/
	
	method agregarZombie(velo){
		
		const zombi=new Zombie()
		game.addVisual(zombi)	
		game.onTick(velo,"Caminar a la derecha",{zombi.caminar()})
		game.onCollideDo(zombi,{algo => algo.morir()})
	}
		
	method configurarTeclas(){

		keyboard.q().onPressDo({cursor.insertarPlanta(1)})
		// Se droppea la planta lanzaguisantes
		keyboard.w().onPressDo({cursor.insertarPlanta(2)})
		// Con esta tecla se borra la planta que tiene el cursor actual, por si el jugador quiere droppear otra
		// planta en lugar de la que eligio
		keyboard.c().onPressDo({game.removeVisual(cursor)}) //cambio a c por clean
		keyboard.up().onPressDo({cursor.moverHaciaArriba()})
		keyboard.down().onPressDo({cursor.moverHaciaAbajo()})
		keyboard.right().onPressDo({cursor.moverHaciaLaDerecha()})
		keyboard.left().onPressDo({cursor.moverHaciaLaIzquierda()})
		keyboard.enter().onPressDo({cursor.posicionarPlanta()})
		
	}
	
	method configurarAcciones(){
		//NIVEL 1 - 5 Zombies
		game.onTick(3000,"Agregar zombies nivel 1",{self.agregarZombie(2000)}) //2000 es la velocidad
		game.schedule(16000, { => game.removeTickEvent("Agregar zombies nivel 1") })
		//NIVEL 2 - 10 Zombies
		game.schedule(26000, { => game.onTick(3000,"Agregar zombies nivel 2",{self.agregarZombie(1300)}) })
		game.schedule(60000, { => game.removeTickEvent("Agregar zombies nivel 2") })
		//NIVEL 3 - 15 Zombies
	    game.schedule(70000, { => game.onTick(3000,"Agregar zombies nivel 3",{self.agregarZombie(900)}) })
	    game.schedule(119000, { => game.removeTickEvent("Agregar zombies nivel 3") })

	   		
	}
	
	method agregarTorre(){

		const torre = []
		(2 .. 9).forEach({posEnY => torre.add(new Muro(vida= 500, position = game.at(19, posEnY)))})
		
		torre.forEach({murito => game.addVisual(murito)})
		
	}
	
}
//Lo agrego para ir teniendo algo de base grafica
object tableroDePlantas{
	method image() ="tableroDePlantas.png"
	method position()= game.at(5,0)
	method mostrar()=game.addVisual(self)
}



