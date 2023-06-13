import wollok.game.*

	class Gema {
		var property position 
		
		method image()
		method puntaje()= 15
		method color()
	}
	
class Rojo inherits Gema{
	override method color() = "rojo"
	override method image()= "GemaRoja.png"
	
}

class Naranja inherits Gema{
	override method color() = "naranja"
	override method image()= ""	
}

class Amarillo inherits Gema{
	override method color() = "amarillo"
	override method image()="GemaAmarilla.png"
}

class Verde inherits Gema{
	override method color() = "verde"
	override method image()= "GemaVerde.png"
}

class Azul inherits Gema{
	override method color() = "azul"
	override method image()="GemaAzul.png"
}

class Violeta inherits Gema{
	override method color() = "violeta"
	override method image()="GemaVioleta.png"
}
