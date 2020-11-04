import wollok.game.*
object sonido {
	var danioBala=new Sound(file="danioBala.wav")
	var disparo=new Sound(file="disparo.wab")
	var elixirLleno=new Sound(file="elixirLleno.wav")
	var explosion=new Sound(file="explosion")
	var gameOver=new Sound(file="gameOver.mp3")
	var hielo=new Sound(file="hielo.mp3")
	var musicaFondo=new Sound(file="musicaFondo.ogg")
	var subidaNivel=new Sound(file="subidaNivel.mp3")
	var zombi1=new Sound(file="zombi1.wav")
	var zombi2=new Sound(file="zombi2.wav")
	var zombi3=new Sound(file="zombi3.wav")
	var zombi4=new Sound(file="zombi4.wav")
	
	method arrancarMusicaFondo(){
	musicaFondo.shouldLoop(true)
	musicaFondo.play()
	}
	method tocar(archivo){
		new Sound(file=archivo).play()
	}
	
	method pararMusicaFondo(){
		musicaFondo.stop()
	}
	
	
	
	
	
}
