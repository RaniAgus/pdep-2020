import wollok.game.*
import Elemento.*
import Plantas.*
import cursor.*
import Zombie.*

object creadorDePlantas {
	
	method agregarPlanta(opcion){
		var plantita
		if(opcion==1){//pasar algo que no sea numero
		
		plantita= new Margarita(elixirNecesario = 0, danio = 50, velocidadAtaque = 1, vida = 0, position = game.at(5,2),seEstaMoviendo=true)	
		//game.onCollideDo(plantita, {x => plantita.atacar(x) })
		}
		if(opcion==2){
			plantita= new Lanzaguisantes(elixirNecesario = 0, danio = 50, velocidadAtaque = 1, vida = 0, position = game.at(5,2),seEstaMoviendo=true)	
			//game.onCollideDo(plantita, {x => plantita.atacar(x)})
		
		}
		return plantita
	}
	
}
