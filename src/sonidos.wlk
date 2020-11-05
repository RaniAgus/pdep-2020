import wollok.game.*
import config.*

object sonido {
	
	var musicaFondo=new Sound(file="musicaFondo.ogg")
	
	method arrancarMusicaFondo(){
	musicaFondo.shouldLoop(true)
	musicaFondo.volume(0.3)
	musicaFondo.play()
	}
	method tocar(archivo){
		if (config.juegoIniciado()){
		new Sound(file=archivo).play()}
	}
	
	method pararMusicaFondo(){
		musicaFondo.stop()
	}
}
