# Address

Antes de aprender que es el **almacenamiento global** es necesario entender el tipo `address`. Hasta ahora, hemos estado solamente usando el lenguaje **Move** y ejecutando funciones de manera local, pero no hay que olvidar que el punto es usarlo en conjunto con la blockchain de **Aptos**.

`address` es un identificador único de una ubicación en la blockchain. Se utiliza para identificar paquetes, cuentas y objetos. Una `address` tiene un tamaño fijo de 32 bytes y suele representarse como una cadena hexadecimal con el prefijo `0x`. Las direcciones no distinguen entre mayúsculas y minúsculas.

```
0xe51ff5cd221a81c3d6e22b9e670ddf99004d71de4f769b0312b68c7c4872e2f1
```

La dirección anterior es un ejemplo de `address` válida. Tiene 64 caracteres (32 bytes) y el prefijo `0x`.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/09_address
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh

```

## Tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/address.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

### Sintaxis

Las direcciones pueden ser numéricas o con nombre. La sintaxis de una `address` con nombre sigue las mismas reglas que cualquier identificador con nombre en **Move**. La sintaxis de una dirección numérica no está restringida a valores codificados hexadecimales, y cualquier valor numérico `u128` válido puede utilizarse como valor de dirección, por ejemplo, `42`, `0xBEBE` y `2024` son todos literales de dirección numérica válidos.

Para distinguir cuando una dirección se utiliza en un contexto de expresión o no, la sintaxis al utilizar una dirección difiere dependiendo del contexto en el que se utilice:

* Cuando una dirección se utiliza como expresión, debe ir precedida del carácter `@`, es decir, `@<valor_numerico>` o `@<identificador_direccion_nombrada>`.
* Fuera de los contextos de expresión, la dirección puede escribirse sin el carácter `@` inicial, es decir, `<valor_numerico>` o `<identificador_direccion_nombrada>`.

### Direcciones nombradas

Las direcciones nombradas son una característica que permite utilizar identificadores en lugar de valores numéricos en cualquier lugar donde se utilicen direcciones, y no sólo a nivel de valor. Las direcciones nombradas se declaran y vinculan como elementos de nivel superior (fuera de módulos y scripts) en los paquetes Move, o se pasan como argumentos al compilador Move.

Las direcciones nombradas sólo existen en el nivel de lenguaje fuente y serán sustituidas completamente por su valor en el nivel de código de bytes. Debido a esto, se debe acceder a los módulos y a los miembros de los módulos __a través de la dirección nombradas del módulo y no a través del valor numérico__ asignado a la dirección nombradas durante la compilación, por ejemplo, usar `mi_direccion::foo` no es equivalente a usar `0x2::foo` incluso si el programa Move se compila con `mi_direccion` establecida en `0x2`.

### Operaciones de Almacenamiento Global

El propósito principal de las `address` es interactuar con las operaciones de **almacenamiento global**. Las `address` se utilizan con las operaciones `exists`, `borrow_global`, `borrow_global_mut` y `move_from`.

La única operación de **almacenamiento global** que no utiliza dirección es `move_to`, que `utiliza signer`.

### Signer

`signer` es un tipo de recurso en Move. Un `signer` permite al titular **actuar** en nombre de una dirección determinada. Move puede crear cualquier valor de dirección sin ningun permiso especial utilizando literales de `address`:

```move
let a1 = 0x1;
let a2 = 0x2;
// ...
```

Sin embargo, `signer` es especial porque no puedes crearlo usando literales o instrucciones. Sólo pueden ser creadas por la **MoveVM**.

Una función puede tener un número arbitrario de `signer` siempre que los `signers` estén antes de cualquier otro argumento. En otras palabras, todos los argumentos del `signer` deben ir primero:

```move
use std::signer;
fun main(s1: signer, s2: signer, x: u64, y: u8) {
    // ...
}
```

### Operaciones de `signer`

El módulo `std::signer` de la librería estándar proporciona dos funciones sobre los valores de `signer`:

|Función|Descripción|
|---|---|
|`address_of(&signer): address`|Regresa la `address` envuelta en el `signer`.|
|`borrow_address(&signer): &address`|Regresa una referencia a la `address` envuelta en el `signer`.|

## Reto

Simplemente lee la documentación y asegúrate de entenderla.