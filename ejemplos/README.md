# Ejemplos

En este directorio encontrarás los ejemplos completos y sin comentarios utilizados en los distintos tutoriales del repositorio.

Además, se irán agregando distintos ejemplos que puedes utilizar como guía para tu certificación en el programa **Aptos Backend Expert** ó agregarles un frontend para el programa **Aptos Frontend Expert**.

## Corriendo los ejemplos

Cada ejemplo tiene su propia documentación, además puedes encontrar instrucciones más detadas para el despliegue en la lección [11 Almacenamiento Global](https://github.com/Zona-Tres/aptos-first-steps/tree/master/tutoriales/11_almacenamiento_global).

En terminos generales necesitas:

* [Instalar la Aptos CLI](https://github.com/Zona-Tres/aptos-first-steps/)
* Clonar el repositorio y navegar al directorio del proyecto.
    ```sh
    ## Por ejemplo
    cd ejemplos/01_contador
    ```
* Inicializar el proyecto para poder interactuar con la Blockchain de Aptos/
    ```sh
    aptos init
    ```
* Compilar el proyecto.
    ```sh
    aptos move compile --named-addresses cuenta=default
    ```
* Desplegar el proyecto.
    ```sh
    aptos move publish --named-addresses cuenta=default
    ```
* Interactuar con el contrato.
    * Utilizando la [Aptos CLI](https://github.com/Zona-Tres/aptos-first-steps/tree/master/tutoriales/11_almacenamiento_global).
    * Utilizando el [Aptos Explorer](https://explorer.aptoslabs.com/).

> :information_source: Recuerda que puedes encontrar más información sobre estos programas de ceritfiación en el Discord de [Zona Tres](https://discord.gg/zonatres).