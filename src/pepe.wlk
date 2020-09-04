//******************* EMPLEADOS *******************
object pepe
{
	var property categoria = gerente
	var property tipoBonoR = nulo
	var property tipoBonoP = nulo
	var property ausencias = 0
	
	method neto()   = categoria.neto()
	method sueldo() = self.neto() + tipoBonoR.bonoPorResultados(self) + tipoBonoP.bonoPorPresentismo(self)
}

object sofia
{
	var property categoria = gerente
	var property tipoBonoR = nulo
	
	method neto()   = 1.3 * categoria.neto()
	method sueldo() = self.neto() + tipoBonoR.bonoPorResultados(self)
}

object roque
{
	var property tipoBonoR = nulo
	
	method neto()   = 28000
	method sueldo() = self.neto() + tipoBonoR.bonoPorResultados(self) + 9000
}

object ernesto
{
	var property tipoBonoP = nulo
	const property ausencias = 0
	
	var property companiero = pepe
	
	method sueldo() = companiero.neto() + tipoBonoP.bonoPorPresentismo(self)
}

//****************** CATEGORÍAS *******************

object gerente { method neto() = 15000 }

object cadete  { method neto() = 20000 }

object vendedor
{
	const valorNeto = 16000
	
	var muchasVentas = false
	method activarAumentoMuchasVentas()    { muchasVentas = true  }
	method desactivarAumentoMuchasVentas() { muchasVentas = false } 
	
	method neto() 
	{ 
		return if (muchasVentas) valorNeto * 1.25 else valorNeto
	}
}

object medioTiempo
{
	var property categoriaBase = cadete
	
	method neto() = categoriaBase.neto() / 2
}

//********************* BONOS **********************
object porcentaje
{
	method bonoPorResultados(empleado) = empleado.neto() * 0.1
}

object montoFijo
{
	method bonoPorResultados(empleado) = 800
}

object nulo
{
	method bonoPorResultados(empleado)  = 0
	method bonoPorPresentismo(empleado) = 0
}

object normal
{
	method bonoPorPresentismo(empleado)
	{
		if		(empleado.ausencias() == 0) return 2000
		else if (empleado.ausencias() == 1) return 1000
		else							   return 0
	}
}
	
object ajuste
{ 
	method bonoPorPresentismo(empleado)
	{
		return if(empleado.ausencias() == 0) 100 else 0
	}	
}

object demagogico
{
	method bonoPorPresentismo(empleado)
	{
		return if(empleado.neto() < 18000) 500 else 300
	}	
}
