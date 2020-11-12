import mensajeriaWollokiana.*
import chats.*

class Usuario {
	var espacioLibre
	const chats = new List()
	
	method agregarA(chat) {
		chats.add(chat)
	}
	
	method quitarDe(chat) {
		chats.remove(chat)
	}
	
	method quitarEspacioLibre(peso) {
		if(espacioLibre < peso) {
			self.error("No cuenta con espacio libre suficiente")
		}
		espacioLibre -= peso
	}
	
	method crearChat(integrantes) {
		const nuevoChat = new Chat()
		self.agregarA(nuevoChat)
		integrantes.forEach({ integrante => integrante.agregarAChat(nuevoChat) })
	}
	
	method crearChatPremium(integrantes, tipo) {
		const nuevoChat = new ChatPremium(creador = self, restriccionAdicional = tipo)
		self.agregarA(nuevoChat)
		integrantes.forEach({ integrante => integrante.agregarAChat(nuevoChat) })
	}
} 