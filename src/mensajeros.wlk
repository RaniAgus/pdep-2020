// Mensajeros de pelicula, primera parte

object paquete
{
	var destino = matrix
	var property estaPago = false
	const property precio = 50
	
	method destino(unDestino) { destino = unDestino }
	method destinos() = #{ destino }
}

object paquetito
{
	var property destino = matrix
	const property estaPago = true
	
	const property precio = 0
	
	method destino(unDestino) { destino = unDestino }
	method destinos() = #{ destino }
}

object paquetonViajero
{
	var cantidadPaga = 0
	const property destinos = #{}
	
	method pagar(cantidad)
	{ 
		cantidadPaga = (cantidadPaga + cantidad).min(self.precio())
	}
	
	method estaPago() = cantidadPaga == self.precio()
	
	method agregarDestino(unDestino) { destinos.add(unDestino) }
	method quitarDestino(unDestino) { destinos.remove(unDestino) }
	
	method precio() = destinos.size() * 100
}

object paqueteLoco
{
	var destino = matrix
	var estaPago = true
	
	method pagar() { estaPago = false }
	
	method estaPago() = estaPago
	
	method destino(unDestino) { destino = unDestino }
	method destinos() = #{ destino }
	
	method precio() = 1000
}

//*************************DESTINOS*************************

object puenteDeBrooklyn
{
	method puedePasar(mensajero) = mensajero.peso() < 1000
}

object matrix
{
	method puedePasar(mensajero) = mensajero.puedeLlamar()
}

//*************************MENSAJEROS*************************

object roberto
{
	var property medioTransporte = bicicleta
	
	var peso = 50
	method peso(_peso) { peso = _peso }
	method peso() = peso + medioTransporte.peso()
	
	method puedeLlamar() = false
	
	method puedeEntregar(unPaquete) = unPaquete.destinos().all({ destino => destino.puedePasar(self)}) and unPaquete.estaPago()
}

object chuckNorris
{
	const property peso = 900
	
	method puedeLlamar() = true
	
	method puedeEntregar(unPaquete) = unPaquete.destinos().all({ destino => destino.puedePasar(self)}) and unPaquete.estaPago()
}

object neo
{
	const property peso = 0
	var tieneSaldo = true
	
	method tieneSaldo(_saldo) { tieneSaldo = _saldo }
	
	method puedeLlamar() = tieneSaldo
	
	method puedeEntregar(unPaquete) = unPaquete.destinos().all({ destino => destino.puedePasar(self)}) and unPaquete.estaPago()
}

object rani
{
	var peso = 65
	var puedeConseguirTelefono = true
	
	method encuarentenar() 
	{ 
		peso += 5
		puedeConseguirTelefono = false
	}
	
	method peso() = auto.peso() + peso
	
	method puedeLlamar() = puedeConseguirTelefono
	
	method puedeEntregar(unPaquete) = unPaquete.destinos().all({ destino => destino.puedePasar(self)}) and unPaquete.estaPago()
}

//*************************TRANSPORTES*************************

object bicicleta
{
	method peso() = 1
}

object auto
{
	method peso() = 1000 - 70
}

object camion
{
	var acoplados = 1
	method acoplados(_acoplados) { acoplados = _acoplados }
	
	method peso() = acoplados * 500
}