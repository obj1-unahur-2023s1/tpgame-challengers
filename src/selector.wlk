import wollok.game.*
import gemas.*
import marco.*

object selector {
	var property image = "selector.png"
	var property position = game.center()
	
	method esUnaGema() = false
	
	method subirGema(){ 
		self.gemaActual().subir()
		position = position.up(1)
		}
				
	method bajarGema(){
		self.gemaActual().bajar()
		position = position.down(1)
		}	
		
	method moverDerechaGema(){
		self.gemaActual().moverDerecha()
		position = position.right(1)
		}		
		
	method moverIzquierdaGema(){
		self.gemaActual().moverIzquierda()
		position = position.left(1)
		}
		
	method gemaActual(){
		return game.getObjectsIn(self.position()).filter({g=>g.esUnaGema() and g != self}).first()
	}	
	
	
}


