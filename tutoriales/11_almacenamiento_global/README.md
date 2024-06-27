# Almacenamiento Global

En esta lección aprenderás a utilizar todas las operaciones del Global Storage, y comprenderás la seguridad y fiabilidad del manejo de recursos del lenguaje Move.

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/11_almacenamiento_global
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Almacenamiento Global
Running Move unit tests
Test result: OK. Total tests: 0; passed: 0; failed: 0
{
  "Result": "Success"
}
```

Normalmente aquí pararíamos... Pero para esta lección interactuaremos con la Blockchain de Aptos directamente por primera vez.

### Inicializando Aptos CLI
Vamos a inicializar este directorio para trabajar con la Blockchain. Primero, corre el siguiente comando en tu terminal:

```sh
aptos init
```

Recibirás el siguiente mensaje:
```
Configuring for profile default
Choose network from [devnet, testnet, mainnet, local, custom | defaults to devnet]
```

Para este tutorial vamos a usar la `devnet` (más información sobre la devnet en la sección **Tutorial**). Puedes escribirla o simplemente presiona `Enter`:
```
No network given, using devnet...
Enter your private key as a hex literal (0x...) [Current: None | No input: Generate new key (or keep one if present)]
```

De nuevo, por ahora solo presiona `Enter`. Deberías obtener algo similar a esto:
```
No key given, generating key...
Account 0xe0727f9554856401a427fe29f0ab0b27d39e79b7eb7b4081dd68f11426bb5eaf doesn't exist, creating it and funding it with 100000000 Octas
Account 0xe0727f9554856401a427fe29f0ab0b27d39e79b7eb7b4081dd68f11426bb5eaf funded successfully

