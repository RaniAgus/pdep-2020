import archivos.*
import commits.*

class Usuario {
	var property rol
	
	method cambiarRol(usuarios, nuevoPermiso) {
		rol.cambiarRol(usuarios, nuevoPermiso)
	}
}

object comun {
	method cambiarRol(usuarios, nuevoPermiso) {
		self.error("No puede cambiar los permisos de otro usuario")
	}
}

object administrador {
	method cambiarRol(usuarios, nuevoPermiso) {
		usuarios.forEach({ usuario => usuario.rol(nuevoPermiso) })
	}
}

object bot {
	method cambiarRol(usuarios, nuevoPermiso) {
		self.error("No puede cambiar los permisos de otro usuario")
	}
}