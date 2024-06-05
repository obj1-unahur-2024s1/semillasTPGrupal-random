
class Plantas{
	var property anioObtecion
	var property altura
	
	method tolereanciaHorasDeSol()
	method esFuerte(){return self.tolereanciaHorasDeSol()>10}
	method daSemillasNuevas(){
		return
		self.esFuerte() 
	}
	
}

class Menta inherits Plantas{
	override method tolereanciaHorasDeSol() = 6
	override method daSemillasNuevas(){
		return
		super() or self.altura()> 0.4
	}
	method cuantoEspacionOcupa()= return self.altura()*3
}

class Soja inherits Plantas{
	override method tolereanciaHorasDeSol(){
		return
		if(altura<0.5)6
		else if (altura.between(0.5, 7)) 7
		else 9
	}
	override method daSemillasNuevas(){
		return
		anioObtecion >= 2007 and altura>1
	}
	method cuantoEspacionOcupa()= return self.altura()/2
}

class Quinoa inherits Plantas{
	var property horasDeSol 
	method cuantoEspacionOcupa()= 0.5
	override method daSemillasNuevas(){
		return 
		super() and anioObtecion >= 2005
	}
	
}
