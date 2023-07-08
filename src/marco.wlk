import wollok.game.*


object marco{
	method image()= "board.png"
	method position()= game.at(3,1)
	method esUnaGema() = false
	}

	object fondo {
		var property image = self.imagenMenuSinHelp()
		
		method imagenMenu()= "menu1.png"
		method imagenNivel1()= "nivel1.jpg"
		method imagenMenuSinHelp()= "menuSinH.jpg"
		method esUnaGema() = false
		method imagenVictoria()= "victoria.jpg"
	}
	
	