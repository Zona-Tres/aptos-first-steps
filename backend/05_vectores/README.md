# Vectores

Los vectores son una forma nativa de almacenar colecciones de elementos en Move. Son similares a las matrices de otros lenguajes de programación, pero con algunas diferencias.

`vector<T>` es el único tipo de colección primitiva que proporciona Move. Un `vector<T>` es una colección homogénea de `T`'s que puede crecer o decrecer haciendo `push`/`pop` a valores al final.

Un `vector<T>` puede ser instanciado con cualquier tipo `T`. Por ejemplo, `vector<u64>`, `vector<address>`, `vector<0x1337::mi_modulo::mi_recurso>`, y `vector<vector<u8>>` son todos tipos de vector válidos.

Puedes encontrar más información sobre los vectores y sus métodos en la [documentación oficial](https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/move-stdlib/doc/vector.md) del Aptos Core.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd backend/05_vectores
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Vectores
Running Move unit tests
[debug] 1
[debug] 3
[debug] 55
[debug] 40
[ PASS    ] 0x5a6f6e612054726573::vectores::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Tutorial

### Literales de un vector

|Sintaxis|Tipo|Descripción|
|---|---|---|
|`vector[]`|`vector[]: vector<T>` donde `T` es cualquier tipo, no referenciado.|Un vector vacío|
|`vector[e1, ..., en]`|`vector[e1, ..., en]: vector<T>` donde `e_i: T` tiene ` 0 < i <= n` y `n > 0`|Un vector con `n` elementos (de longitud `n`)|

En estos casos, el tipo del vector se infiere, ya sea a partir del tipo del elemento o del uso del vector. Si el tipo no puede deducirse, o simplemente para mayor claridad, el tipo puede especificarse explícitamente:

```rust
vector<T>[]: vector<T>
vector<T>[e1, ..., en]: vector<T>
```

### Operaciones

Estas son algunas de las operaciones más comunes utilizadas al trabajar con vectores:

|Función|Descripción|Aborta|
|---|---|---|
|`empty<T>(): vector<T>`|Crea un vector vacío que puede almacenar datos de tipo `T`|Nunca|
|`singleton<T>(t: T): vector<T>`|Crea un vector de longitud 1 que contiene `t`|Nunca
|`push_back<T>(v: &mut vector<T>, t: T)`|Agrega un elemento al final de `v`|Nunca|
|`pop_back<T>(v: &mut vector<T>): T`|Remueve y regresa el último elemento de `v`|Si v está vacío|
|`borrow<T>(v: &vector<T>, i: u64): &T`|Regresa una referencia inmutable al `T` en el índice `i`|Si `i` está fuera de límite|
|`borrow_mut<T>(v: &mut vector<T>, i: u64): &mut T`|Regresa una referencia mutable al `T` en el índice `i`|Si `i` está fuera de límite|
|`destroy_empty<T>(v: vector<T>)`|Elimina v|Si `v` no está vacío|
|`append<T>(v1: &mut vector<T>, v2: vector<T>)`|Agrega los elementos en `v2` al final de `v1`|Nunca|
|`contains<T>(v: &vector<T>, e: &T): bool`|Regresa `true` si `e` está en el vector `v`. Si no, regresa `false`|Nunca|
|`swap<T>(v: &mut vector<T>, i: u64, j: u64)`|Intercambia los elementos en los índices `i` y `j` en el vector `v`|Si `i` o `j` están fuera de límite|
|`reverse<T>(v: &mut vector<T>)`|Invierte el orden de los elementos en el vector `v`|Nunca|
|`index_of<T>(v: &vector<T>, e: &T): (bool, u64)`|Regresa `(true, i)` si `e` está en el vector `v` en el índice `i`. Si no, regresa `(false, 0)`|Nunca|
|`remove<T>(v: &mut vector<T>, i: u64): T`|Remueve el elemento en el índice `i` del vector `v`, recorriendo los demás elementos. Esta operación es `O(n)` y conserva el orden de los elementos.|Si `i` está fuera de límite|
|`swap_remove<T>(v: &mut vector<T>, i: u64): T`|Intercambia el elemento en el índice `i` del vector v con el último elemento y luego elimina el último elemento. Esta operación es `O(n)` pero no conserva el orden de los elementos en el vector.|Si `i` está fuera de límite|

> :information_source: Recuerda que puedes ver información sobre el resto de los métodos en la [documentación oficial](https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/move-stdlib/doc/vector.md) del Aptos Core.

## Leyendo los recursos del tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/vectores.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

## Reto

* Crea una matriz de 3x3 e inicializala con los valores que gustes.
* Imprime cada uno de estos elementos.

> :information_source: Recuerda guardar tus cambios en el archivo para posteriormente hacerles `push` a tu repositorio de **Github**.