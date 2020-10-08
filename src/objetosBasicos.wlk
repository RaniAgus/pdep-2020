import wollok.game.*
import config.*

class Elemento {
	var salud
	
	method salud() = salud
	
	method recibirAtaque(atacante) {
		salud = 0.max(salud - atacante.danio())
		if(salud == 0) {
			atacante.detenerAtaque(self)
			self.morir()
		}
	}
	
	method morir(){
		game.removeVisual(self)
	}
}

object torre inherits Elemento(salud = 10000) {
	override method morir() {
		config.finalizar()
	}
}

class Personaje inherits Elemento {
	const property id 
	const property elixirNecesario // cada personaje (trampa) va a tener un elixir necesario para que éste funcione
	
	var danio
	var velocidadMovimiento
	var velocidadAtaque
	var estaAtacando = false
	
	var property position
	
	override method morir() {
		game.removeVisual(self)
	}
	
	method danio() = danio
	
	method atacar(atacado) {
		estaAtacando = true
		game.onTick(velocidadAtaque, "ATACAR" + id.toString() + "-" + atacado.id().toString(), {
			atacado.recibirAtaque(self)
		})
	}
	
	method detenerAtaque(atacado) {
		game.removeTickEvent("ATACAR" + id.toString() + "-" + atacado.id().toString() )
		estaAtacando = false
	}
}