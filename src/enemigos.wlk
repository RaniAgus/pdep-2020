import wollok.game.*
import config.*
import Elemento.*
import Zombie.*

class Enemigo inherits Zombie {
	const property rangoAtaque = 1
	const velocidadMovimiento
	
	method moverSiNoEstaAtacando() {
		if(not estaAtacando)
			position = game.at( self.position().x(), 10.max(self.position().y() + velocidadMovimiento) )
	}
	
	
}

	 