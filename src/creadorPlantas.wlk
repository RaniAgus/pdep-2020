import enemigos.*
import trampas.*
import config.*
import Elemento.*
import wollok.game.*

object creadorDePlantas {
	
	method agregarPlanta(opcion){
		var plantita
		if(opcion==1){//pasar algo que no sea numero
		plantita= new Planta(elixirNecesario = 0, danio = 0, velocidadAtaque = 0, vida = 0, position = game.at(5,1),seEstaMoviendo=true)	
		}
		return plantita
	}
	
}
