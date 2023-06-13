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
	game.addVisualCharacter(selector)
	game.addVisual(new Verde(position=game.at(4,5)))
	game.addVisual(new Verde(position=game.at(5,5)))
	game.addVisual(new Verde(position=game.at(6,5)))
	game.addVisual(new Azul(position=game.at(4,3)))
	game.addVisual(new Azul(position=game.at(5,7)))
	game.addVisual(new Violeta(position=game.at(5,8)))
	game.addVisual(new Violeta(position=game.at(6,4)))
	game.addVisual(new Rojo(position=game.at(5,4)))
	game.addVisual(new Rojo(position=game.at(5,3)))
	game.addVisual(new Amarillo(position=game.at(7,6)))
	game.addVisual(new Amarillo(position=game.at(6,6)))
	
	}
}