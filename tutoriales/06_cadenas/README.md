# Cadenas

Move no tiene un tipo incorporado para representar cadenas, pero tiene dos implementaciones estándar para cadenas en la Biblioteca Estándar. El módulo `std::string` define un tipo `String` y métodos para cadenas codificadas en `UTF-8`, y el segundo módulo, `std::ascii`, proporciona un tipo `String ASCII` y sus métodos.

Puedes encontrar más información sobre las cadenas y sus métodos en la [documentación oficial](https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/move-stdlib/doc/string.md) del Aptos Core.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/06_cadenas
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Cadenas
Running Move unit tests
[debug] 0x48656c6c6f20576f726c6421
[debug] "Hello World!"
[debug] 0x48656c6c6f20576f726c6421
[debug] "Hello World!"
[debug] true
[debug] "Hola"
[debug] "HolaAdios"
[debug] "HolaAdiosHello World!"
[debug] "HolaINSERTAMEAdiosHello World!"
[debug] "HolaINSERTAMEAdiosHello World!
Esto se imprimira en una nueva linea."
[debug] "100"
[debug] "[ 10, 20, 30 ]"
[ PASS    ] 0x5a6f6e612054726573::cadenas::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Tutorial

### Las cadenas son bytes

Independientemente del tipo de cadena que utilices, es importante saber que las cadenas son sólo bytes. Los *wrappers* proporcionados por los módulos `string` y `ascii` son sólo eso: envolturas. Proporcionan comprobaciones de seguridad y métodos para trabajar con cadenas, pero al fin y al cabo, no son más que vectores de bytes.

### Cadenas UTF-8

Aunque existen dos tipos de cadenas en la biblioteca estándar, el módulo `string` debería considerarse el predeterminado. Tiene implementaciones nativas de muchas operaciones comunes, y por lo tanto es más eficiente que el módulo `ascii`, que está totalmente implementado en Move.

Las cadenas de bytes son literales de cadena entrecomillados precedidos por una `b`, por ejemplo `b"¡Hola!\n"`.

```rust
let hello: String = string::utf8(b"¡Hola!");
```

Se trata de cadenas codificadas en ASCII que admiten secuencias de escape. Actualmente, las secuencias de escape admitidas son:

|Secuencia|Descripción|
|---|---|
|\n|Nueva línea|
|\r|Retorno de carro|
|\t|Tabulador|
|\\\ |Diagonal invertida|
|\0|Valor `null`|
|\\"|Comillas|
|\xHH|Escape hexadecima. Agrega la secuencia hexadecimal `HH`|

### Cadenas hexadecimales

Las cadenas hexadecimales son literales de cadena entre comillas precedidas de una `x`, por ejemplo `x"48656C6C6F210A"`.

Cada par de bytes, de `00` a `FF`, se interpreta como un valor `u8` codificado en hexadecimal. Así, cada par de bytes corresponde a una única entrada en el `vector<u8>` resultante.

> :information_source: Recuerda que puedes encontrar más información sobre las cadenas y sus métodos en la [documentación oficial](https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/move-stdlib/doc/string.md) del Aptos Core.

## Leyendo los recursos del tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/cadenas.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

## Reto

* Crea una cadena con un poema de 4 líneas **en una sola variable**. Puedes usar el siguiente como ejemplo:
    ```
    Te vi un punto y, flotando ante mis ojos,
    la imagen de tus ojos se quedo,
    como la mancha oscura orlada en fuego
    que flota y ciega si se mira al sol.
    ```
    > :warning: Recuerda que el código de Move **no** puede tener acentos ni caractéres especiales.
* Ahora crea 4 variables, una por cada línea y concatenalas en una sola variable final.
* Imprime ambas variables.
* Responde: ¿Cuál de los dos métodos crees que es mejor y porqué?

> :information_source: Recuerda guardar tus cambios en el archivo para posteriormente hacerles `push` a tu repositorio de **Github**.