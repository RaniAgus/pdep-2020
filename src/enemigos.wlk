import wollok.game.*
import config.*
import objetosBasicos.*

class Enemigo inherits Zombie {
	const property rangoAtaque = 1
	const velocidadMovimiento
	
	method moverSiNoEstaAtacando() {
		if(not estaAtacando)
			position = game.at( self.position().x(), 10.max(self.position().y() + velocidadMovimiento) )
	}
	
	
}

object zombie{
	var property position=game.at(0,0.randomUpTo(game.height()))
	method image(){
	 	return "jugador.png"
	 }
	 method caminar(){
	 	position =self.position().right(1)
	 }
}
	 
	 


		