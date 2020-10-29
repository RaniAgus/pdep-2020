class Archivo {
	var nombre
	var contenido = ""
	
	method nombreEs(unNombre) = nombre == unNombre
	method contenido() = contenido
	
	method agregar(texto) {
		contenido += texto 
	}
	
	method sacar(texto) {
		if(not contenido.endsWith(texto)) {
			self.error("No se puede quitar el texto \"" + texto + "\" del final del archivo: " + nombre)
		}
		contenido = contenido.takeLeft(contenido.length() - texto.length())
	}
}

class Carpeta {
	var property nombre
	const archivos = new Set()
	
	method contiene(nombreArchivo) = archivos.any({ archivo => archivo.nombreEs(nombreArchivo) })
	
	method estaVacia() = archivos.isEmpty()
	
	method crear(nombreArchivo) {
		if(self.contiene(nombreArchivo)) {
			self.error("Ya existe un archivo con el nombre: " + nombreArchivo)
		}
		archivos.add(new Archivo(nombre = nombreArchivo))
	}
	
	method eliminar(nombreArchivo) {
		archivos.removeAllSuchThat({ archivo => archivo.nombreEs(nombreArchivo) })
	}
 	
 	method obtener(nombreArchivo) {
 		if(not self.contiene(nombreArchivo)) {
			self.error("No existe un archivo con el nombre: " + nombreArchivo)
		}
		return archivos.find({ archivo => archivo.nombreEs(nombreArchivo) })
 	}
}