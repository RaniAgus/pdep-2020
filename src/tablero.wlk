object tablero {
	const posicionesOcupadas =#{}
	const property zombiesEnJuego=[]
	
	method estaOcupada(posicion) = posicionesOcupadas.contains(posicion)
	
	method eliminarPosicion(posicion){
		posicionesOcupadas.remove(posicion)
	}
		method agregarPosicion(posicion){
		posicionesOcupadas.add(posicion)
	}
	method zombiesEnJuego(zombie){
		zombiesEnJuego.add(zombie)
	}
}
