import wollok.game.*

object sonido {
    const property musicaDeInicio = game.sound("musicaGame.mp3")
    const sonidoInicio = game.sound("start.mp3")
    method gemaIncorrecta() {
    game.sound("gemaIncorrecta.mp3").play()
    }

    override method initialize(){
        musicaDeInicio.shouldLoop(true)
        musicaDeInicio.volume(0.1)
        musicaDeInicio.play()
    }

    method iniciarPartida() {
        sonidoInicio.volume(0.03)
        sonidoInicio.play()
    }
	

    method borrarGemaIzquierda() {
        game.sound("gemaBorrada1.mp3").play()
    }

    method borrarGemaDerecha() {
        game.sound("gemaBorrada2.mp3").play()
    }

    method borrarGemaArriba() {
        game.sound("gemaBorrada3.mp3").play()
    }

    method borrarGemaAbajo() {
        game.sound("gemaBorrada4.mp3").play()
    }

	method reiniciar(){
		game.sound("reiniciar.mp3").play()
	}

	method victoria(){
		game.sound("victoria.mp3").play()
		
	}
	// agregue (franco) esto para resolver el sonido cuando ganas o perdes.
	method reproducirSiSePuede(){
		if( self.estaEnPausa())
			musicaDeInicio.resume()
	}
	method pausarSiSePuede(){
		if(! self.estaEnPausa())
			musicaDeInicio.pause()
		
	}
	method estaEnPausa() = musicaDeInicio.paused()
}