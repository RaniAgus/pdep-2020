import wollok.game.*
import config.*

class Elemento {
	var vida
	const property image
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


object torre inherits Elemento(vida = 10000, image = "muro.png", position= game.center()) {
	override method morir() {
		config.finalizar()
	}
}


class Planta inherits Elemento {
//	const property id 
	const property elixirNecesario // cada personaje (trampa) va a tener un elixir necesario para que éste funcione
	
	var danio
	var velocidadAtaque
	var estaAtacando = false

	
	method danio() = danio
	
	method atacar(atacado) {
		estaAtacando = true
		game.onTick(velocidadAtaque, "ATACAR", {atacado.recibirAtaque(self)})
	}
	
	method detenerAtaque(atacado) {
		game.removeTickEvent("ATACAR")
		estaAtacando = false
	}
	
	
}

class Zombie{

	var danio=0
	var velocidadAtaque=0
	var estaAtacando = false
	var property position=game.at(0,0.randomUpTo(game.height()))
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



