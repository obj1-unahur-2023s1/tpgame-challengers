import wollok.game.*
import selector.*
import gemas.*
import marco.*

object nivel {
	
	method inicio(){
		
	
	game.title("BejeWollok")
	game.boardGround("fondo1.jpg")
	game.cellSize(110)
	game.width(14)
	game.height(10)
	keyboard.space().onPressDo{self.configurate()}
	keyboard.w().onPressDo{ selector.subirGema()}
	keyboard.s().onPressDo{ selector.bajarGema()}
	keyboard.d().onPressDo{ selector.moverDerechaGema()}
	keyboard.a().onPressDo{ selector.moverIzquierdaGema()}
	}
	
	method configurate(){ // estuvimos 3 horas corrigiendo el código porque no anda con addVisualIn
		//game.addVisual(marco)
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,1))) }
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,2))) }
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,3))) }
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,4))) }
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,5))) }
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,6))) }
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,7))) }
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,8))) }		
	
	game.addVisualCharacter(selector)
	
	
	}

	
}
	

	
	
	
