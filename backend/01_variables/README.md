# Variables

### Locales
Las variables locales en Move tienen un `scope` léxico (estático). Las nuevas variables se introducen con la palabra clave `let`, que hará `shadow` a cualquier local anterior con el mismo nombre. Las variables locales son **mutables** y pueden actualizarse tanto directamente como a través de una referencia mutable.


### Constantes
Las constantes son una forma de dar un nombre a valores estáticos compartidos dentro de un `module` o `script`.

La constante debe conocerse en el momento de la compilación. El valor de la constante se almacena en el `module` o `script` compilado. Y cada vez que se utiliza la constante, se hace una nueva copia de ese valor.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd backend/01_variables
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Variables
Running Move unit tests
[debug] "Hola, Mundo!"
[debug] true
[debug] 1
[debug] 2
[debug] "Aptos"
[debug] 0
[debug] 1
[debug] 100
[debug] 10
[debug] 15
[debug] false
[ PASS    ] 0x5a6f6e612054726573::variables::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Leyendo los recursos del tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/variables.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

Los temas son:
* Constantes
* Declarando variables
* Nombrando variables
* Anotaciones de tipo
* Declaración múltiple
* Reasignación
* Scope
* Shadowing