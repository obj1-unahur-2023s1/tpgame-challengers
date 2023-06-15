import wollok.game.*

class GemaAleatoria {
	
	var property position = game.at(0,0)
	const imagenes = ["GemaRoja.png","GemaAmarilla.png","GemaVerde.png","GemaAzul.png","GemaVioleta.png"]
	const property color = 0.randomUpTo(5).truncate(0)
	
	method puntaje() = 15
	method image()= imagenes.get(self.color())
	
	method subir(){
		position = position.up(1)
	}
	method bajar(){
		position = position.down(1)
	}
	
	method moverDerecha(){
		position = position.right(1)
	}
	method moverIzquierda(){
		position = position.left(1)
	}
	
}



