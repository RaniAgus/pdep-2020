/*
 * Nombre: Ranieri, Agustín Ezequiel
 * Legajo: 167755-0
 * 
 * Puntos de Entrada:
 * 
 * Punto 1:
 * Punto 2: 
 * Punto 3: 
 * Punto 4: 
 * Punto 5a: 
 * Punto 5b: 
 * Punto 5c:  
 */
 
class Mensaje {
	const datosFijosDeTransferencia = 5
	const factorDeLaRed = 1.3
	
	const emisor
	const contenido
	
	method quienLoEnvio() = emisor
	
	method peso() = datosFijosDeTransferencia + contenido.peso() * factorDeLaRed
}

class Texto {
	const pesoPorCaracter = 1
	const texto
	
	method peso() = texto.length() * pesoPorCaracter
}