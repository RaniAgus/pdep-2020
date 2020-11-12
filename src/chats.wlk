import mensajeriaWollokiana.*
import usuario.*

class Notificacion {
	const chat
	const mensaje
	
	method perteneceA(unChat) = chat == unChat
	method mensaje() = mensaje
}

class Chat {
	const participantes
	const mensajes = new List()
	
	method participa(usuario) = participantes.contains(usuario)
 	method cantidadMensajes() = mensajes.size()
 	method espacioQueOcupa() = mensajes.sum({ mensaje => mensaje.peso() })
 	
	method enviarMensaje(mensaje) {
		if(not self.participa( mensaje.emisor() )) {
			self.error("El emisor del mensaje no es participante de este chat")
		}
		mensaje.emisor().quitarEspacioLibre(mensaje.peso())
		mensajes.add(mensaje)
		participantes.forEach({ 
			usuario => if(not mensaje.loEnvio(usuario)) 
				usuario.notificar(new Notificacion(chat = self, mensaje = mensaje))
		})
	}
	
	method mensajesDe(usuario) = mensajes.filter({ mensaje => mensaje.loEnvio(usuario) })
	method elMasPesadoDe(usuario) = self.mensajesDe(usuario).sortBy({ m1, m2 => m1.peso() > m2.peso()}).take(1)
	method algunMensajeContiene(texto) = mensajes.any({ mensaje => mensaje.contiene(texto) })
}

class ChatPremium inherits Chat {
	const creador
	var property restriccionAdicional
	
	method esCreador(usuario) = usuario == creador
	method agregarParticipante(usuario) = participantes.add(usuario)
	method quitarParticipante(usuario) = participantes.remove(usuario)
	
	override method participa(usuario) = super(usuario) || self.esCreador(usuario)
	
	override method enviarMensaje(mensaje) {
		restriccionAdicional.verificar(self, mensaje)
		super(mensaje)
		creador.notificar(new Notificacion(chat = self, mensaje = mensaje))
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
