/*
 * Nombre: Ranieri, Agustín Ezequiel
 * Legajo: 167755-0
 * 
 * Puntos de Entrada:
 * 
 * Punto 1:  unChat.espacioQueOcupa()
 * Punto 2:  unChat.enviarMensaje(unMensaje)
 * Punto 3:  unUsuario.buscar(texto)
 * Punto 4:  unUsuario.losMasPesados()
 * Punto 5a: unUsuario.notificar(unaNotificacion)
 * Punto 5b: unUsuario.leer(chat)
 * Punto 5c: unUsuario.notificacionesSinLeer()
 */
 
import chats.*
import usuario.*
 
class Mensaje {
	const datosFijosDeTransferencia = 5
	const factorDeLaRed = 1.3
	
	const emisor
	const contenido
	
	method emisor() = emisor
	method loEnvio(usuario) = usuario == emisor
	method peso() = datosFijosDeTransferencia + contenido.peso() * factorDeLaRed
	
	method contiene(texto) = emisor.nombre().contains(texto) || contenido.contiene(texto)
}

class Texto {
	const pesoPorCaracter = 1
	const texto
	
	method peso() = texto.length() * pesoPorCaracter
	method contiene(unTexto) = texto.contains(unTexto)
}

class Audio {
	const pesoPorSegundo = 1.2
	const duracion
	
	method peso() = duracion * pesoPorSegundo
	method contiene(unTexto) = false
}

class Contacto {
	const usuario
	
	method usuario() = usuario
	method peso() = 3
	method contiene(unTexto) = usuario.nombre().contains(unTexto)
}

class Imagen {
	const pesoPorPixel = 2
	const ancho
	const alto
	const compresion
	
	method pesoSinCompresion() = ancho * alto * pesoPorPixel
	method peso() = compresion.calcularPeso(self.pesoSinCompresion())
	method contiene(unTexto) = false
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

