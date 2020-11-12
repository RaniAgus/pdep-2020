import mensajeriaWollokiana.*
import chats.*

class Usuario {
	var espacioLibre
	const nombre
	const notificaciones = new List()
	
	method nombre() = nombre 
	
	method chats() = baseDeDatos.chatsDe(self)
	
	method quitarEspacioLibre(peso) {
		if(espacioLibre < peso) {
			self.error("No cuenta con espacio libre suficiente")
		}
		espacioLibre -= peso
	}
	
	method buscar(texto) = self.chats().filter({ chat => chat.algunMensajeContiene(texto) })
	
	method losMasPesados() = self.chats().map({ chat => chat.elMasPesadoDe(self) })

	method notificar(notificacion) {
		notificaciones.add(notificacion)
	}
	
	method leer(chat) {
		notificaciones.removeAllSuchThat({ notificacion => notificacion.perteneceA(chat) })
	}
	
	method notificacionesSinLeer() = notificaciones
} 

object baseDeDatos {
	const chats = new List()
	
	method chatsDe(usuario) = chats.filter({ chat => chat.participa(usuario) })
	
	method crearChat(participantes) {
		chats.add(new Chat(participantes = participantes))
	}
	
	method crearChatPremium(creador, participantes, restriccionAdicional) {
		chats.add(
			new ChatPremium(
				  creador = creador
				, participantes = participantes
				, restriccionAdicional = restriccionAdicional
			)
		)
	}
}

class Notificacion {
	const chat
	const mensaje
	
	method perteneceA(unChat) = chat == unChat
	method mensaje() = mensaje
}