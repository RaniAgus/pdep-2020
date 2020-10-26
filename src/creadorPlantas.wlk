import wollok.game.*
import Elemento.*
import Plantas.*
import cursor.*
import Zombie.*

object creadorDePlantas {
	
	method agregarPlanta(opcion){
		var plantita
		if(opcion==1){//pasar algo que no sea numero
		plantita= new Margarita(elixirNecesario = 0, danio = 25, velocidadAtaque = 3000, vida = 0, position = game.at(5,2),seEstaMoviendo=true)	
		}
		if(opcion==2){
		plantita= new Lanzaguisantes(elixirNecesario = 0, danio = 25, velocidadAtaque = 3000, vida = 0, position = game.at(5,2),seEstaMoviendo=true)			
		}
		return plantita
	}
	
}
