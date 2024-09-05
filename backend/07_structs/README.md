# Structs

Los tipos definidos por el usuario pueden adaptarse a las necesidades específicas de la aplicación. No sólo a nivel de datos, sino también en su comportamiento. En esta sección presentamos la definición de `struct` y cómo utilizarla.

Un `struct` es una estructura de datos definida por el usuario que contiene campos tipados. Los `struct` pueden almacenar cualquier tipo no referenciado, incluidos otros structs.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd backend/07_structs
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Structs
Running Move unit tests
[debug] "0x5a6f6e612054726573::cadenas::Autor {
  nombre: \"Paulo Cohelo\"
}"
[debug] "0x5a6f6e612054726573::cadenas::Libro {
  titulo: \"El Alquimista\",
  autor: 0x5a6f6e612054726573::cadenas::Autor {
    nombre: \"Paulo Cohelo\"
  },
  publicado: 1988,
  tiene_audiolibro: true,
  edicion: Some(1)
}"
[debug] "El Alquimista"
[debug] "Paulo Cohelo"
[debug] 1988
[debug] true
[debug] "J. K. Rowling"
[debug] "John Green"
[debug] "Octavio Paz"
[debug] "Carlos Fuentes"
[debug] "Edgar Allan Poe"
[debug] "George Orwell"
[debug] "Charles Dickens"
[debug] "0x5a6f6e612054726573::cadenas::Autor {
  nombre: \"Charles Dickens\"
}"
[ PASS    ] 0x5a6f6e612054726573::cadenas::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/structs.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

> :information_source: Recuerda que puedes encontrar más información sobre los `struct` y sus métodos en la [documentación](https://move-language.github.io/move/structs-and-resources.html) oficial del lenguaje Move.

## Reto

* Crea un `struct` de una Persona con los campos que gustes. Al menos 3. 
    * Por ejemplo: `nombre`,`edad`.
* Crea un `struct` de una Clase (una clase de una escuela) con los campos que gustes.
    * Por ejemplo: `materia`, `horario`.
    * Debe incluir el `struct` Persona en alguno de los campos. Por ejemplo en un campo llamado Maestro.
* Crea un `struct` de una Escuela con los campos que gustes.
    * Por ejemplo `nombre`, `domicilio`.
    * Debe incluir un `vector` de Clases.
* Usa esos `struct` de manera que tengas una Escuela con un `vector` de Clases, el cual incluya al menos 2 clases de 2 diferentes maestros.
* Imprime la variable que crees de la Escuela en consola usando `debug_string`. Debería de imprimir todas los campos.

> :information_source: Recuerda guardar tus cambios en el archivo para posteriormente hacerles `push` a tu repositorio de **Github**.