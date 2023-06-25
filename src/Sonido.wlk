import wollok.game.*

object sonido {
	var musicaDeInicio 
	const gemaBorrada = [game.sound("gemaBorrada1.mp3"),game.sound("gemaBorrada2.mp3"),game.sound("gemaBorrada3.mp3"),game.sound("gemaBorrada4.mp3")]
	
	method gemaIncorrecta() {
	game.sound("gemaIncorrecta.mp3").play()
	}
	
	override method initialize(){
		musicaDeInicio = game.sound("musicaGame.mp3")
		musicaDeInicio.shouldLoop(true)
		musicaDeInicio.play()
	}
	
	method musicaDeInicio() {
		return musicaDeInicio
	}
	
	method sonidoDeGemaBorradaAleatorio() {
		return gemaBorrada.anyOne()
	}
	
	method borrarGema() {
		return self.sonidoDeGemaBorradaAleatorio().play()
	}
	
	method iniciarPartida() {
		game.sound("start.mp3").play()
	}
}
