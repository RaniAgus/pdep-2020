import wollok.game.*

object menuInicio {
	
	const property image ="menuInicio.png"
	const property position = game.origin()
	
	method generarInicio(){
		game.addVisual(self)
		game.onTick(200,"INICIO",{if(!game.hasVisual(tituloInicio)) {tituloInicio.efectoTitulo()}})
	}
	method cerrarInicio(){
		game.removeVisual(self)
		game.removeTickEvent("INICIO")
	}
	
}

object tituloInicio{
	const property image="textoInicio.png"
	const property position =game.at(6,6)
	
	method efectoTitulo(){
		game.addVisual(self)
		game.schedule(200,{game.removeVisual(self)}) 
		
	}
}