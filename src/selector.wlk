import wollok.game.*
import gemas.*
import marco.*
import nivel.*
import sonido.*

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
			sonido.borrarGemaArriba() 
		}
		else{
			sonido.gemaIncorrecta()	
			self.gemaActual().bajar()
			position = position.down(1)
		}
	}

	method bajarGema(){
		self.gemaActual().bajar()
		position = position.down(1)
		if(nivel.hayMatchEnTablero()){
			nivel.borrarMatches()
			sonido.borrarGemaAbajo()
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
			sonido.borrarGemaDerecha()
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
			sonido.borrarGemaIzquierda()
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

