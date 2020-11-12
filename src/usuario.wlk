import mensajeriaWollokiana.*
import chats.*

class Usuario {
	var espacioLibre
	const nombre
	const notificacionesSinLeer = new List()
	
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
		notificacionesSinLeer.add(notificacion)
	}
	
	method leer(chat) {
		notificacionesSinLeer.removeAllSuchThat({ notificacion => notificacion.perteneceA(chat) })
	}
	
	method notificacionesSinLeer() = notificacionesSinLeer
} 

object baseDeDatos {
	const chats = new List()
	
	method chatsDe(usuario) = chats.filter({ chat => chat.participa(usuario) })
	
	method crearChat(participantes) {
		const chat = new Chat(participantes = participantes) 
		chats.add(chat)
		return chat
	}
	
	method crearChatPremium(creador, participantes, restriccionAdicional) {
		const chat = new ChatPremium(
				  creador = creador
				, participantes = participantes
				, restriccionAdicional = restriccionAdicional
		)
		chats.add(chat)
		return chat
	}
}