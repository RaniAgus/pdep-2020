import wollok.game.*
import plantas.*
import tablero.*

object creadorDeMargaritas {
	
	method crearPlanta() = new Margarita(
		danio = 25, 
		velocidadAtaque = 3000, 
		vida = 0, 
		position = 
		cursor.position(),
		image = "margarita.png"
	)
	
	method seleccionarImagen() = "margarita-gris.png"
	
	method elixirNecesario() = 3
	
}

object creadorDeLanzaguizantes {
	method crearPlanta() = new Lanzaguisantes(
		danio = 25, 
		velocidadAtaque = 3000, 
		vida = 0, 
		position = 
		cursor.position(),
		image = "lanzaguisante.png"
	)
	
	method seleccionarImagen() = "lanzaguisante-gris.png"
	
	method elixirNecesario() = 8
}

object creadorDeGirasoles {
		method crearPlanta() = new Girasol(
		danio = 25, 
		velocidadAtaque = 3000, 
		vida = 100, 
		position = cursor.position(),
		image = "plantita.png"
	)
	
	method seleccionarImagen() = "plantita-gris.png"
	
	method elixirNecesario() = 6
}