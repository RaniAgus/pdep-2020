import wollok.game.*
import config.*
import objetosPrincipales.*
import tablero.*
import disparos.*

class Planta inherits ElementoVivo {
	var velocidadAtaque
	var danio
	
	method danio() = danio
	
	method envejecer() {
		vida -= 20
		if(vida <= 0) {
			self.morir()
		}
	}
	
	method iniciar(){}
	method detenerAtaque(){}
	
	override method morir(){
		tablero.eliminarPlanta(self)
	}
}

class Margarita inherits Planta {
	override method morir() {
		game.colliders(self).forEach({ zombi => if(tablero.esZombie(zombi)) zombi.recibirAtaque(self) })
		super()
	}
}

class Lanzaguisantes inherits Planta {
	var idBala = 0
	
	override method iniciar(){
		game.onTick(
			  velocidadAtaque
			, "DispararBalas" + position.x().toString() + "-" + position.y().toString()
			, {	const bala = new Bala(
					  image = "bala0.png"
					, position = position.left(1)
					, danio = danio
					, velocidad = 200
					, id = position.x().toString() + "-" + position.y().toString() + "-" + idBala.toString()
					, rango = 6
				)
				idBala++
				bala.disparar()
				self.envejecer() }
		)
	}
	
	override method detenerAtaque() {
		game.removeTickEvent("DispararBalas" + position.x().toString() + "-" + position.y().toString() )
	}
}

class Girasol inherits Planta {
	override method iniciar(){
		game.onTick(
			  velocidadAtaque
			, "RecolectarElixir" + position.x().toString() + "-" + position.y().toString()
			, { cursor.incrementarElixirDisponible()
				vida -= 10
				if(vida == 0) self.morir() }
		)
	}
	
	override method detenerAtaque() {
		game.removeTickEvent("RecolectarElixir" + position.x().toString() + "-" + position.y().toString() )
	}
}

class Hielaguisante inherits Planta {
	var idHielo = 0
	
	override method iniciar(){
		game.onTick(
			velocidadAtaque
			, "DispararHielos" + position.x().toString() + "-" + position.y().toString()
			, {	const hielo = new Hielo(
					  image = "hielo.png"
					, position = position.left(1)
					, danio = danio
					, velocidad = 200
					, id = position.x().toString() + "-" + position.y().toString() + "-" + idHielo.toString()
					, rango = 8
				)
				idHielo++
				hielo.disparar()
				self.envejecer() }
			)
	}
	
	override method detenerAtaque() {
		game.removeTickEvent("DispararHielos" + position.x().toString() + "-" + position.y().toString() )
	}
}

