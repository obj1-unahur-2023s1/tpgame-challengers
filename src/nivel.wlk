import wollok.game.*
import selector.*
import gemas.*
import marco.*
import sonido.*

object nivel {
	var puntaje = 0
	var juegoTerminado = false
	method puntaje(){
		return puntaje
	}
	method inicio(){
		
	
	game.title("BejeWollok")
	game.addVisualIn(fondo, game.at(0,0))
	
	game.cellSize(110)
	game.width(14)
	game.height(10)
	// movimiento
	keyboard.space().onPressDo{self.configurate()}
	keyboard.w().onPressDo{ if(selector.puedeMoverArriba()) selector.subirGema()}
	keyboard.r().onPressDo{ self.reiniciar()}
	
	keyboard.s().onPressDo{ if(selector.puedeMoverAbajo()) selector.bajarGema()}
	keyboard.d().onPressDo{ if(selector.puedeMoverDerecha()) selector.moverDerechaGema()}
	keyboard.a().onPressDo{ if(selector.puedeMoverIzquierda()) selector.moverIzquierdaGema()}
	keyboard.up().onPressDo{ selector.moverArriba()}
	keyboard.down().onPressDo{ selector.moverAbajo()}
	keyboard.left().onPressDo{ selector.moverIzquierda()}
	keyboard.right().onPressDo{ selector.moverDerecha()}
// tests
//	keyboard.h().onPressDo{ self.todasLasGemas().forEach({gema =>  gema.borrarMatchVertical()  }) }	
//borrar todas las gemas	keyboard.b().onPressDo{ self.todasLasGemas().forEach({o => game.removeVisual(o)})}
//	keyboard.b().onPressDo{ self.borrarMatches()  } 
//	keyboard.l().onPressDo{ game.say(selector, if(selector.gemaActual().tieneMatch()){"tiene match"}else{"no tiene"})}
//	keyboard.z().onPressDo{ self.todasLasGemas().forEach({gema => game.say(gema, if(gema.tieneMatch()){"tiene match"}else{"no tiene"})}) }
	keyboard.p().onPressDo{game.say(selector, "Tienes " + puntaje + " puntos.") }
	game.onTick(2500, "fijarse si se gana", {
		if(puntaje > 5000){
			self.ganar()
		}
		})
	}
	
	
// estuvimos 3 horas corrigiendo el código porque no anda con addVisualIn
	method borrarGemaEnPosicion(col,fila){
		game.removeVisual(game.getObjectsIn(game.at(col,fila)).filter({g=>g.esUnaGema() and g != selector}).first())
	}
	method AgregarGemaEnPosicion(col,fila){
		game.addVisual(new GemaAleatoria(position=game.at(col,fila)))
	}
	method generarGemasEnTablero(){
		(3..10).forEach{x =>						
		self.AgregarGemaEnPosicion(x,1)
		self.AgregarGemaEnPosicion(x,2) 
		self.AgregarGemaEnPosicion(x,3)
		self.AgregarGemaEnPosicion(x,4)
		self.AgregarGemaEnPosicion(x,5)
		self.AgregarGemaEnPosicion(x,6)
		self.AgregarGemaEnPosicion(x,7) 
		self.AgregarGemaEnPosicion(x,8)
		}
	}
	method borrarTablero(){
		(3..10).forEach{x =>
			self.borrarGemaEnPosicion(x,1)
			self.borrarGemaEnPosicion(x,2)
			self.borrarGemaEnPosicion(x,3)
			self.borrarGemaEnPosicion(x,4)
			self.borrarGemaEnPosicion(x,5)
			self.borrarGemaEnPosicion(x,6)
			self.borrarGemaEnPosicion(x,7)
			self.borrarGemaEnPosicion(x,8)
		}
	}
	method reiniciar(){ 
		if (puntaje >= 500){
		self.borrarTablero()
		self.generarGemasEnTablero()
		self.borrarMatchesInvisible()
		sonido.reiniciar()		
		puntaje -= 500
		game.say(selector, "Tienes " + puntaje + " puntos.") 
		}
		else{
			game.say(selector, "Puntos insuficientes.") 
			sonido.gemaIncorrecta()
		}
	}
	method configurate(){ 
		fondo.image(fondo.imagenNivel1())
		game.addVisualIn(marco, game.at(3,1))
		self.generarGemasEnTablero()
		game.addVisual(selector)
		self.borrarMatchesInvisible()
		puntaje = 0
		if(not juegoTerminado){sonido.iniciarPartida()}// hace que el sonido tenga su initialize, sino iniciaba despues de hacer match o movimiento erroneo
	}
	
	method todasLasGemas()= game.allVisuals().filter({o => o.esUnaGema()})

	method gemasConMatch()= self.todasLasGemas().filter({g => g.tieneMatch() })
	
	method borrarMatchesInvisible(){
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchHorizontal()){
				gema.borrarMatchHorizontal()}
			
		})
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchVertical()){
				gema.borrarMatchVertical()}
			})
		if(self.hayMatchEnTablero()){		// resolvimos lo del comentario de abajo
			self.borrarMatchesInvisible()	
	}	}
	
	method borrarMatches() {
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchHorizontal()){
				puntaje += gema.puntaje()
				gema.borrarMatchHorizontal()}
			
		})
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchVertical()){
				puntaje += gema.puntaje()
				gema.borrarMatchVertical()}
			})
			
		if(self.hayMatchEnTablero()){ // podríamos usar algo como un while pero lo hicimos recursivo
			self.borrarMatchesInvisible() // es mas conveniente un while para llamar a la otra version de borrar match, pero en wollok no existe
		}                                // Cuando es recursivo el sonido vuelve a reproducirse y genera un error, asi que en esta version solo revisa una vez más si volvio a generar un match
		else{                           // wollok.lang.Exception: Un sonido solo se puede reproducir una vez.
			         // cada vez que entra en la recursividad el sonido se bugea, por eso las dos versiones
		}
	}
	
	method hayMatchEnTablero()= not self.gemasConMatch().isEmpty()

	method ganar(){
			puntaje = 0
			juegoTerminado = true
			game.clear()
			fondo.image(fondo.imagenVictoria())
			game.addVisualIn(fondo, game.at(0,0))
			sonido.musicaDeInicio().pause()
			sonido.victoria()
			game.schedule(5000,{
				fondo.image(fondo.imagenMenuSinHelp())
				game.clear()	
				self.inicio()
				sonido.musicaDeInicio().resume()
			} )
			
		
	}	
}

	

	
	
	
