import wollok.game.*
import gemas.*
import marco.*
import nivel.*
import Sonido.*

object selector {
	var property image = "selector.png"
	var property position = game.center()
	const maximaFila = 8
	const maximaColumna = 10
	const minimaFila = 1
	const minimaColumna = 3
	
	method esUnaGema() = false
	
	method subirGema(){
		 		 
		self.gemaActual().subir()
		position = position.up(1)
		if(nivel.hayMatchEnTablero()){
			nivel.borrarMatches()
			sonido.borrarGema() // como los matches se borran al comenzar el juego, es conveniente que el sonido de borrar se repita y no este en nivel.borrarMatches().
			 // Ese error se soluciono haciendo un borrarMatchesInvisibles() pero trae problema todavia si hay mas de un match, todos los metodos son llamados de distintos lados
			 // hasta ahora no encontre forma de poner el sonido en un metodo unico para el match. para asegurarse que no se va  a llamar dos veces y generar el error ; wollok.lang.Exception: Un sonido solo se puede reproducir una vez.
		}
		else{
			sonido.gemaIncorrecta()	
			// agregar en todos los else un error de movimiento (sonido o mensaje) "cuak"
			self.gemaActual().bajar()
			position = position.down(1)
		}
	}

	method bajarGema(){
		self.gemaActual().bajar()
		position = position.down(1)
		if(nivel.hayMatchEnTablero()){
			nivel.borrarMatches()
			sonido.borrarGema()
		}
		else{
			sonido.gemaIncorrecta()	
			self.gemaActual().subir()
			position = position.up(1)
		}		
	}	
		
	method moverDerechaGema(){
		self.gemaActual().moverDerecha()
		position = position.right(1)
		if(nivel.hayMatchEnTablero()){
			nivel.borrarMatches()
			sonido.borrarGema()
		}
		else{
			sonido.gemaIncorrecta()
			self.gemaActual().moverIzquierda()
			position = position.left(1)
		}			
	}		
		
	method moverIzquierdaGema(){
		self.gemaActual().moverIzquierda()
		position = position.left(1)
		if(nivel.hayMatchEnTablero()){
			nivel.borrarMatches()
			sonido.borrarGema()
		}
		else{
			sonido.gemaIncorrecta()	
			self.gemaActual().moverDerecha()
			position = position.right(1)
		}			
	}
		
	method gemaActual(){
		return game.getObjectsIn(self.position()).filter({g=>g.esUnaGema() and g != self}).first()
	}	
	
	
	//movimiento
	
	method moverArriba(){
		if(self.puedeMoverArriba() )
			position = position.up(1)
	}
	
	method moverAbajo(){
		if(self.puedeMoverAbajo() )
		position = position.down(1)
	
	}

	method moverDerecha(){
		if( self.puedeMoverDerecha() )
		position = position.right(1)
	
	}
	
	method moverIzquierda(){
		if( self.puedeMoverIzquierda() )
		position = position.left(1)
	
	}

	method puedeMoverArriba()= position.y() < maximaFila
	method puedeMoverAbajo()= position.y() > minimaFila
	method puedeMoverDerecha()= position.x() < maximaColumna
	method puedeMoverIzquierda()= position.x() > minimaColumna
	
}

