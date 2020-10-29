import archivos.*
import autores.*

class Commit {
	const property autor
	const property descripcion
	const property cambios
	
	method aplicar(carpeta) { cambios.forEach({ cambio => cambio.aplicar(carpeta) }) }
	
	method afecta(nombreArchivo) = cambios.any({ cambio => cambio.afecta(nombreArchivo) })
	
	method revert(nuevoAutor) = new Commit(autor = nuevoAutor, descripcion = "revert " + descripcion, 
		cambios = cambios.reverse().map({ cambio => cambio.inverso() })
	)
}

class Branch {
	const creador
	const colaboradores
	const property commits = new List()
	
	method puedeCommitear(usuario) =  usuario == creador or colaboradores.contains(usuario) 
		or usuario.rol() == administrador or ( usuario.rol() == bot and commits.size() > 10 )
	
	method commitear(usuario, commit) {
		if(not self.puedeCommitear(usuario)) {
			self.error("No cuenta con los permisos suficientes para commitear")
		}
		commits.add(commit)
	}
	
	method checkout(carpeta) {
		commits.forEach({ commit => commit.aplicar(carpeta) })
	}
	
	method log(nombreArchivo) = commits.filter({ commit => commit.afecta(nombreArchivo) })
	
	method blame(nombreArchivo) = self.log(nombreArchivo).map({ commit => commit.autor() })
}

class Cambio {
	const property nombreArchivo
	method afecta(archivo) = archivo == nombreArchivo
	
	method aplicar(carpeta) {}
	method inverso() = null
}

class Crear inherits Cambio {
	override method aplicar(carpeta) { carpeta.crear(nombreArchivo) }
	override method inverso() = new Eliminar(nombreArchivo = nombreArchivo)
}

class Eliminar inherits Cambio {
	override method aplicar(carpeta) { carpeta.eliminar(nombreArchivo) }
	override method inverso() = new Crear(nombreArchivo = nombreArchivo)
}

class Agregar inherits Cambio {
	const property texto
	
	override method aplicar(carpeta) { carpeta.agregar(nombreArchivo, texto) }
	override method inverso() = new Sacar(nombreArchivo = nombreArchivo, texto = texto)
}

class Sacar inherits Cambio {
	const property texto
	
	override method aplicar(carpeta) { carpeta.sacar(nombreArchivo, texto) }
	override method inverso() = new Agregar(nombreArchivo = nombreArchivo, texto = texto)
}