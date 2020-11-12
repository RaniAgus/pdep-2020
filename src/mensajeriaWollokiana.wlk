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

class Usuario {
	var espacioLibre
	
	method quitarEspacioLibre(peso) {
		if(espacioLibre < peso) {
			self.error("No cuenta con espacio libre suficiente")
		}
		espacioLibre -= peso
	}
} 

class Chat {
	const creador
	const participantes
	const mensajes = new List()
	
	method esCreador(usuario) = usuario == creador
	method participa(usuario) = self.esCreador(usuario) || participantes.contains(usuario)
 	method cantidadMensajes() = mensajes.size()
 	method espacioQueOcupa() = mensajes.sum({ mensaje => mensaje.peso() })
 	
	method enviarMensaje(mensaje) {
		if(not self.participa( mensaje.emisor() )) {
			self.error("El emisor del mensaje no es participante de este chat")
		}
		mensaje.emisor().quitarEspacioLibre()
		mensajes.add(mensaje)
	}
	
}

class ChatPremium inherits Chat {
	var property restriccionAdicional
	
	method agregarParticipante(usuario) = participantes.add(usuario)
	method quitarParticipante(usuario) = participantes.remove(usuario)
	
	override method enviarMensaje(mensaje) {
		restriccionAdicional.verificar(self, mensaje)
		super(mensaje)
	}
}

object difusion {
	method verificar(chat, mensaje) {
		if(not chat.esCreador(mensaje.emisor())) {
			self.error("El emisor del mensaje no es creador de este chat de difusión")
		}
	}
}

class Restringido {
	const limite
	method verificar(chat, mensaje) {
		if(chat.cantidadMensajes() == limite) {
			self.error("El chat ha llegado a su límite de mensajes")
		}
	}
}

class Ahorro {
	const pesoMaximo
	method verificar(chat, mensaje) {
		if(mensaje.peso() > pesoMaximo) {
			self.error("El mensaje supera el máximo permitido en este chat")
		}
	}	
}

