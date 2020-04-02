# Cerebro Mágico

## Enunciado
En [este link](https://docs.google.com/document/d/17_8sUM-7oMtfp03LJE38ErWX3ijqtIUZxE5kXE8VEFs/edit?usp=sharing)

## Cómo resolver el TP
Este repo ya contiene un _proyecto Stack_ con algunos archivos necesarios y un poco de código del ejercicio. Por lo general, para los TPs ya les vamos a dar un código base que tienen que bajar de GitHub, modificar resolviendo el enunciado y volver a subirlo a GitHub para que lo podamos corregir.

#### La solución al enunciado lo deben resolver específicamente en el archivo [src/CerebroMagico.hs](src/CerebroMagico.hs), que ya contiene algunas definiciones.

## Probar el proyecto
Lo primero que recomendamos hacer es tratar de levantar el proyecto desde una consola. Para ello basta con navegar hasta la carpeta donde se clonaron el proyecto (`2020-f-tp1-cerebro-magico-xxxxxx`) y ejecutar por consola:

```bash
$ stack ghci
```

#### ADVERTENCIA: La primera vez que ejecutemos este comando comenzará a descargar cosas de internet, así que puede que tarde un rato.

Al final, ya deberíamos estar en la consola de Haskell con las definiciones cargadas. Podés probar si existe la constante `vocales`:

```bash
CerebroMagico> vocales
"aeiouAEIOU"
```

#### NOTA: ¡No se olviden de recargar la consola `:r` cada vez que hagan una modificación en el archivo!

Pueden encontrar más información en [este link](https://github.com/pdep-utn/enunciados-miercoles-noche/blob/master/pages/haskell/trabajo.md). La parte de 'Pruebas automatizadas' lo veremos la próxima clase.
