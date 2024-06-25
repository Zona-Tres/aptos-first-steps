# Habilidades

Las habilidades son una característica de tipado en Move que controla qué acciones son permisibles para los valores de un tipo dado. Este sistema garantiza un control detallado sobre el comportamiento de tipado "lineal" de los valores, así como si los valores se utilizan en el almacenamiento global y cómo. Esto se implementa bloqueando el acceso a ciertas instrucciones de código de bytes, de modo que para que un valor pueda ser utilizado con la instrucción de código de bytes, debe tener la habilidad requerida, si es que se requiere alguna. No todas las instrucciones están bloqueadas por una habilidad.

Las habilidades Forman parte de la declaración de un `struct` y definen los comportamientos permitidos para las instancias de esta estructura.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/08_habilidades
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Habilidades
Running Move unit tests
[ PASS    ] 0x5a6f6e612054726573::cadenas::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/habilidades.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

### Sintaxis

|Habilidad|Descripción|
|---|---|
|`copy`|Permite que los valores con esta habilidad sean copiados.|
|`drop`|Permite que los valores con esta habilidad sean descartados.|
|`store`|Permite que los valores con esta habilidad sean almacenados en una estructura en el **almacenamiento global**.|
|`key`|Permite que el tipo pueda fungir como llave para operaciones con el **almacenamiento global**.|

Las habilidades se establecen en la definición del `struct` utilizando la palabra clave `has` seguida de una lista de habilidades. Las habilidades están separadas por comas. Move soporta 4 habilidades: `copy`, `drop`, `key`, y `store`, cada una de ellas se utiliza para definir un comportamiento específico para las instancias de la estructura.

```move
/// Este `struct` tiene las habilidades `copy` y `drop`.
struct Estructura has copy, drop {
    // campo1: Tipo1,
    // campo2: Tipo2,
    // ...
}
```

### `copy`

La habilidad `copy` permite copiar valores de tipos con esa habilidad. Permite copiar valores de variables locales con el operador `copy` y copiar valores mediante dereferenciación `*e`.

Si un valor tiene `copy`, todos los valores contenidos dentro de ese valor tienen `copy`.

### `drop`

La habilidad `drop` permite descartar valores de tipos con esa habilida. Por descartar, nos referimos a que el valor no es transferido y es efectivamente destruido mientras el programa Move se ejecuta. Como tal, esta habilidad da la posibilidad de **ignorar** valores en una multitud de lugares, incluyendo:
* no utilizar el valor en una variable local o parámetro
* no utilizar el valor en un bloque mediante ;
* sobrescribir valores en variables
* sobrescribir valores mediante referencias al escribir `*e1` = `e2`.

Si un valor tiene `drop`, todos los valores contenidos dentro de ese valor tienen `drop`.

### `store`

La habilidad `store` permite que los valores de los tipos con esta habilidad existan dentro de una estructura (recurso) en el **almacenamiento global**, pero no necesariamente como un recurso de nivel superior en el **almacenamiento global**. Esta es la única habilidad que no bloquea directamente una operación. En su lugar, bloquea la existencia en el **almacenamiento global** cuando se utiliza junto con `key`.

Si un valor tiene `store`, todos los valores contenidos dentro de ese valor tienen `store`.

### `key`

La habilidad `key` permite que el tipo sirva como clave para operaciones de **almacenamiento global**. Permite todas las operaciones de **almacenamiento global**, por lo que para que un tipo se pueda utilizar con `move_to`, `borrow_global`, `move_from`, etc., el tipo debe tener la habilidad `key`. Ten en cuenta que las operaciones deben utilizarse en el módulo en el que se define el tipo `key` (las operaciones son privadas para el módulo que las define).

Si un valor tiene `key`, todos los valores contenidos dentro de ese valor tienen `store`. Esta es la única habilidad con este tipo de asimetría.

### Tipos primitivos

La mayoría de los tipos primitivos tienen `copy`, `drop` y `store` con la excepción de `signer`, que sólo tiene `drop`.

* `bool`, `u8`, `u16`, `u32`, `u64`, `u128`, `u256`, y `address` tienen `copy`, `drop`, y `store`.
* `signer` tiene `drop`.
    * No se puede copiar y no se puede guardar en el **almacenamiento global**.
* `vector<T>` puede tener `copy`, `drop` y `store` dependiendo de las capacidades de `T`.
* Las referencias inmutables `&` y las referencias mutables `&mut` tienen ambas `copy` y `drop`.
    * Esto se refiere a copiar y descartar la referencia en sí, no a lo que están refiriendose.
    * Las referencias no pueden aparecer en el **almacenamiento global**, dado a que no tienen `store`.
* **Ninguno** de los tipos primitivos tiene `key`, lo que significa que ninguno de ellos puede utilizarse directamente con las operaciones de **almacenamiento global**.

> :information_source: Recuerda que puedes encontrar más información sobre las habilidades en la [documentación](https://move-language.github.io/move/abilities.html) oficial del lenguaje Move.

## Reto

Simplemente lee la documentación y asegúrate de entenderla. A partir de aquí, la mayoría de los ejercicios tendrán tipos con habilidades, por lo que es importante que al menos identifiques cada una y su función.