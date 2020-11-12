/*
 * Nombre: Ranieri, Agustín Ezequiel
 * Legajo: 167755-0
 * 
 * Puntos de Entrada:
 * 
 * Punto 1: unChat.espacioQueOcupa()
 * Punto 2: unChat.enviarMensaje(unMensaje)
 * Punto 3: 
 * Punto 4: 
 * Punto 5a: 
 * Punto 5b: 
 * Punto 5c:  
 */
 
class Mensaje {
	const datosFijosDeTransferencia = 5
	const factorDeLaRed = 1.3
	
	const emisor
	const contenido
	
	method emisor() = emisor
	method peso() = datosFijosDeTransferencia + contenido.peso() * factorDeLaRed
}

class Texto {
	const pesoPorCaracter = 1
	const texto
	
	method peso() = texto.length() * pesoPorCaracter
}

class Audio {
	const pesoPorSegundo = 1.2
	const duracion
	
	method peso() = duracion * pesoPorSegundo
}

class Contacto {
	const usuario
	
	method usuario() = usuario
	method peso() = 3
}

class Imagen {
	const pesoPorPixel = 2
	const ancho
	const alto
	const compresion
	
	method pesoSinCompresion() = ancho * alto * pesoPorPixel
	method peso() = compresion.calcularPeso(self.pesoSinCompresion())
}

class GIF inherits Imagen {
	const cuadros
	override method pesoSinCompresion() = super() * cuadros
}

object compresionOriginal {
	method calcularPeso(pesoOriginal) = pesoOriginal
}

class CompresionVariable {
	const porcentajeCompresion
	method calcularPeso(pesoOriginal) = pesoOriginal * porcentajeCompresion
}

object compresionMaxima {
	method calcularPeso(pesoOriginal) = pesoOriginal.min(10000)
}