---
Aptos CLI is now set up for account 0xe0727f9554856401a427fe29f0ab0b27d39e79b7eb7b4081dd68f11426bb5eaf as profile default!  Run `aptos --help` for more information about commands
{
  "Result": "Success"
}
```

La cuenta generada debería de ser diferente para ti.

Lo que acabamos de hacer es crear una nueva cuenta en la Blockchain. En este caso, estamos trabajando en la red de desarrollo `devnet`, por lo que lo que hagamos no tiene impacto en la Blockchain principal (o `mainnet`) y los tokens que utilicemos son ficticios, así que puedes experimentar sin preocpaciones.

### Fondeando la cuenta

Inicialmente la cuenta que creamos tiene algunos tokens ficticios, pero podemos agregar mas, o fondear la cuenta usando un faucet. Para ello corre el siguiente comando:

```sh
aptos account fund-with-faucet --account default
```

Recibirás algo similar a esto:
```
{
  "Result": "Added 100000000 Octas to account 0xe0727f9554856401a427fe29f0ab0b27d39e79b7eb7b4081dd68f11426bb5eaf"
}
```

Algo importante a notar aquí es que acabamos de fondear la cuenta `default`. Dado a que no especificamos algun perfil para la cuenta, se asigna al perfil por defecto, o `default`.

### Compilando el código

Ahora, compilemos el código. Para esto necesitas correr el siguiente comando:

```sh
aptos move compile --named-addresses cuenta=default
```

Tu terminal mostrará algo como esto:
```
Compiling, may take a little while to download git dependencies...
UPDATING GIT DEPENDENCY https://github.com/aptos-labs/aptos-core.git
UPDATING GIT DEPENDENCY https://github.com/aptos-labs/aptos-core.git
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Almacenamiento Global
{
  "Result": [
    "e0727f9554856401a427fe29f0ab0b27d39e79b7eb7b4081dd68f11426bb5eaf::almacenamiento_global"
  ]
}
```

En el archivo `Move.toml` puedes encontrar las siguientes propiedades:

```toml
[addresses]
cuenta = "_"
```

Y en el archivo `sources/almacenamiento_global.move` la direccion del modulo cambió a:

```move
module cuenta::almacenamiento_global {
    // ... resto del codigo ...
}
```
Todos estos cambios son para poder trabajar con la cuenta `default`. En el `Move.toml` dejamos el parametro de cuenta vacía, por lo que al correr el comando `aptos move compile` necesitamos decirle a que cuenta pretendemos publicar este paquete. Es por esto que se lo especificamos con el flag `--named-addresses cuenta=default`, indicándole que use la cuenta `default`, justo la que acabamos de crear.

### Publicando el paquete

Vamos a publicar este paquete, corre este comando:

```sh
Compiling, may take a little while to download git dependencies...
UPDATING GIT DEPENDENCY https://github.com/aptos-labs/aptos-core.git
UPDATING GIT DEPENDENCY https://github.com/aptos-labs/aptos-core.git
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Almacenamiento Global
package size 3038 bytes
Do you want to submit a transaction for a range of [212800 - 319200] Octas at a gas unit price of 100 Octas? [yes/no] >
```

En este momento, la consola te está pidiendo autorización para gastar `gas`, básicamente, usará tokens de tu cuenta para pagar por el cómputo y el almacenamiento necesario para publicar tu paquete. Escribe `yes` y presiona `Enter`. Ahora tendrás algo como esto:
```
{
  "Result": {
    "transaction_hash": "0x05014d5e16c78da4692b3cf3e4ae0f9f88ab29949b635b1178a898fca2e190ee",
    "gas_used": 2128,
    "gas_unit_price": 100,
    "sender": "e0727f9554856401a427fe29f0ab0b27d39e79b7eb7b4081dd68f11426bb5eaf",
    "sequence_number": 0,
    "success": true,
    "timestamp_us": 1719443012949647,
    "version": 78274391,
    "vm_status": "Executed successfully"
  }
}
```
Este mensaje nos indica que la publicación de nuestro paquete dentro de la red `devnet` en la blockchain de **Aptos** fue exitosa. ¡Felicidades! Acabas de publicar tu primer paquete a la blockchain.

Por ahora, lee algo de la teoría y el código, para después interactuar con el paquete que acabas de publicar.

## Tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/almacenamiento_global.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

### Operaciones

Los programas Move pueden crear, eliminar y actualizar recursos en el almacenamiento global utilizando las cinco instrucciones siguientes:

|Operación|Descripción|Aborta|
|---|---|---|
|`move_to<T>(&signer, T)`|Publica `T` en `signer.address`.|Si `signer.address` ya tiene un `T`.|
|`move_from<T>(address): T`|Remueve `T` de `address` y regresa su valor.|Si `address` no tiene un `T`.|
|`borrow_global<T>(address): &T`|Regresa una referencia inmutable al `T` almacenado en `address`.|Si `address` no tiene un `T`.|
|`borrow_global_mut<T>(address): &mut T`|Regresa una referencia mutable al `T` almacenado en `address`.|Si `address` no tiene un `T`.|
|`exists<T>(address): bool`|Regresa `true` si un `T` está almacenado en `address`. De lo contrario, regresa `false`.|Nunca.|

### Referencias a recursos

Las referencias a recursos globales devueltas por `borrow_global` o `borrow_global_mut` se comportan en su mayor parte como referencias a almacenamiento local: pueden leerse y escribirse utilizando operadores de referencia ordinarios y pasarse como argumentos a otra función. Sin embargo, existe una diferencia importante entre las referencias locales y las globales: **una función no puede devolver una referencia que apunte a un almacenamiento global**.

> :information_source: Recuerda que puedes encontrar más información sobre el Almacenamiento Global en la [documentación](https://move-language.github.io/move/global-storage-operators.html) oficial del lenguaje Move.

### Interactuando con el paquete publicado

> :information_source: Para seguir esta parte necesitas haber hecho los pasos descritos en la sección **Ejecutando el tutorial**.

Una vez preparado y publicado tu paquete, vamos a interactuar con él.

### `publicar`

Para usar la primer función de nuestro código, puedes correr:

```sh
aptos move run --function-id 'default::almacenamiento_global::publicar' --args u64:1
```

En este comando, estamos ejecutando con `run` la función `<cuenta>::<modulo>::<funcion>` y enviando los argumentos que requiere `--args <tipo>:<valor>`.
Deberías obtener algo como esto:

```
Do you want to submit a transaction for a range of [44600 - 66900] Octas at a gas unit price of 100 Octas? [yes/no] >
```

Dado a que vamos a escribir a la blockchain, es necesario pagar por el cómputo y el almacenamiento de esta transacción. Escribe `yes` y presiona `Enter`. La terminal mostrará algo similar:
```
{
  "Result": {
    "transaction_hash": "0x23921cc4c3c3cf475101261915f0823a4da5c0c5b6e8cd1c0a0a99d5c22b21f1",
    "gas_used": 446,
    "gas_unit_price": 100,
    "sender": "d81c7c2bcbb7055e254a20ff50099cd7609d070400e848f14b038072c89e5e8d",
    "sequence_number": 1,
    "success": true,
    "timestamp_us": 1719443577263826,
    "version": 78374805,
    "vm_status": "Executed successfully"
  }
}
```

¡Listo! Acabas de ejecutar exitosamente tu primera transacción usando un paquete Move.

### Métodos de vista

Vamos a correr el método `obtener_contador`:

```sh
aptos move view --function-id 'default::almacenamiento_global::obtener_contador' --args address:0x9ec76cffd7571d19a3abfe8f9721484eb7309fa55bd99722c60f94f5d70c2119
```

> :information_source: Recuerda sustituir el `address` con tu propia `address`. Si no sabes cual es, puedes verla corriendo:
>```sh
>aptos account lookup-address
>```

Deberías obtener algo como esto:
```
9a3abfe8f9721484eb7309fa55bd99722c60f94f5d70c2119
{
  "Result": [
    "1"
  ]
}
```

Lo cual es correcto, el valor que inicializamos fue `1`.

> :warning: Recuerda que estamos corriendo `aptos move view`. Nótese el `view`. Si corres una función de vista usando `aptos move run` obtendrás un error como el siguiente:
>```
>{
>  "Error": "Simulation failed with status: INVALID_MAIN_FUNCTION_SIGNATURE"
>}
>```

### Probando el resto de los métodos

Puedes probar el programa y ver el funcionamiento del mismo, los comandos son:

`incrementar`
```sh
aptos move run --function-id 'default::almacenamiento_global::incrementar' --args address:<tu_direccion>
```

`restablecer`
```sh
aptos move run --function-id 'default::almacenamiento_global::restablecer'
```

`existe`
```sh
aptos move view --function-id 'default::almacenamiento_global::existe' --args address:<tu_direccion>
```

`eliminar`
```sh
aptos move run --function-id 'default::almacenamiento_global::eliminar'
```

## Reto

En base al ejemplo del contador, modifica el struct para almacenar más campos
* Los nuevos campos pueden ser del tipo que quieras, ¡experimenta!.
* Al menos 3 campos.
* Cada uno de los campos debe tener al menos una función para modificarlo.
* No es necesario dejar los comentarios de la documentación, ya que estos toman mucho espacio.

> :information_source: Recuerda guardar tus cambios en el archivo para posteriormente hacerles `push` a tu repositorio de **Github**.