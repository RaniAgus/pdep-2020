import wollok.game.*
import config.*

// sinceramente creo que lo que es imagen deberia pasarse por parametro en el momento de declarar
// principalmente por las plantas si quieren que hayan muchos tipos
class Elemento {
	var property vida 
	var property image = ""
	var property position 
	
	method vida() = vida
	
	method recibirAtaque(atacante) {
		vida = 0.max(vida - atacante.danio())
		if(vida == 0) {
			atacante.detenerAtaque(self)
			self.morir()
		}
	}
	
	method morir(){
		game.removeVisual(self)
	}
}

class Muro inherits Elemento{
	
	
	override method image() = "muro.png"
	
	
	override method morir() {
		config.finalizar(self)
	}
	
}


class Planta inherits Elemento {
//	const property id 
	const property elixirNecesario // cada personaje (trampa) va a tener un elixir necesario para que éste funcione
	
	
	var danio
	var velocidadAtaque
	var estaAtacando = false

	override method image() = "plantita2.png"
	method danio() = danio
	
	override method position()=game.center()
	
	method atacar(atacado) {
		estaAtacando = true
		game.onTick(velocidadAtaque, "ATACAR", {atacado.recibirAtaque(self)})
	}
	
	method detenerAtaque(atacado) {
		game.removeTickEvent("ATACAR")
		estaAtacando = false
	}
	
	override method position(nuevaPosicion){
	 position =nuevaPosicion
	 }
	
	
}

class Zombie{

	var danio=0
	var velocidadAtaque=0
	var estaAtacando = false
	var property position=game.at(0,1.randomUpTo(game.height()))
	var property image="jugador.png"


	
	method danio() = danio
	 method caminar(){
	 	position =self.position().right(1)
	 }
	
	method atacar(atacado) {
		estaAtacando = true
		game.onTick(velocidadAtaque, "ATACAR", {atacado.recibirAtaque(self)})
	}
}	
	



