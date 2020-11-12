import mensajeriaWollokiana.*
import usuario.*

class Chat {
	const mensajes = new List()
	
 	method cantidadMensajes() = mensajes.size()
 	method espacioQueOcupa() = mensajes.sum({ mensaje => mensaje.peso() })
 	
	method enviarMensaje(mensaje) {
		if(not mensaje.emisor().participaDe(self)) {
			self.error("El emisor del mensaje no es participante de este chat")
		}
		mensaje.emisor().quitarEspacioLibre()
		mensajes.add(mensaje)
	}
	
}

class ChatPremium inherits Chat {
	const creador
	var property restriccionAdicional
	
	method esCreador(usuario) = usuario == creador
	method agregarParticipante(usuario) = usuario.agregarA(self)
	method quitarParticipante(usuario) = usuario.quitarDe(self)
	
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
