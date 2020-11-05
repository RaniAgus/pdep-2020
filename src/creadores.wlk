import wollok.game.*
import plantas.*
import tablero.*

object creadorDeMargaritas {
	
	method crearPlanta() = new Margarita(
		  danio = 50
		, velocidadAtaque = 3000
		, vida = 0
		, position = cursor.position()
		, image = "margarita.png"
	)
	
	method seleccionarImagen() = "margarita-gris.png"
	
	method elixirNecesario() = 2
	
}

object creadorDeLanzaguizantes {
	method crearPlanta() = new Lanzaguisante(
		  danio = 75
		, velocidadAtaque = 2000
		, vida = 300
		, position = cursor.position()
		, image = "lanzaguisante.png"
	)
	
	method seleccionarImagen() = "lanzaguisante-gris.png"
	
	method elixirNecesario() = 5
}

object creadorDeGirasoles {
	method crearPlanta() = new Girasol(
		  danio = 25
		, velocidadAtaque = 1000
		, vida = 200
		, position = cursor.position()
		, image = "girasol.png"
	)
	
	method seleccionarImagen() = "girasol-gris.png"
	
	method elixirNecesario() = 6
}
object creadorDeHielaguisantes {
	method crearPlanta() = new Hielaguisante(
		  danio = 25
		, velocidadAtaque = 3000
		, vida = 300
		, position = cursor.position()
		, image = "lanzaguizanteHielo.png"
	)
	
	method seleccionarImagen() = "lanzaguizanteHielo-gris.png"
	
	method elixirNecesario() = 4
}