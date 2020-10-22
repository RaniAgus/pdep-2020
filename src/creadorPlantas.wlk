import enemigos.*
import trampas.*
import config.*
import objetosBasicos.*
import wollok.game.*

object creadorDePlantas {
	
	method agregarPlanta(opcion){
		var plantita
		if(opcion==1){
		plantita= new Planta(elixirNecesario = 0, danio = 0, velocidadAtaque = 0, vida = 0, position = game.center(),seEstaMoviendo=true)	
		}
		game.addVisual(plantita)
		return plantita
	}
	
}
