import wollok.game.*
object selector {
	var property image = "selector.png"
	var property position = game.center()
	
	method subirGema(){
		game.colliders(self).forEach ( { gema => gema.subir() } )
		
	}
}

object marco{
	method image()= "board.png"
	method position()= game.at(3,1)
	method subir(){}
}
