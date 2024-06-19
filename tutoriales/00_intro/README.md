# Introducción

## Módulos y Scripts

**Move** tiene dos tipos diferentes de programas: Módulos y Scripts. 

Los módulos son librerías que definen structs (`struct`) junto con funciones (`fun`) que operan sobre estos. Los structs definen el esquema del `global storage` de **Move**, y las funciones de los módulos definen las reglas para actualizar el almacenamiento. Los propios módulos también se guardan en el `global storage`. 

Los scripts son puntos de entrada ejecutables similares a una función `main` en un lenguaje convencional. Un script suele llamar a funciones de un módulo publicado que realizan actualizaciones del `global storage`. Los scripts son fragmentos de código efímeros que no se publican en el `global storage`.

Un archivo **Move** (o unidad de compilación) puede contener múltiples módulos y scripts. Sin embargo, publicar un módulo o ejecutar un script son operaciones VM independientes.

Módulo:
* Contiene funciones y tipos.

Script:
* Ejecuta funciones de un Módulo.

En los siguientes tutoriales trabajaremos **sólo con módulos**.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/00_intro
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Intro
Running Move unit tests
[debug] "Hello, World!"
[ PASS    ] 0x1337::practica_aptos::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

¡Felicidades! :partying_face: Acabas de ejecutar de manera exitosa tu primer módulo Move. Ahora, analicemos que está pasando.

En la carpeta `sources` podemos encontrar un archivo llamado `introduccion.move`. Este archivo, como lo indica la extensión, contiene el código de Move que estamos ejecutando. En este caso, es un **módulo** con una **función** y un **test**.

## Estructura de un módulo

La estructura de un **módulo** es la siguiente:

```rust
module direccion::nombre_modulo {
    // ...  resto del código
}
```

1. Declaración del módulo con la palabra clave `module`.
2. Dirección en la que se desplegará el módulo.
    La dirección la encontramos en el archivo de configuraciones `Move.toml`, en el apartado de `addresses`. En nuestro caso:
    ```toml
    [addresses]
    introduccion = "0x1337"
    ```
3. Nombre del módulo, en nuestro caso: `practica_aptos`

Por lo que nuestro código luce así:
```rust
module introduccion::practica_aptos {
    // ...  resto del código
}
```

Después, vienen los `imports` o los módulos/librerías que estamos importando para que el nuestro funcione. En nuestro código, estamos importando dos funciones de la librería principal de **Aptos**:

```rust
    use std::debug::print;
    use std::string::utf8;
```

Se importa la función para imprimir en consola, así como una función para convertir cadenas de texto a un formato aceptado por la función anterior. Esto lo veremos más adelante en esta serie de tutoriales.

La siguiente sección de código incluye nuestra primera función:

```rust
    fun practica() {
        print(&utf8(b"Hello, World!"));
    }
```

En ella, hacemos uso de ambas librerías importadas. La función simplemente imprime la cadena `Hello, World!` en la consola.

Y por último, necesitamos una forma de ejecutar esta función. Por ahora lo estamos haciendo a través de un **bloque de pruebas** o `test`:

```rust
    #[test]
    fun prueba() {
        practica();
    }
```

Al nosotros haber ejecutado `aptos move test` le estamos diciendo a la CLI que ejecute todas las funciones que tengan un bloque `[#test]`, en este caso, ejecuta nuestra función `prueba`, la cual a su vez llama a la función `practica`.

## Output

Por último, analicemos el resultado que se imprimió en la consola.

```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Intro
Running Move unit tests
[debug] "Hello, World!"
[ PASS    ] 0x1337::practica_aptos::prueba
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

El primer bloque de texto nos indica que está incluyendo las dependencias necesarias para ejecutar el proyecto:

```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Intro
```

Estas dependencias las podemos ver en el archivo `Move.toml`:
```toml
[dependencies.AptosStdlib]
git = 'https://github.com/aptos-labs/aptos-core.git'
rev = 'main'
subdir = 'aptos-move/framework/aptos-stdlib'

[dependencies.MoveStdlib]
git = 'https://github.com/aptos-labs/aptos-core.git'
rev = 'main'
subdir = 'aptos-move/framework/move-stdlib'
```

Cada una de estas dependencias está siendo importada de un repositorio de **Github**, en este caso, el repositorio oficial del **Aptos Core**.

> :information_source: Puedes ver el repositorio oficial aquí: [Aptos Core](https://github.com/aptos-labs/aptos-core).

La siguiente línea en el output nos indica que se ejecutaran las pruebas unitarias en el archivo, recuerda que esto es porque corrimos el comando `aptos move test`:
```
Running Move unit tests
```

Después, obtenemos el mensaje que ejecuta la función prueba, en nuestro caso, la línea de texto `Hello, World!`:
```sh
[debug] "Hello, World!"
```

Ahora, en la siguiente línea, podemos obtener información de exactamente que funciones se ejecutaron:
```sh
[ PASS    ] 0x1337::practica_aptos::prueba
```
La estructura es algo así:
```rust
direccion::nombre_modulo::funcion
```
Con esto, podemos comprobar que la función que se ejecutó fue `prueba`.

Por último, obtenemos información sobre las pruebas unitarias, cómo cuantas se ejecutaron y cuantas se pasaron:

```sh
Test result: OK. Total tests: 1; passed: 1; failed: 0
{
  "Result": "Success"
}
```

## Reto final

Cómo reto final, modifica la función para que, en vez de mostrar `Hello, World!`, imprima el logo de **Aptos** en arte ASCII:
```ASCII
MMMMMMMMMMMMMMMMWKkdc;'..          ..';cdkKWMMMMMMMMMMMMMMMM
MMMMMMMMMMMMWXkl,.                        .,lkXWMMMMMMMMMMMM
MMMMMMMMMMXk:.                                .ckXMMMMMMMMMM
MMMMMMMWKo'                               ...    'oKWMMMMMMM
MMMMMMXo.                               .:OX0l.    .oXMMMMMM
MMMMMNd;;;,;;,,,,,,,,,,,,,,,,,,,;;;,,,;lOWMMMW0l;,;;:dXMMMMM
MMMMMWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWMMMMMMMMMWWWWWWWMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNKXWMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx,.'oXMMMMMMMMMMMMMMMMMMMM
N0kkkkkkkkkkkkkkkkkkkkkkkkkkkkkko,     'okkkkkkkkkkkkkkkkk0N
x.                                                        .x
;                              .;;.                        ;
.                           .cx0WW0c.                      .
olllllllllllllllllllllllllld0WMMMMMW0olllllllllllllllllllllo
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMXkkXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMXd'  'xXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
koollloolllllllllollc'      'clllllllllllllllllllllllllllllx
l                                                          c
0'                 .cl;                                   '0
Wx.              .oKWMNk,                                .xW
MW0xxxxxxxxxxxxxkXWMMMMMNOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk0WM
MMMMMMMMMMMMWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMXd;,l0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMWKd,    .lOKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKXWMMMMMMM
MMMMMMMNx'        ................................;kNMMMMMMM
MMMMMMMMWKd,.                                  .,dKWMMMMMMMM
MMMMMMMMMMMN0o,.                            .,o0NMMMMMMMMMMM
MMMMMMMMMMMMMMWKxl;..                  ..;lxKWMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMWKko:'.          .';okKWMMMMMMMMMMMMMMMMMM
```
