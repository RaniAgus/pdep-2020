import archivos.*

class Commit {
	const property descripcion
	const property cambios = new List()
	
	method aplicar(carpeta) { cambios.forEach({ cambio => cambio.aplicar(carpeta) }) }
	
	method afecta(nombreArchivo) = cambios.any({ cambio => cambio.afecta(nombreArchivo) })
	
	method revert() = new Commit(descripcion = "revert " + descripcion, 
		cambios = cambios.reverse().map({ cambio => cambio.inverso() })
	)
}

class Branch {
	const commits
	
	method checkout(carpeta) {
		commits.forEach({ commit => commit.aplicar(carpeta) })
	}
	
	method log(nombreArchivo) = commits.filter({ commit => commit.afecta(nombreArchivo) })
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