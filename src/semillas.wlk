class Planta{
	var property anioObtencion
	var property altura
	method horasToleranciaSol()
	method esFuerte() = self.horasToleranciaSol()>10
	method daNuevasSemillas() = self.esFuerte()
}

class Menta inherits Planta{
	override method horasToleranciaSol() = 6
	override method daNuevasSemillas() = super() or altura>0.4
	method espacio() = altura*3
	method esParcelaIdeal(parcela) = parcela.superficie()>6
}

class Soja inherits Planta{
	override method horasToleranciaSol(){
		return if(altura<0.5) 6 else if(altura.between(0.5,1)) 7 else 9
	}
	override method daNuevasSemillas() = super() or (anioObtencion>2007 and altura>1)
	method espacio() = altura*0.5
	method esParcelaIdeal(parcela) = self.horasToleranciaSol()==parcela.horasDeSol()
}

class Quinoa inherits Planta{
	var property horasToleranciaSol
	override method daNuevasSemillas() = super() or anioObtencion<2005
	method espacio() = 0.5
	method esParcelaIdeal(parcela) = not parcela.plantas().any({p=>p.altura()>1.5})
}

class SojaTrans inherits Soja{
	override method daNuevasSemillas() = false
	override method esParcelaIdeal(parcela) = parcela.cantidadMax()==1
}

class Hierbabuena inherits Menta{
	override method espacio() = super()*2
}

class Parcela{
	var property ancho
	var property largo
	var property horasDeSol
	const property plantas = []
	method superficie() = ancho*largo
	method cantidadMax() = if(ancho>largo) self.superficie()/5 else self.superficie()/3+largo
	method tieneComplicaciones() = plantas.any({p=>p.horasToleranciaSol()<horasDeSol})
	method plantar(planta){
		if((plantas.size()!=self.cantidadMax()) and not (horasDeSol-2>planta.horasToleranciaSol()))
		plantas.add(planta)
		else{
			horasDeSol= 2/0
		}
	}
}

class ParcelaEcologica inherits Parcela{
	method seAsociaBien(planta) = not self.tieneComplicaciones() and planta.esParcelaIdeal(self)
}

class ParcelaIndustrial inherits Parcela{
	method seAsociaBien(planta) = self.plantas().size()<=2 and planta.esFuerte()
}

object inta{
	const property parcelas = []
	method promedioPlantasPorParcela() = parcelas.sum({par=>par.plantas().size()}) / parcelas.size()
	method parcelaMasAutosustentable() = parcelas.filter({par=>par.plantas().size()>4})
}
