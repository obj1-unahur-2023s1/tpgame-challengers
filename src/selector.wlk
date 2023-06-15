import wollok.game.*
import gemas.*
object selector {
	var property image = "selector.png"
	var property position = game.center()
	
	method subirGema(){ 
		game.getObjectsIn(self.position()).first().subir()
		position = position.up(1)
		game.getObjectsIn(self.position()).first().bajar()
				}
				
	method bajarGema(){
		game.getObjectsIn(self.position()).first().bajar()
		position = position.down(1)
		game.getObjectsIn(self.position()).first().subir()
		}	
		
	method moverDerechaGema(){
		game.getObjectsIn(self.position()).first().moverDerecha()
		position = position.right(1)
		game.getObjectsIn(self.position()).first().moverIzquierda()
		}		
		
	method moverIzquierdaGema(){
		game.getObjectsIn(self.position()).first().moverIzquierda()
		position = position.left(1)
		game.getObjectsIn(self.position()).first().moverDerecha()
		}
	}

object marco{
	method image()= "board.png"
	method position()= game.at(3,1)
	method subir(){}
}
