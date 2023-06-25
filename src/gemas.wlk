import wollok.game.*
import selector.*
import Sonido.*

class GemaAleatoria {
	
	var property position = game.at(0,0)
	const imagenes = [rojo.imagen(),amarillo.imagen(),verde.imagen(),azul.imagen(),violeta.imagen(),blanca.imagen(),rosa.imagen()]
	const property color = 0.randomUpTo(7).truncate(0)
	const property puntajes= [rojo.puntaje(), amarillo.puntaje(),verde.puntaje(),azul.puntaje(),violeta.puntaje(),blanca.puntaje(),rosa.puntaje()]
	
	method puntaje() = puntajes.get(color)
	method image()= imagenes.get(color)
	method esUnaGema() = true
	
	

	// intercambioDeGemas
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
	//
	
	// movimientosDeGemas	
	method subirGema(){position = position.up(1)}
	method bajarGema(){position = position.down(1)}
	method derGema(){position = position.right(1)}
	method izqGema(){position = position.left(1)}
	//
	
	// borrarGemas
	method borrarse(){
		game.removeVisual(self)
	}
	
	method borrarMatchHorizontal(){
		const posicionDosALaDerecha = self.gemaALaDerecha(2).position()
		self.gemaALaDerecha(2).borrarse()
		game.addVisual(new GemaAleatoria(position= posicionDosALaDerecha ))
		const posicionUnaALaDerecha = self.gemaALaDerecha(1).position()
		self.gemaALaDerecha(1).borrarse()
		game.addVisual(new GemaAleatoria(position= posicionUnaALaDerecha  ))
		const posicionGema = self.position()
		self.borrarse()
		game.addVisual(new GemaAleatoria(position= posicionGema  ))	
		
	}
	
	method borrarMatchVertical(){
		const posicionDosAbajo = self.gemaAbajo(2).position()
		self.gemaAbajo(2).borrarse()
		game.addVisual(new GemaAleatoria(position= posicionDosAbajo  ))
		const posicionUnoAbajo = self.gemaAbajo(1).position()
		self.gemaAbajo(1).borrarse()
		game.addVisual(new GemaAleatoria(position= posicionUnoAbajo ))
		const posicionGema = self.position()
		self.borrarse()
		game.addVisual(new GemaAleatoria(position= posicionGema ))	
		
	}
	//
	
	// verificarMatches 
	method tieneMatch(){
		return self.tieneMatchVertical() or self.tieneMatchHorizontal()
	}
	
	method tieneMatchHorizontal(){
		return self.tieneGemasALaDerecha(2) and (self.color() == self.gemaALaDerecha(1).color() and self.color() == self.gemaALaDerecha(2).color())
	} 
		
	method tieneMatchVertical(){
		return self.tieneGemasAbajo(2) and (self.color() == self.gemaAbajo(1).color() and self.color() == self.gemaAbajo(2).color())
	}
	//
	
	// verificarGemasAdyacentesssss
	method tieneGemasALaDerecha(cantidad){
		return game.getObjectsIn(self.position().right(cantidad)).size() >= 1
	}
	
	method tieneGemasAbajo(cantidad){
		return game.getObjectsIn(self.position().down(cantidad)).size() >= 1
	}
	//
	
	// returnDeGemasEnPosicion
	method gemaALaDerecha(veces)= game.getObjectsIn(self.position().right(veces)).filter({g=>g.esUnaGema()}).first()	
	method gemaAbajo(veces)= game.getObjectsIn(self.position().down(veces)).filter({g=>g.esUnaGema()}).first()
	//
}

class Color {
	
	method imagen()
	method puntaje()
}
object rojo inherits Color {
	
	override method imagen()= "GemaRoja.png"
	
	override method puntaje()= 45
}

object amarillo inherits Color {
	
	override method imagen()= "GemaAmarilla.png"
	
	override method puntaje()= 75
}

object verde inherits Color {
	
	override method imagen()= "GemaVerde.png"
	
	override method puntaje()= 30
}

object azul inherits Color {
	
	override method imagen()= "GemaAzul.png"
	
	override method puntaje()= 120
}

object violeta inherits Color {
	
	override method imagen()= "GemaVioleta.png"
	
	override method puntaje()= 90
}

object blanca inherits Color {
	
	override method imagen()= "GemaBlanca.png"
	
	override method puntaje()= 105
}

object rosa inherits Color {
	
	override method imagen()= "GemaRosa.png"
	
	override method puntaje()= 60
}




