// Para estudiar el funcionamiento del Global Storage vamos a hacer un programa completo.
// Integraremos la mayoria de las cosas que se han visto hasta ahora , por lo que es necesario que no hayas saltado los temas anteriores. 
// El modulo es simplemente un contador. Almacenaremos un numero entero y tendremos una funcion para incrementarlo.
module cuenta::almacenamiento_global {
    use std::signer; // Global Storage trabaja sobre el signer y address como vimos anteriormente.

    struct Contador has key { valor: u64 } // Creamos un tipo personalizado llamado Contador para almacenar un valor dentro de nuestro contador.
    // Dado a que va a ser utilizado para operaciones con el global storage es necesario que tenga la habilidad key.

    // Publica un recurso `Contador` con valor `valor` en la cuenta proporcionada.
    public entry fun publicar(cuenta: &signer, valor: u64) { // La funcion recibe 2 parametros, pero en realidad al ejecutarla, solo enviaremos 1.
    // El signer es recibido automaticamente.

        let recurso = Contador { valor }; // Vamos a crear un recurso. No es mas que un struct.
        // Este recurso puede ser almacenado dentro de la blockchain utilizando el global storage.

        // Para almacenarlo en el global storage usamos move_to. Dato curioso: Esta es la razon por la que Move se llama de esta manera.
        // A la persona que invoco este metodo, es decir, a quien firmo esta transaccion, se le creara un recurso en el almacenamiento global de tipo Contador:
        move_to(cuenta, recurso) // A esta accion se le llama empaquetar, o pack. Nota la omision del ; Porque es esto?
        // Esta operacion solo se puede hacer dentro de los modulos que declaren el recurso Contador
        // Muy importante, nota que estamos mandando el parametro cuenta, es decir el signer. Esta operacion requiere el signer.
    }

    // Lee el valor del recurso `Contador` almacenado en la `direccion`
    // Varias cosas pasan aqui: 
    // 1. Como vamos a obtener un recurso, es necesario qe se especifique que la funcion va a adquirir ese recurso, para que el compilador le autorize.
    // Esto se hace con la palabra `aquires`
    // 2. Usualmente, este es un metodo de vista. Dado a que solo vamos a ver el valor que tiene almacenado el recurso.
    // En estos casos NO se utiliza signer, sino que debemos de mandar el `address` como un parametro al momento de ejecutar la funcion.
    #[view] // Podemos especificar que es un metodo de vista
    public fun obtener_contador(direccion: address): u64 acquires Contador {
        // Usamos borrow_global para obtener ese recurso.
        borrow_global<Contador>(direccion).valor // Recuerda que el recurso es simplemente un struct, por lo que podemos acceder a sus campos con .
        // Nota que esta operacion es una referencia inmutable. Tambien a diferencia de la operacion de publicar y move_to, aca usamos la address.
    }

    // Incrementa el valor del recurso `Contador` que pertenece a `direccion`
    // Nota que estamos usando address. Esencialmente cualquiera puede aumentar el Contador de cualquier direccion mientras conozcas esa direccion.
    public entry fun incrementar(direccion: address) acquires Contador { // aquires dado a que vamos a adquirir ese recurso
        // Vamos a obtener una referencia mutable al valor del contador
        // Para esto usamos la operacion borrow_global_mut, le indicamos el tipo del recurso que vamos a recibir, osea Contador
        let referencia_contador = &mut borrow_global_mut<Contador>(direccion).valor; // Y accedemos a su campo valor usando .
        *referencia_contador = *referencia_contador + 1 // Y como es mutable, podemos modificar su valor directamente usando dereferenciacion.
    }

    // Restablece el valor del recurso `Contador` de la `cuenta` a 0
    // Aca usamos signer en vez de address. Es decir, que solo la persona que firme la transaccion puede reestablecer su contador.
    public entry fun restablecer(cuenta: &signer) acquires Contador { // aquires dado a que vamos a adquirir ese recurso
        // Recibimos signer como parametro, pero recordemos que borrow_global y borrow_global_mute requieren un address ...
        let referencia_contador = &mut borrow_global_mut<Contador>(signer::address_of(cuenta)).valor; // Por lo que convertimos usando la operacion address_of
        *referencia_contador = 0
    }

    // Podemos validar si una `address` ya tiene un recurso del tipo Contador almacenado en global storage.
    #[view] // Solo estamos validando algo, asi que podemos usarlo como view
    public fun existe(direccion: address): bool { // No estamos adquiriendo el recurso, solo estamos verificando si existe o no
        exists<Contador>(direccion) // Usamos la operacion exists, la cual retorna true o falso dependiendo si el recurso existe o no en la cuenta dada.
        // Como exists regresa un bool podemos regresar ese valor directamente.
    }

    // Elimina el recurso `Contador` bajo la `cuenta` y regresa su valor
    // Estamos usando signer como parametro, es decir, que solo puedes borrar el recurso de tu cuenta si llamas a este metodo.
    public entry fun eliminar(cuenta: &signer) acquires Contador { // aquires dado a que vamos a adquirir ese recurso
        // move_from basicamente saca el recurso del global storage. 
        // Una vez que hagamos esto, el recurso ya no estara en el global storage a menos que lo regresemos.
        let contador = move_from<Contador>(signer::address_of(cuenta)); // Como usamos signer, hay que convertirlo en address.
        // Ahora, ya adquirimos el recurso, ya esta fuera del global storage y lo tenemos almacenado en la variable contador
        // Como podemos deshacernos de el? No podemos simplemente ignorarlo porque no tiene drop...
        let Contador { valor: _ } = contador; // Recuerda la desestructuracion de structs.
        // y podemos parar, dado a que u64 tiene drop y lo podemos ignorar.
    }

    // Y donde estan los print?
    // Ahora entiendes porque Move se llama Move?
}
