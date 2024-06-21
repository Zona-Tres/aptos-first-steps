# Tipos primitivos

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/03_tipos_primitivos
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Tipos primitivos
Running Move unit tests
[debug] 1
[debug] 2
[debug] 3
[debug] 1123456
[debug] 51966
[debug] 3200187904
[debug] true
[debug] false
[debug] true
[debug] false
[ PASS    ] 0x5a6f6e612054726573::tipos_primitivos::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Tutorial

### Enteros (Integers)

Move admite seis tipos de enteros sin signo: `u8`, `u16`, `u32`, `u64`, `u128` y `u256`. Los valores de estos tipos van de 0 a un máximo que depende del tamaño del tipo.

|Tipo|Rango de valor|
|---|---|
| Entero de 8-bits sin signo, `u8` | 0 a 2<sup>8</sup> -1 |
| Entero de 16-bits sin signo, `u16` | 0 a 2<sup>16</sup> -1 |
| Entero de 32-bits sin signo, `u32` | 0 a 2<sup>32</sup> -1 |
| Entero de 64-bits sin signo, `u64` | 0 a 2<sup>64</sup> -1 |
| Entero de 128-bits sin signo, `u128` | 0 a 2<sup>128</sup> -1 |
| Entero de 256-bits sin signo, `u256` | 0 a 2<sup>256</sup> -1 |

### Valores literales (literals)

Los valores literales para estos tipos se especifican como una secuencia de dígitos (por ejemplo, `123`) o como literales hexadecimales, por ejemplo, `0xAA`. El tipo del literal puede añadirse opcionalmente como sufijo, por ejemplo, `123u8`. Si no se especifica el tipo, el compilador intentará deducirlo del contexto en el que se utiliza el literal. Si no se puede deducir el tipo, se asume que es `u64`.

Los literales numéricos pueden separarse mediante guiones bajos para agruparlos y facilitar su lectura. (por ejemplo,`1_234_5678`, `1_000u128`, `0xAB_CD_12_35`).

Si un literal es demasiado grande para su rango de tamaño especificado (o inferido), se obtiene un error.

### Operaciones aritméticas

Para todas estas operaciones, ambos argumentos (los operandos izquierdo y derecho) deben ser del mismo tipo. Si necesita operar enteros de distintos tipos, tendrá que convertir uno de ellos primero.

Todas las operaciones aritméticas abortan en lugar de comportarse como no lo harían los enteros matemáticos (por ejemplo, desbordamiento, subdesbordamiento, división por cero).

|Sintaxis|Operación|Aborta si...|
|---|---|---|
|+| Suma | El resultado es muy grande para el tipo de dato. |
|-| Resta | El resultado es menor a `0` |
|*| Multiplicación | El resultado es muy grande para el tipo de dato. |
|/| División | El divisor es `0` |
|%| Módulo | El divisor es `0` |

### Comparaciones

Los tipos enteros son los *únicos* tipos en Move que pueden utilizar los operadores de comparación. Ambos argumentos deben ser del mismo tipo. Si necesita comparar enteros de distintos tipos, tendrá que convertir uno de ellos primero.

|Sintaxis|Operación|
|---|---|
|<| Menor que |
|>| Mayor que |
|<=| Menor o igual que |
|>=| Mayor o igual que |

### Igualdades

Ambos argumentos deben ser del mismo tipo. Si necesita comparar enteros de distintos tipos, tendrá que convertir uno de ellos primero.

|Sintaxis|Operación|
|---|---|
|==| Igual|
|!=| No igual|

### Conversión (Cast)

Los tipos enteros de un tamaño pueden convertirse en tipos enteros de otro tamaño. Los enteros son los *únicos* tipos de Move que admiten la conversión.

Los lanzamientos no truncan. La conversión abortará si el resultado es demasiado grande para el tipo especificado.

|Sintaxis|Operación|Aborta si...|
|---|---|---|
|`(e as T)`| Convierte la expresión entera `e` en un entero de tipo `T`| `e` es muy grande como para ser representado como `T`|

### Bool

`bool` es el tipo primitivo de Move para valores booleanos verdadero y falso. Los literales para bool son `true` o `false`. `bool` admite tres operaciones lógicas:

|Sintaxis|Descripción|Expresión equivalente|
|---|---|---|
|`&&`|Comparación lógica **and**.|`p && q` es equivalente a `if (p) q else false`|
|`\|\|`|Comparación lógica **or**.|`p \|\| q` es equivalente a `if (p) true else q`|
|`!`|Negación lógica|`!p` es equivalente a `(p) false else true`|

## Leyendo los recursos del tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/tipos_primitivos.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

## Reto

* Declara 1 valor entero **constante** con cualquier valor que quieras.
* Declara 1 variable entera con cualquier valor que quieras.
* Imprime ambos números.
* Declara una variable que compare si estos números son iguales.
* Declara una variable que compare si el 1er número es mayor que el segundo.
* Declara una variable que compare si las 2 comparaciones anteriores son verdaderas.
* Imprime el resultado de esta ultima variable.

> :information_source: Recuerda guardar tus cambios en el archivo para posteriormente hacerles `push` a tu repositorio de **Github**.