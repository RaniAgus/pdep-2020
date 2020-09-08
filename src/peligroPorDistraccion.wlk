/** ¿Alguien quiere pensar en los carpinchos? */
object plantaNuclear
{
	var barrasUranio = 0
	var empleadoSalaControl = homero
	
	method estaEnPeligro() = 
		( barrasUranio > 10000 and empleadoSalaControl.estaDistraido() ) 
		or mrBurns.seQuedoPobre() 
	
	method cambiarEmpleado(empleado) { empleadoSalaControl = empleado }
	
	method traerBarrasUranio(cantidad) { barrasUranio += cantidad }
	
	method empleadoEstaDistraido() = empleadoSalaControl.estaDistraido()
}

object mrBurns
{
	var esRico = true
	
	method seQuedoPobre() = not esRico
	method despojarseRiquezas() { esRico = false }
}

object homero
{
	var donas = 0
	
	method estaDistraido() = donas < 2
	method comprarDonas() { donas += 12 }
	method comerDona() { donas-- }
	method comerDonas(cantidad) { donas-= cantidad }
}

object patoBalancin
{
	method estaDistraido() = false
}

object lenny
{
	var cervezasBebidas = 0
	
	method estaDistraido() = cervezasBebidas > 3
	method tomarCerveza() { cervezasBebidas++ }
	method tomarCervezas(cantidad) { cervezasBebidas+= cantidad }
}