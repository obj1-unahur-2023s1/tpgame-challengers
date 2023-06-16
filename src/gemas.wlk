import wollok.game.*
import selector.*

class GemaAleatoria {
	
	var property position = game.at(0,0)
	const imagenes = ["GemaRoja.png","GemaAmarilla.png","GemaVerde.png","GemaAzul.png","GemaVioleta.png","GemaBlanca.png","GemaRosa.png"]
	const property color = 0.randomUpTo(7).truncate(0)
	
	method puntaje() = 15
	method image()= imagenes.get(self.color())
	
	method subir(){		
		self.subirGema()
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self }).first().bajarGema()
	}
	method bajar(){
		self.bajarGema()
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self }).first().subirGema()
	}
	
	method moverDerecha(){
		self.derGema()
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self }).first().izqGema()
	}
	method moverIzquierda(){
		self.izqGema()
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self }).first().derGema()
	}	
	method esUnaGema() = true
	
	method subirGema(){position = position.up(1)}
	method bajarGema(){position = position.down(1)}
	method derGema(){position = position.right(1)}
	method izqGema(){position = position.left(1)}
	
	method borrarse(){
		game.removeVisual(self)
	}
	method tieneMatch(){
		return self.tieneMatchVertical() or self.tieneMatchHorizontal()
	}
	
	method tieneMatchHorizontal(){
		return self.tieneDosGemasALaDerecha() and (self.color() == self.gemaALaDerecha().color() and self.color() == self.gemaDosALaDerecha().color())
	} 
		
	method tieneMatchVertical(){
		return self.tieneDosGemasAbajo() and (self.color() == self.gemaAbajo().color() and self.color() == self.gemaDosAbajo().color())
	}
	method gemaALaDerecha()= game.getObjectsIn(self.position().right(1)).filter({g=>g.esUnaGema()}).first()

	method gemaDosALaDerecha()= game.getObjectsIn(self.position().right(2)).filter({g=>g.esUnaGema()}).first()
	
	method gemaAbajo()= game.getObjectsIn(self.position().down(1)).filter({g=>g.esUnaGema()}).first()
	
	method gemaDosAbajo()= game.getObjectsIn(self.position().down(2)).filter({g=>g.esUnaGema()}).first()
	
	method borrarMatchHorizontal(){
		const posicionDosALaDerecha = self.gemaDosALaDerecha().position()
		self.gemaDosALaDerecha().borrarse()
		game.addVisual(new GemaAleatoria(position= posicionDosALaDerecha ))
		const posicionUnaALaDerecha = self.gemaALaDerecha().position()
		self.gemaALaDerecha().borrarse()
		game.addVisual(new GemaAleatoria(position= posicionUnaALaDerecha  ))
		const posicionGema = self.position()
		self.borrarse()
		game.addVisual(new GemaAleatoria(position= posicionGema  ))
		
	}
	
	method borrarMatchVertical(){
		const posicionDosAbajo = self.gemaDosAbajo().position()
		self.gemaDosAbajo().borrarse()
		game.addVisual(new GemaAleatoria(position= posicionDosAbajo  ))
		const posicionUnoAbajo = self.gemaAbajo().position()
		self.gemaAbajo().borrarse()
		game.addVisual(new GemaAleatoria(position= posicionUnoAbajo ))
		const posicionGema = self.position()
		self.borrarse()
		game.addVisual(new GemaAleatoria(position= posicionGema ))
		
	}
	
	method tieneDosGemasALaDerecha(){
		return game.getObjectsIn(self.position().right(2)).size() >= 1
	}
	
	method tieneDosGemasAbajo(){
		return game.getObjectsIn(self.position().down(2)).size() >= 1
	}
}




