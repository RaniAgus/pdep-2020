import config.*
import zombies.*
import tablero.*
import wollok.game.*

object niveles {
	var nivel = 0
	const frecuenciaZombies = 3000
	method nivel() = nivel
	
	method iniciarNuevaOleada() {
		nivel++
		
		var velocidadMovimiento = 6000
		var vidaZombie = 100
		const cantidadZombies = (4 * nivel + nivel / 2).truncate(0)
		
		nivel.times({ i => 
			velocidadMovimiento = (velocidadMovimiento - velocidadMovimiento / (i+2)).truncate(0)
			vidaZombie = (vidaZombie + vidaZombie / 2).truncate(0)
		})
		
		game.onTick(
			  frecuenciaZombies
			, "Oleada"
			, {	const zombie = new Zombie (
			  		  position = game.at(0, 2.randomUpTo( game.height() ))
					, image = "zombie.png"
					, vida = vidaZombie
				)
				tablero.agregarZombie(zombie, velocidadMovimiento) }
		)
		game.schedule(cantidadZombies * frecuenciaZombies, { => game.removeTickEvent("Oleada") })
	}	
}

object puntaje {
	var property puntaje = 0
	const cifras = []
	
	method iniciarPuntaje() {
		self.crearCifra(0)
	}
	
	method sumar(puntos) {
		puntaje += puntos * niveles.nivel()
		
		var aux = puntaje
		cifras.forEach({ cifra => 
			cifra.actualizarImagen(aux % 10)
			aux = aux.div(10)
		})
		
		if(aux > 0) self.crearCifra(aux)
	}
	
	method crearCifra(valorInicial) {
		const cifra = new Numero(
				  position = game.at(21 - cifras.size(), 1)
				, image = valorInicial.toString() + ".png"		 
		)
		cifras.add(cifra)
		game.addVisual(cifra)
	}
}

class Numero {
	var position
	var image
	
	method image() = image
	method position() = position
	
	method actualizarImagen(valor) {
		image = valor.toString() + ".png"
	}
	
}