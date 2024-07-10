# Agenda

En este ejemplo utilizaremos todo lo que hemos aprendido hasta ahora y lo combinaremos en un programa completamente ejecutable.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/13_agenda
>```

Ingresa a tu terminal y ejecuta los siguientes comandos:

```sh
aptos move test --named-addresses cuenta=0x5A6F6E612054726573
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Agenda
Running Move unit tests
Test result: OK. Total tests: 0; passed: 0; failed: 0
{
  "Result": "Success"
}
```

### Inicializando el proyecto para trabajar con la Aptos CLI

> :information_source: Los pasos para la inicialización se explicaron con detalle en la lección [11_almacenamiento_global](https://github.com/Zona-Tres/aptos-first-steps/tree/master/tutoriales/11_almacenamiento_global).

Ejecuta:

```sh
aptos init --network devnet
```

Obtendrás una pantalla como la siguiente:

```
Configuring for profile default
Configuring for network Devnet
Enter your private key as a hex literal (0x...) [Current: Redacted | No input: Generate new key (or keep one if present)]
```

Simplemente presiona `Enter`.

Recuerda que puedes agregar más tokens si así lo requieres:
```sh
aptos account fund-with-faucet --account default
```

### Compilando y publicando el código

```sh
aptos move compile --named-addresses cuenta=default
aptos move publish --named-addresses cuenta=default
```

### Ejecutando las funciones

> :information_source: Vamos a estar utilizando el flag `assume-yes` para evitar tener que confirmar cada transacción.

* Inicializar contrato:
    * Crea una nueva `Agenda` si no existe y la almacena en la cuenta del firmante
    ```sh
    aptos move run --function-id 'default::agenda::inicializar' --assume-yes
    ```
* Agregar `Registro`:
    * Agrega un `Registro` a una `Agenda` existente.
    ```sh
    aptos move run --function-id 'default::agenda::agregar_registro' --args 'String:Juan' u64:4444444444 'String:juan_ito' 'String:juan_ito@gmail.com' address:0xFE00 --assume-yes
    ```
* Obtener `Registro`:
    * Obtiene el `Registro` relacionado con el `Nombre` dado.
    ```sh
    aptos move view --function-id 'default::agenda::obtener_registro' --args address:default 'String:Juan'
    ```
* Modificar `telefono`:
    * Modifica el `telefono` del `Registro` relacionado con el `Nombre` dado.
    ```sh
    aptos move run --function-id 'default::agenda::modificar_telefono' --args 'String:Juan' u64:4444444445 --assume-yes
    ```
* Modificar `discord`:
    * Modifica el `discord` del `Registro` relacionado con el `Nombre` dado.
    ```sh
    aptos move run --function-id 'default::agenda::modificar_discord' --args 'String:Juan' 'String:juan_john' --assume-yes
    ```
* Modificar `correo`:
    * Modifica el `correo` del `Registro` relacionado con el `Nombre` dado.
    ```sh
    aptos move run --function-id 'default::agenda::modificar_correo' --args 'String:Juan' 'String:juan_john@gmail.com' --assume-yes
    ```
* Modificar `direccion`:
    * Modifica la `direccion` del `Registro` relacionado con el `Nombre` dado.
    ```sh
    aptos move run --function-id 'default::agenda::modificar_direccion' --args 'String:Juan' address:0xBEBE --assume-yes
    ```
* Modificar `nombre`:
    * Modifica el `Nombre` con el que esta guardado un `Registro`.
    ```sh
    aptos move run --function-id 'default::agenda::modificar_nombre' --args 'String:Juan' 'String:John' --assume-yes
    ```

Puedes comprobar que todos los cambios funcionaron ejecutando la función de vista `obtener_registro`. Recuerda que cambiamos el nombre, por lo que el comando ahora luciría así:
```sh
aptos move view --function-id 'default::agenda::obtener_registro' --args address:default 'String:John'
```

### Probando en el Explorador

Notarás que el ejemplo tiene una función más que no probamos: `modificar_registro`. Esta función no puede ser ejecutada en la terminal, dado a que la CLI no soporta valores opcionales de momento.

Pero puedes probar la función utilizando el [Explorador de Transacciones](https://explorer.aptoslabs.com/).

Dejé una cuenta con este contrato ya desplegado, puedes conectar tu wallet y probarla [aquí](https://explorer.aptoslabs.com/account/0x8a5c141aec1a4d3c5ef8b50f5c2c2f777f13c404f51cf3e8ba9ce66a46e9d772/modules/run/agenda/inicializar?network=testnet).

Puedes probar todas las funciones, pero en el caso en particular de `modificar_registro` es una funcion, que, en vez de tener multiples funciones para modificar cada campo, podemos tener una sola que dependiendo de que valores enviamos y cuales no. Al ejecutarla en el explorador, simplemente deja vacíos los campos que no quieres modificar del registro.