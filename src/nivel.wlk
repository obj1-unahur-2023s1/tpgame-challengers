import wollok.game.*
import selector.*
import gemas.*

object nivel {
	
	method inicio(){
		
	
	game.title("BejeWollok")
	game.boardGround("fondo1.jpg")
	game.cellSize(110)
	game.width(14)
	game.height(10)
	keyboard.s().onPressDo{self.configurate()}
	
	}
	
	method configurate(){
	//game.width(8)
	//game.height(8)
	//game.addVisual(marco)
	//game.boardGround("testFondo.jpg")
	
	(3..10).forEach{x =>						// agregar gemas Iniciales
		const gema = new GemaAleatoria()
		game.addVisualIn(gema, game.at(x,1)) }
	(3..10).forEach{x =>
		const gema = new GemaAleatoria()
		game.addVisualIn(gema, game.at(x,2)) }
	(3..10).forEach{x =>
		const gema = new GemaAleatoria()
		game.addVisualIn(gema, game.at(x,3)) }
	(3..10).forEach{x =>
		const gema = new GemaAleatoria()
		game.addVisualIn(gema, game.at(x,4)) }
	(3..10).forEach{x =>
		const gema = new GemaAleatoria()
		game.addVisualIn(gema, game.at(x,5)) }
	(3..10).forEach{x =>
		const gema = new GemaAleatoria()
		game.addVisualIn(gema, game.at(x,6)) }
	(3..10).forEach{x =>
		const gema = new GemaAleatoria()
		game.addVisualIn(gema, game.at(x,7)) }		
	(3..10).forEach{x =>
		const gema = new GemaAleatoria()
		game.addVisualIn(gema, game.at(x,8)) }			
	
	game.addVisualCharacter(selector)
	
	}
	
	
	
	
	

}