# Ejemplos: Contador

Este ejemplo es la versión sin comentarios del código usado en la lección [13 Agenda](https://github.com/Zona-Tres/aptos-first-steps/tree/master/tutoriales/13_agenda).

## Desplegando el contrato

* [Instalar la Aptos CLI](https://github.com/Zona-Tres/aptos-first-steps/)
* Clonar el repositorio y navegar al directorio del proyecto.
    ```sh
    cd ejemplos/02_agenda
    ```
* Inicializar el proyecto para poder interactuar con la Blockchain de Aptos/
    ```sh
    aptos init
    ```
* Fondear tu cuenta (opcional).
    ```sh
    aptos account fund-with-faucet --account default
    ```
* Compilar el proyecto.
    ```sh
    aptos move compile --named-addresses cuenta=default
    ```
* Desplegar el proyecto.
    ```sh
    aptos move publish --named-addresses cuenta=default
    ```

## Interactuando con el contrato

Los métodos son:

* **`inicializar`**
    ```sh
    aptos move run --function-id 'default::agenda::inicializar'
    ```
* **`agregar_registro`**
    ```sh
    aptos move run --function-id 'default::agenda::agregar_registro' --args 'String:Juan' u64:4444444444 'String:juan_ito' 'String:juan_ito@gmail.com' address:0xFE00 --assume-yes
    ```
* **`obtener_registro`**
    ```sh
    aptos move view --function-id 'default::agenda::obtener_registro' --args address:default 'String:Juan'
    ```
* **`modificar_telefono`**
    ```sh
    aptos move run --function-id 'default::agenda::modificar_telefono' --args 'String:Juan' u64:4444444445
    ```
* **`modificar_discord`**
    ```sh
    aptos move run --function-id 'default::agenda::modificar_discord' --args 'String:Juan' 'String:juan_john' --assume-yes
    ```
* **`modificar_correo`**
    ```sh
    aptos move run --function-id 'default::agenda::modificar_correo' --args 'String:Juan' 'String:juan_john@gmail.com' --assume-yes
    ```
* **`modificar_direccion`**
    ```sh
    aptos move run --function-id 'default::agenda::modificar_direccion' --args 'String:Juan' address:0xBEBE --assume-yes
    ```
* **`modificar_nombre`**
    ```sh
    aptos move run --function-id 'default::agenda::modificar_nombre' --args 'String:Juan' 'String:John' --assume-yes
    ```