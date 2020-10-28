class Archivo {
	var property nombre
	var contenido = ""
	
	method contenido() = contenido
	
	method agregar(texto) {
		contenido += texto 
	}
	
	method sacar(texto) {
		if(not contenido.endsWith(texto)) {
			self.error("No se puede quitar el texto \"" + texto + "\" del final del archivo: " + nombre)
		}
		contenido = contenido.takeLeft(contenido.length() + texto.length())
	}
}

class Carpeta {
	var property nombre
	const archivos = new Set()
	
	method contiene(nombreArchivo) = archivos.any({ archivo => archivo.nombre() == nombreArchivo })
	
	method estaVacia() = archivos.isEmpty()
	
	method crear(nombreArchivo) {
		if(self.contiene(nombreArchivo)) {
			self.error("Ya existe un archivo con el nombre: " + nombreArchivo)
		}
		archivos.add(new Archivo(nombre = nombreArchivo))
	}
	
	method eliminar(nombreArchivo) {
		if(not self.contiene(nombreArchivo)) {
			self.error("No existe un archivo con el nombre: " + nombreArchivo)
		}
		archivos.removeAllSuchThat({ archivo => archivo.nombre() == nombreArchivo })
	}
	
	method agregar(nombreArchivo, texto) {
		if(not self.contiene(nombreArchivo)) {
			self.error("No existe un archivo con el nombre: " + nombreArchivo)
		}
		self.obtener(nombreArchivo).agregar(texto)
	}
	
	method sacar(nombreArchivo, texto) {
		if(not self.contiene(nombreArchivo)) {
			self.error("No existe un archivo con el nombre: " + nombreArchivo)
		}
		self.obtener(nombreArchivo).sacar(texto)		
 	}
 	
 	method obtener(nombreArchivo) {
 		if(not self.contiene(nombreArchivo)) {
			self.error("No existe un archivo con el nombre: " + nombreArchivo)
		}
		return archivos.find({ archivo => archivo.nombre() == nombreArchivo })
 	}
}

class Crear {
	const property nombreArchivo
	
	method aplicar(carpeta) { carpeta.crear(nombreArchivo) }
	method afecta(archivo) = archivo == nombreArchivo
	method inverso() = new Eliminar(nombreArchivo = nombreArchivo)
}

class Eliminar {
	const property nombreArchivo
	
	method aplicar(carpeta) { carpeta.eliminar(nombreArchivo) }
	method afecta(archivo) = archivo == nombreArchivo
	method inverso() = new Crear(nombreArchivo = nombreArchivo)
}

class Agregar {
	const property nombreArchivo
	const property texto
	
	method aplicar(carpeta) { carpeta.agregar(nombreArchivo, texto) }
	method afecta(archivo) = archivo == nombreArchivo
	method inverso() = new Sacar(nombreArchivo = nombreArchivo, texto = texto)
}

class Sacar {
	const property nombreArchivo
	const property texto
	
	method aplicar(carpeta) { carpeta.sacar(nombreArchivo, texto) }
	method afecta(archivo) = archivo == nombreArchivo
	method inverso() = new Agregar(nombreArchivo = nombreArchivo, texto = texto)
}

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