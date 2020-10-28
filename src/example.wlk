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

class Commit {
	const descripcion
	const cambios = new List()
	
	method aplicar(carpeta) {
		cambios.forEach({ cambio => cambio.apply(carpeta) })
	}
	
	method revert() = new Commit(descripcion = "revert " + descripcion, 
		cambios = cambios.reverse()//TODO: invertir paso .forEach({ cambio => ??? })
	)
}

class Branch {
	const commits
	
	method checkout(carpeta) {
		commits.forEach({ commit => commit.aplicar(carpeta) })
	}
}