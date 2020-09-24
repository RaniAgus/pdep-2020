import mensajeros.*

object mensajeria
{
	const property mensajeros = []
	const paquetesPendientes = []
	const paquetesEnviados = []
	const ganancias = []
	
	method paquetesPendientes() = paquetesPendientes
	
	//Descripciones de la mensajería
	method esGrande() = mensajeros.size() > 2
	method tieneSobrepeso() = mensajeros.sum({ mensajero => mensajero.peso() }) / mensajeros.size() > 500
	method paquetesEnviados() = paquetesEnviados
	method facturacion() = ganancias.sum()
	
	//Contratar y despedir
	method contratar(mensajero) { mensajeros.add(mensajero) }
	method despedir(mensajero) { mensajeros.remove(mensajero) }
	method despedirATodos() { mensajeros.clear() }
	
	//Primer mensajero
	method primerMensajeroPuedeEntregar(unPaquete) = unPaquete.puedeSerEntregadoPor(mensajeros.first())
	
	//Último mensajero
	method pesoUltimoMensajero() = mensajeros.last().peso()
	
	//Puede entregar
	method puedeEntregar(unPaquete) = mensajeros.any({ mensajero => unPaquete.puedeSerEntregadoPor(mensajero) })	
	method losQuePuedenEntregar(unPaquete) = mensajeros.filter({ mensajero => unPaquete.puedeSerEntregadoPor(mensajero) })
	
	//Enviar paquetes
	method enviar(unPaquete)
	{
		if(self.puedeEntregar(unPaquete))
		{
			paquetesEnviados.add(unPaquete)
			ganancias.add(unPaquete.precio())
		} else
		{
			paquetesPendientes.add(unPaquete)
		}
	}
	
	method enviarTodos(paquetes) { paquetes.forEach({ unPaquete => self.enviar(unPaquete) }) }
	
	method intentarEnviarMasCaro()
	{
		const paqueteAEnviar = paquetesPendientes.max({ unPaquete => unPaquete.precio() })
		paquetesPendientes.remove(paqueteAEnviar)
		self.enviar(paqueteAEnviar)
	}
}