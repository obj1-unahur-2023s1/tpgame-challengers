import wollok.game.*
import selector.*
import gemas.*
import marco.*
import sonido.*

object nivel {
	var puntaje = 0
	var juegoTerminado = false
	// Linea nueva puntajes
	var property pantalla =[]
		var property pantallas = []
		var property v1 = 0
		var property v2 = 0
		var property v3 = 0
		var property v4 = 0
		
		method v1() = v1
		method v2() = v2
		method v3() = v3
		method v4() = v4
	//
	
	
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
		if (puntaje >= 500){
		self.borrarTablero()
		self.generarGemasEnTablero()
		self.borrarMatches()
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
		
		// Linea Puntajes
		game.addVisual(dd1)
		game.addVisual(dd2)
		game.addVisual(dd3)
		game.addVisual(dd4)
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
		//self.gemasConMatch().forEach({ gema =>
			//if(gema.tieneMatchHorizontalCuadruple()){
				//puntaje += gema.puntaje() * 2
				//gema.borrarMatchHorizontalCuadruple()}})
		
		//self.gemasConMatch().forEach({ gema =>
			//if(gema.tieneMatchVerticalCuadruple()){
				//puntaje += gema.puntaje() * 2
				//gema.borrarMatchVerticalCuadruple()}})
				
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
		
		game.removeVisual(dd1)
		game.removeVisual(dd2)
		game.removeVisual(dd3)
		game.removeVisual(dd4)
			
		self.agregarPrimerValor()		
		
		game.addVisual(dd1)	
		game.addVisual(dd2)	
		game.addVisual(dd3)	
		game.addVisual(dd4)
		
		
	}
	method agregarPrimerValor()  {  
		
		if(puntaje.digits() == 1)  {
			v4 = puntaje
			v3 = 0 
			v2 = 0
			v1 = 0
		}			  						
		if(puntaje.digits() == 2){  
			v3 = puntaje.div(10)
			v4 = puntaje - v3 * 10
			v2 = 0
			v1 = 0
		} 						
		if(puntaje.digits() == 3){  
			v2 = puntaje.div(100)
			v3 =(puntaje - v2 * 100).div(10)
			v4 = puntaje - v2 * 100 - v3 * 10
			v1 = 0
		}					
		if(puntaje.digits() == 4){					
			v1 =  puntaje.div(1000)
			v2 = (puntaje - v1 * 1000).div(100)
			v3 = (puntaje - v1 * 1000 - v2 * 100).div(10)
			v4 = (puntaje - v1 * 1000 - v2 * 100 - v3 * 10 ).div(1)
			
				}
		dd1.vv1(v1)
		dd2.vv2(v2)
		dd3.vv3(v3)
		dd4.vv4(v4)
	}

}
class Dd{
	const property a = [d0,d1,d2,d3,d4,d5,d6,d7,d8,d9]
	method esUnaGema() = false
	method position()
	method image()
}

object dd1 inherits Dd{
	var property vv1 = 0
	override method position() = game.at(0,1)
	override method image() = a.get(vv1).image()
	
}
object dd2 inherits Dd{
	var property vv2 = 0
	override method position() = game.at(1,1)
	override method image() = a.get(vv2).image()

}
object dd3 inherits Dd{
	var property vv3 = 0
	override method position() = game.at(2,1)
	override method image() = a.get(vv3).image()
	}
object dd4 inherits Dd{
	var property vv4 = 0
	override method position() = game.at(3,1)
	override method image() = a.get(vv4).image()
	}
	
object d0{
	var property image = "num0.png"
}
object d1{
	var property image = "num1.png"
}
object d2{
	var property image = "num2.png"
}
object d3{
	var property image = "num3.png"
}
object d4{
	var property image = "num4.png"
}
object d5{
	var property image = "num5.png"
}
object d6{
	var property image = "num6.png"
}
object d7{
	var property image = "num7.png"
}
object d8{
	var property image = "num8.png"
}
object d9{
	var property image = "num9.png"
}
	
	



	

	
	
	
