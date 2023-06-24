import wollok.game.*
import selector.*
import gemas.*
import marco.*

object nivel {
	var puntaje = 0
	method inicio(){
		
	
	game.title("BejeWollok")
	game.boardGround("fondo1.jpg")
	game.cellSize(110)
	game.width(14)
	game.height(10)
	// movimiento
	keyboard.space().onPressDo{self.configurate()}
	keyboard.w().onPressDo{ if(selector.puedeMoverArriba()) selector.subirGema()}
	keyboard.s().onPressDo{ if(selector.puedeMoverAbajo()) selector.bajarGema()}
	keyboard.d().onPressDo{ if(selector.puedeMoverDerecha()) selector.moverDerechaGema()}
	keyboard.a().onPressDo{ if(selector.puedeMoverIzquierda()) selector.moverIzquierdaGema()}
	keyboard.up().onPressDo{ selector.moverArriba()}
	keyboard.down().onPressDo{ selector.moverAbajo()}
	keyboard.left().onPressDo{ selector.moverIzquierda()}
	keyboard.right().onPressDo{ selector.moverDerecha()}
//	keyboard.h().onPressDo{ self.todasLasGemas().forEach({gema =>  gema.borrarMatchVertical()  }) }	
//borrar todas las gemas	keyboard.b().onPressDo{ self.todasLasGemas().forEach({o => game.removeVisual(o)})}
//	keyboard.b().onPressDo{ self.borrarMatches()  } 
//	keyboard.l().onPressDo{ game.say(selector, if(selector.gemaActual().tieneMatch()){"tiene match"}else{"no tiene"})}
//	keyboard.z().onPressDo{ self.todasLasGemas().forEach({gema => game.say(gema, if(gema.tieneMatch()){"tiene match"}else{"no tiene"})}) }
	keyboard.p().onPressDo{game.say(selector, "Tienes " + puntaje + " puntos.") }	
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
	
		game.addVisual(selector)
	
		
		self.borrarMatches()
		puntaje = 0
	}
	
	method todasLasGemas()= game.allVisuals().filter({o => o.esUnaGema()})

	method gemasConMatch()= self.todasLasGemas().filter({g => g.tieneMatch() })
	
	method borrarMatches(){	//falta agregar sumar los puntos de las gemas rotas
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchHorizontal()){
				puntaje += gema.puntaje()
				gema.borrarMatchHorizontal()}
			
		})
		
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchVertical()){
				gema.borrarMatchVertical()}
			})
			
		if(self.hayMatchEnTablero()){ // podríamos usar algo como un while pero lo hicimos recursivo
			self.borrarMatches()
		}
	}
	
	method hayMatchEnTablero()= not self.gemasConMatch().isEmpty()
	
	
	
}


	

	
	
	
