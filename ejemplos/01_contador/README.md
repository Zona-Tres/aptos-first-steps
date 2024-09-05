# Ejemplos: Contador

Este ejemplo es la versión sin comentarios del código usado en la lección [11 Almacenamiento Global](https://github.com/Zona-Tres/aptos-first-steps/tree/master/tutoriales/11_almacenamiento_global).

## Desplegando el contrato

* [Instalar la Aptos CLI](https://github.com/Zona-Tres/aptos-first-steps/)
* Clonar el repositorio y navegar al directorio del proyecto.
    ```sh
    cd ejemplos/01_contador
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

* **`publicar`**
    ```sh
    aptos move run --function-id 'default::contador::publicar' --args u64:1
    ```
* **`obtener_contador`**
    ```sh
    aptos move view --function-id 'default::contador::obtener_contador' --args address:0x9ec76cffd7571d19a3abfe8f9721484eb7309fa55bd99722c60f94f5d70c2119
    ```

    > :information_source: Recuerda sustituir el `address` con tu propia `address`. Si no sabes cual es, puedes verla corriendo:
    >```sh
    >aptos account lookup-address
    >```
* **`incrementar`**
    ```sh
    aptos move run --function-id 'default::contador::incrementar' --args address:<tu_direccion>
    ```
* **`restablecer`**
    ```sh
    aptos move run --function-id 'default::contador::restablecer'
    ```
* **`existe`**
    ```sh
    aptos move view --function-id 'default::contador::existe' --args address:<tu_direccion>
    ```
* **`eliminar`**
    ```sh
    aptos move run --function-id 'default::contador::eliminar'
    ```