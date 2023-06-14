import wollok.game.*

class Gema {
	var property position = game.at(0,0)
	
	method image()
	method puntaje() = 15
	method color()

}

class GemaAleatoria inherits Gema{
	const imagenes = ["GemaRoja.png","GemaAmarilla.png","GemaVerde.png","GemaAzul.png","GemaVioleta.png"]
	const property color = 0.randomUpTo(5).truncate(0)
	override method image()= imagenes.get(self.color())
	
}


object marco{
	method image()= "board2.gif"
	method position()= game.at(3,1)
}

/*
object rojo {
	override method color() = 0
	override method image() = "GemaRoja.png"
}

class Naranja inherits Gema {
	override method color() = "naranja"
	override method image() = ""
}

class Amarillo inherits Gema {
	override method color() = "amarillo"
	override method image() = "GemaAmarilla.png"
}

class Verde inherits Gema {
	override method color() = "verde"
	override method image() = "GemaVerde.png"
}

class Azul inherits Gema {
	override method color() = "azul"
	override method image() = "GemaAzul.png"
}

class Violeta inherits Gema {
	override method color() = "violeta"
	override method image() = "GemaVioleta.png"
}


*/

