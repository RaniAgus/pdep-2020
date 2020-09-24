// Mensajeros de pelicula, primera parte

object paquete
{
	var estaPago = false
	var destino = matrix
	const property precio = 50
	
	method destino(unDestino) { destino = unDestino }
	method pagar() { estaPago = true }
	method cancelarPago() { estaPago = false }
	method puedeSerEntregadoPor(unMensajero) = destino.puedePasar(unMensajero) and estaPago
}

object paquetito
{
	var destino = matrix
	const property precio = 0
	
	method destino(unDestino) { destino = unDestino }
	method puedeSerEntregadoPor(unMensajero) = destino.puedePasar(unMensajero)
}

object paquetonViajero
{
	var cantidadPaga = 0
	const destinos = #{}
	
	method agregarDestino(unDestino) { destinos.add(unDestino) }
	method quitarDestino(unDestino) { destinos.remove(unDestino) }
	method precio() = destinos.size() * 100
	method pagar(cantidad) { cantidadPaga = (cantidadPaga + cantidad).min(self.precio()) }
	method puedeSerEntregadoPor(unMensajero) = destinos.all({ unDestino => unDestino.puedePasar(unMensajero) }) and cantidadPaga == self.precio()
}

object paqueteLoco
{
	var estaPago = true
	var destino = matrix
	
	method destino(unDestino) { destino = unDestino }
	method precio() = 1000
	method pagar() { estaPago = false }
	method puedeSerEntregadoPor(unMensajero) = destino.puedePasar(unMensajero) and estaPago
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
}

object chuckNorris
{
	const property peso = 900
	
	method puedeLlamar() = true
}

object neo
{
	const property peso = 0
	var tieneSaldo = true
	
	method tieneSaldo(_saldo) { tieneSaldo = _saldo }
	
	method puedeLlamar() = tieneSaldo
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