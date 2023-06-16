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
	keyboard.h().onPressDo{ self.todasLasGemas().forEach({gema =>  gema.borrarMatchVertical()  }) }
//borrar todas las gemas	keyboard.b().onPressDo{ self.todasLasGemas().forEach({o => game.removeVisual(o)})}
	keyboard.b().onPressDo{ self.borrarMatches()  } 
	keyboard.l().onPressDo{ game.say(selector, if(selector.gemaActual().tieneMatch()){"tiene match"}else{"no tiene"})}
	keyboard.z().onPressDo{ self.todasLasGemas().forEach({gema => game.say(gema, if(gema.tieneMatch()){"tiene match"}else{"no tiene"})}) }
	
	}
	

	method configurate(){ // estuvimos 3 horas corrigiendo el código porque no anda con addVisualIn
		game.addVisualIn(marco, game.at(3,1))
		
		(3..10).forEach{x =>						
		game.addVisual(new GemaAleatoria(position=game.at(x,1)))
		game.addVisual(new GemaAleatoria(position=game.at(x,2))) 
		game.addVisual(new GemaAleatoria(position=game.at(x,3))) 
		game.addVisual(new GemaAleatoria(position=game.at(x,4))) 
		game.addVisual(new GemaAleatoria(position=game.at(x,5))) 
		game.addVisual(new GemaAleatoria(position=game.at(x,6))) 
		game.addVisual(new GemaAleatoria(position=game.at(x,7))) 
		game.addVisual(new GemaAleatoria(position=game.at(x,8))) 
		}
	
		game.addVisualCharacter(selector)
	
		
		self.borrarMatches()
	}
	
	method todasLasGemas()= game.allVisuals().filter({o => o.esUnaGema()})

	method gemasConMatch()= self.todasLasGemas().filter({g => g.tieneMatch() })
	
	method borrarMatches(){
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchHorizontal()){
				gema.borrarMatchHorizontal()}
			
		})
		
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchVertical()){
				gema.borrarMatchVertical()}
			})
		}
	
	
	
	
	
}
	

	
	
	
