import enemigos.*
import Plantas.*
import config.*
import Elemento.*
import wollok.game.*

object creadorDePlantas {
	
	method agregarPlanta(opcion){
		var plantita
		if(opcion==1){//pasar algo que no sea numero
		plantita= new Margarita(elixirNecesario = 0, danio = 0, velocidadAtaque = 0, vida = 0, position = game.at(5,1),seEstaMoviendo=true)	
		}
		if(opcion==2){
			plantita= new Lanzaguisantes(elixirNecesario = 0, danio = 0, velocidadAtaque = 0, vida = 0, position = game.at(5,1),seEstaMoviendo=true)	
		}
		return plantita
	}
	
}
