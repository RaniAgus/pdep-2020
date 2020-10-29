import archivos.*
import autores.*

class Commit {
	const property autor
	const property descripcion
	const property cambios
	
	method aplicar(carpeta) { cambios.forEach({ cambio => cambio.aplicar(carpeta) }) }
	
	method afecta(nombreArchivo) = cambios.any({ cambio => cambio.afecta(nombreArchivo) })
	
	method revert(nuevoAutor) = new Commit(
		autor = nuevoAutor, 
		descripcion = "revert " + descripcion, 
		cambios = cambios.reverse().map({ cambio => cambio.inverso() })
	)
}

class Branch {
	const property creador
	const colaboradores
	const commits = new List()
	
	method colaboradores() = colaboradores
	method commits() = commits
	
	method commitear(commit) {
		commit.autor().validarPermisos(self)
		commits.add(commit)
	}
	
	method checkout(carpeta) {
		commits.forEach({ commit => commit.aplicar(carpeta) })
	}
	
	method log(nombreArchivo) = commits.filter({ commit => commit.afecta(nombreArchivo) })
	
	method blame(nombreArchivo) = self.log(nombreArchivo).map({ commit => commit.autor() })
}

class Cambio {
	const nombreArchivo
	method nombreArchivo() = nombreArchivo
	
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
	const texto
	method texto() = texto
	
	override method aplicar(carpeta) { 
		const archivo = carpeta.obtener(nombreArchivo)
		archivo.agregar(texto)
	}
	override method inverso() = new Sacar(nombreArchivo = nombreArchivo, texto = texto)
}

class Sacar inherits Cambio {
	const texto
	method texto() = texto
	
	override method aplicar(carpeta) { 
		const archivo = carpeta.obtener(nombreArchivo)
		archivo.sacar(texto)
	}
	override method inverso() = new Agregar(nombreArchivo = nombreArchivo, texto = texto)
}