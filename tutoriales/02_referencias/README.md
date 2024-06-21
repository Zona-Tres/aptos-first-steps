# Referencias

Move tiene dos tipos de referencias: inmutables `&` y mutables `&mut`. Las referencias inmutables son de sólo lectura, y no pueden modificar su valor (o cualquiera de sus campos). Las referencias mutables permiten modificaciones mediante una escritura a través de esa referencia. El sistema de tipos de Move impone una disciplina de propiedad `ownership` que evita errores de referencia.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/02_referencias
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Referencias
Running Move unit tests
[debug] 1
[debug] 7
[debug] 1
[debug] 1
[debug] 1
[debug] 20
[debug] 20
[ PASS    ] 0x1337::referencias::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Tutorial

### Operadores

Habrás notado que en las lecciones anteriores, para utilizar un valor, como en las funciones para imprimir en consola, se pone un *ampersand* `&` antes de las variables. Esto es a lo que llamamos una referencia. Si quitamos ese símbolo, el compilador marca error, dado a que a ese `scope` no le pertenece esa variable, es decir, necesitamos decirle al compilador que la función `print` va a tomar "prestado" ese valor para poderlo utilizar.

Move proporciona operadores para crear y ampliar referencias, así como para convertir una referencia mutable a una inmutable. Utilizaremos la notación `e: T` para "expresión" `e` tiene tipo `T`.

|Sintaxis|Tipo|Descripción|
|---|---|---|
|`&e` | `&T` donde `e: T` y `T` es un tipo no referenciado.| Crea una referencia **inmutable** de `e`.|
|`&mut e` | `&mut T` donde `e: T` y `T` es un tipo no referenciado.|	Crea una referencia **mutable** de `e`.|
|`&e.f` | `&T` donde `e.f: T` | Crea una referencia **inmutable** al campo `f` del `struct` `e`.|
|`&mut e.f` |	`&mut T` donde `e.f: T` |	Crea una referencia **mutable** al campo `f` del `struct` `e`.|
| `freeze(e)` |	`&T` donde `e: &mut T` | Convierte la referencia **mutable** `e` a una referencia **inmutable**.

### Leyendo y escribiendo a través de referencias

Tanto las referencias mutables como las inmutables pueden leerse para producir una copia del valor referenciado.

Sólo las referencias mutables pueden escribirse. Una escritura *x = v descarta el valor almacenado previamente en x y lo actualiza con v.

|Sintaxis|Tipo|Descripción|
|---|---|---|
| `*e` | `T` donde `e` es `&T` o `&mut T` | Lee el valor apuntado por `e` |
|`*e1 = e2` | `()` donde `e1: &mut T` y `e2: T` | Actualiza el valor de `e1` con el de `e2` |

## Leyendo los recursos del tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/referencias.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.