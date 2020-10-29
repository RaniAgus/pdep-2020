import archivos.*
import commits.*

class Usuario {
	var rol
	method rol(nuevoRol) { rol = nuevoRol }
	
	method cambiarRol(usuarios, nuevoPermiso) {
		if(not rol.puedeCambiarRol()) {
			self.error("No cuenta con los permisos suficientes para cambiar el rol de un usuario")
		}
		usuarios.forEach({ usuario => usuario.rol(nuevoPermiso) })
	}
	
	method validarPermisos(branch) {
		if(not rol.tienePermisos(self, branch)) {
			self.error("No cuenta con los permisos suficientes para commitear")
		}
	}
}

object comun {
	method puedeCambiarRol() = false
	
	method tienePermisos(usuario, branch) = 
		branch.creador() == usuario or branch.colaboradores().contains(usuario)
}

object administrador {
	method puedeCambiarRol() = true
	
	method tienePermisos(usuario, branch) = true
}

object bot {
	method puedeCambiarRol() = false
	
	method tienePermisos(usuario, branch) = 
		branch.creador() == usuario or branch.commits().size() > 10
}