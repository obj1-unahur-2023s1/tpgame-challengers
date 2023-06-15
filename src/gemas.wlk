import wollok.game.*

class GemaAleatoria {
	
	var property position = game.at(0,0)
	const imagenes = ["GemaRoja.png","GemaAmarilla.png","GemaVerde.png","GemaAzul.png","GemaVioleta.png"]
	const property color = 0.randomUpTo(5).truncate(0)
	
	method puntaje() = 15
	method image()= imagenes.get(self.color())
	
	method subir(){		
		position = position.up(1)
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self }).first().bajarGema()
	}
	method bajar(){
		position = position.down(1)
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self }).first().subirGema()
	}
	
	method moverDerecha(){
		position = position.right(1)
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self }).first().izqGema()
	}
	method moverIzquierda(){
		position = position.left(1)
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self }).first().derGema()
	}	
	method esUnaGema() = true
	
	method subirGema(){position = position.up(1)}
	method bajarGema(){position = position.down(1)}
	method derGema(){position = position.right(1)}
	method izqGema(){position = position.left(1)}
	
	
}



