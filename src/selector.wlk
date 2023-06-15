import wollok.game.*
import gemas.*
import marco.*

object selector {
	var property image = "selector.png"
	var property position = game.center()
	
	method esUnaGema() = false
	
	method subirGema(){ 
		game.getObjectsIn(self.position()).filter({g=> g.esUnaGema() and g != self}).first().subir()
		position = position.up(1)
		}
				
	method bajarGema(){
		game.getObjectsIn(self.position()).filter({g=>g.esUnaGema() and g != self}).first().bajar()
		position = position.down(1)
		}	
		
	method moverDerechaGema(){
		game.getObjectsIn(self.position()).filter({g=>g.esUnaGema() and g != self}).first().moverDerecha()
		position = position.right(1)
		}		
		
	method moverIzquierdaGema(){
		game.getObjectsIn(self.position()).filter({g=>g.esUnaGema() and g != self}).first().moverIzquierda()
		position = position.left(1)
		}
	}


