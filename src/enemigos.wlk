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
	method position(){
		return game.origin()
	}
	 method image(){
	 	return "jugador.png"
	 }
	 
	 method caminar(){
	 	return game.at(0.max(self.position().x() + 1),self.position().y())
	 }
}