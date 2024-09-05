# Condicionales

Las funciones condicionales se utilizan para tomar decisiones en un programa. Pueden ejecutar bloques de código dependiendo del resultado ó evaluar condiciones para continuar o abortar la ejecución de un modulo.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd backend/04_condicionales
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Condicionales
Running Move unit tests
[debug] "a es mayor a 0"
[debug] "a no es mayor a 20"
[debug] 10
[debug] "Usuario tiene acceso."
[ PASS    ] 0x5a6f6e612054726573::condicionales::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Tutorial

### If Else

La expresión `if` se utiliza para tomar decisiones en un programa. Evalúa una expresión booleana y ejecuta un bloque de código si la expresión es verdadera. Junto con `else`, puede ejecutar un bloque de código diferente si la expresión es falsa.

La sintaxis de la expresión if es

```rust
if (<expresión_bool>) <expresión>;
```
```rust
if (<expresión_bool>) <expresión> else <expresión>;
```

ó

```rust
if (<expresión_bool>) {
  <expresión>
};
```
```rust
if (<expresión_bool>) {
  <expresión>
} else {
  <expresión>
};
```

### Abort

La palabra clave `abort` se utiliza para abortar la ejecución de una función. Se utiliza junto con un código de aborto, que será devuelto a la persona que llama a la función. El código de cancelación es un entero de tipo `u64`.

```rust
if (<expresión_bool>) {
  abort <código_de_error>
};
```
ó
```rust
if (<expresión_bool>) {
  abort(<código_de_error>)
};
```

### Assert

`assert!` es una macro que se puede utilizar para afirmar una condición. Si la condición es falsa, la ejecución de la función se cancelará con el código de cancelación dado. La macro `assert!` es una forma práctica de abortar una funcón si no se cumple una condición. La macro acorta el código que de otro modo se escribiría con una expresión `if` + `abort`. El argumento código es obligatorio y debe ser un valor `u64`.

```rust
assert!(<expresión_bool>, <código_de_error>);
```

### Códigos de error

Para que los códigos de error sean más descriptivos, es una buena práctica definir **constantes de error**. Se definen como declaraciones `const` y suelen llevar el prefijo `E` seguido de un nombre en `camel case`. Las **constantes de error** no son diferentes de otras constantes y no tienen un manejo especial, sin embargo, se utilizan para aumentar la legibilidad del código y facilitar la comprensión de los escenarios de aborto.

```rust
const ECodigo_de_error: u64 = <código_de_error>;
```
ó
```rust
const ECodigo_de_error_1: u64 = 1;
const ECODIGO_DE_ERROR_2: u64 = 2;
```

## Leyendo los recursos del tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/condicionales.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

## Reto

* Crea una constante de error con el valor que desees para indicar que el usuario es menor de edad.
* Crea una variable que represente una edad.
* Evalúa esta variable en un bloque condicional usando `if` y `else`:
  * Si el usuario es mayor de edad, imprime un mensaje para hacerle saber que puede acceder a los contenidos de tu programa.
  * Si el usuario **no** es mayor de edad, aborta la ejecución enviando el código de error que creaste al inicio.
* Haz esta misma evaluación usando `assert`. Recuerda que `assert` no regresa ningún mensaje, pero si regresa un número como código de error.

> :information_source: Recuerda guardar tus cambios en el archivo para posteriormente hacerles `push` a tu repositorio de **Github**.