import mensajeros.*

object mensajeria
{
	const property mensajeros = #{}
	const paquetesPendientes = []
	var facturacion = 0
	
	method paquetesPendientes() = paquetesPendientes
	
	//Descripciones de la mensajería
	method esGrande() = mensajeros.size() > 2
	method tieneSobrepeso() = ( mensajeros.sum({ mensajero => mensajero.peso() }) / mensajeros.size() ) > 500
	method facturacion() = facturacion
	
	//Contratar y despedir
	method contratar(mensajero) { mensajeros.add(mensajero) }
	method despedir(mensajero) { mensajeros.remove(mensajero) }
	method despedirATodos() { mensajeros.forEach({ mensajero => mensajeros.remove(mensajero) }) }
	
	//Primer mensajero
	method primerMensajero() = mensajeros.asList().first()
	method primerMensajeroPuedeEntregar(unPaquete) = self.primerMensajero().puedeEntregar(unPaquete)
	
	//Último mensajero
	method ultimoMensajero() = mensajeros.asList().last()	
	method pesoUltimoMensajero() = self.ultimoMensajero().peso()
	
	//Puede entregar
	method puedeEntregar(unPaquete) = mensajeros.any({ mensajero => mensajero.puedeEntregar(unPaquete) })	
	method losQuePuedenEntregar(unPaquete) = mensajeros.filter({ mensajero => mensajero.puedeEntregar(unPaquete) })
	
	//Enviar paquetes
	method enviar(unPaquete)
	{
		if(self.puedeEntregar(unPaquete))
		{
			facturacion += unPaquete.precio()
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