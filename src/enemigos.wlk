import wollok.game.*
import config.*
import objetosBasicos.*

class Enemigo inherits Personaje {
	const property rangoAtaque = 1
	
	method moverSiNoEstaAtacando() {
		if(not estaAtacando)
			position = game.at( self.position().x(), 10.max(self.position().y() + velocidadMovimiento) )
	}
	
	
}

