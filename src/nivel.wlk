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
	keyboard.space().onPressDo{self.configurate() sonido.reproducirSiSePuede()}
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
		var points = puntaje
		if (puntaje >= 500){
		self.borrarTablero()
		self.generarGemasEnTablero()
		self.borrarMatches()
		sonido.reiniciar()		
		puntaje = points - 500
		game.say(selector, "Tienes " + puntaje + " puntos.") 
		self.setearDigitos()
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
		
		// Linea Puntajes
		game.addVisual(digito1)
		game.addVisual(digito2)
		game.addVisual(digito3)
		game.addVisual(digito4)
		//
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
	}
	// Linea puntajes
	self.puntajeEnPantalla()
		}
	
	method borrarMatches() {
		/*self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchHorizontalCuadruple()){
				puntaje += gema.puntaje() * 2
				gema.borrarMatchHorizontalCuadruple()}})
		
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchVerticalCuadruple()){
				puntaje += gema.puntaje() * 2
				gema.borrarMatchVerticalCuadruple()}})*/
				
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchHorizontal()){
				puntaje += gema.puntaje()
				gema.borrarMatchHorizontal()}})
				
		self.gemasConMatch().forEach({ gema =>
			if(gema.tieneMatchVertical()){
				puntaje += gema.puntaje()
				gema.borrarMatchVertical()}})
			
		if(self.hayMatchEnTablero()){ // podríamos usar algo como un while pero lo hicimos recursivo
			self.borrarMatchesInvisible()} // es mas conveniente un while para llamar a la otra version de borrar match, pero en wollok no existe
		                                // Cuando es recursivo el sonido vuelve a reproducirse y genera un error, asi que en esta version solo revisa una vez más si volvio a generar un match
		else{                           // wollok.lang.Exception: Un sonido solo se puede reproducir una vez.
			         // cada vez que entra en la recursividad el sonido se bugea, por eso las dos versiones
		}
		//Linea puntajes
		self.puntajeEnPantalla()
	}
	
	method hayMatchEnTablero()= not self.gemasConMatch().isEmpty()

	method ganar(){
			puntaje = 0
			juegoTerminado = true
			game.clear()
			fondo.image(fondo.imagenVictoria())
			game.addVisualIn(fondo, game.at(0,0))
			sonido.pausarSiSePuede()
			sonido.victoria()
			game.schedule(5000,{
				fondo.image(fondo.imagenMenuSinHelp())
				game.clear()	
				self.inicio()
			} )
			
		
	}	
	
	// Todo lo que sigue es de puntajes
	method puntajeEnPantalla(){
		
		game.removeVisual(digito1)
		game.removeVisual(digito2)
		game.removeVisual(digito3)
		game.removeVisual(digito4)
			
		self.setearDigitos()		
		
		game.addVisual(digito1)	
		game.addVisual(digito2)	
		game.addVisual(digito3)	
		game.addVisual(digito4)
		
		
	}
	method setearDigitos(){  
		
		if(puntaje.digits() == 1)  {
			digito4.valorD4(puntaje)
			digito3.valorD3(0) 
			digito2.valorD2(0)
			digito1.valorD1(0)
		}			  						
		if(puntaje.digits() == 2){  
			digito3.valorD3(puntaje.div(10)) 
			digito4.valorD4(puntaje - digito3.valorD3() * 10) 
			digito2.valorD2(0)
			digito1.valorD1(0)
		} 						
		if(puntaje.digits() == 3){  
			digito2.valorD2( puntaje.div(100)) 
			digito3.valorD3((puntaje - digito2.valorD2() * 100).div(10))
			digito4.valorD4( puntaje - digito2.valorD2() * 100 - digito3.valorD3() * 10) 
			digito1.valorD1(0)
		}					
		if(puntaje.digits() == 4){					
			digito1.valorD1( puntaje.div(1000))  
			digito2.valorD2((puntaje - digito1.valorD1() * 1000).div(100))
			digito3.valorD3((puntaje - digito1.valorD1() * 1000 - digito2.valorD2() * 100).div(10))
			digito4.valorD4( puntaje - digito1.valorD1() * 1000 - digito2.valorD2() * 100 - digito3.valorD3() * 10 ) 
			
	}

}}
class Digito{
	const property listaNumeros = [numero0,numero1,numero2,numero3,numero4,numero5,numero6,numero7,numero8,numero9]
	method esUnaGema() = false
	method position()
	method image()
}

object digito1 inherits Digito{
	var property valorD1 = 0
	override method position() = game.at(5,9)
	override method image() = listaNumeros.get(valorD1).image()
	
}
object digito2 inherits Digito{
	var property valorD2 = 0
	override method position() = game.at(6,9)
	override method image() = listaNumeros.get(valorD2).image()

}
object digito3 inherits Digito{
	var property valorD3 = 0
	override method position() = game.at(7,9)
	override method image() = listaNumeros.get(valorD3).image()
	}
object digito4 inherits Digito{
	var property valorD4 = 0
	override method position() = game.at(8,9)
	override method image() = listaNumeros.get(valorD4).image()
	}
	
object numero0{
	var property image = "num0.png"
}
object numero1{
	var property image = "num1.png"
}
object numero2{
	var property image = "num2.png"
}
object numero3{
	var property image = "num3.png"
}
object numero4{
	var property image = "num4.png"
}
object numero5{
	var property image = "num5.png"
}
object numero6{
	var property image = "num6.png"
}
object numero7{
	var property image = "num7.png"
}
object numero8{
	var property image = "num8.png"
}
object numero9{
	var property image = "num9.png"
}
	
	



	

	
	
	
