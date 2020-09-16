// Mensajeros de pelicula, primera parte

object paquete
{
	var property destino = matrix
	var property mensajero = neo
	
	var estaPago = false
	method pagar() { estaPago = true }
	method cancelarPago() { estaPago = false }
	
	method peso() = mensajero.peso()
	method puedeSerEntregado() = destino.puedePasar(self) and estaPago
}

//*************************DESTINOS*************************

object puenteDeBrooklyn
{
	method puedePasar(unPaquete) = unPaquete.peso() < 1000
}

object matrix
{
	method puedePasar(unPaquete) = unPaquete.mensajero().puedeLlamar()
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

//*************************TRANSPORTES*************************

object bicicleta
{
	method peso() = 1
}

object camion
{
	var acoplados = 2
	method acoplados(_acoplados) { acoplados = _acoplados }
	
	method peso() = acoplados * 500
}