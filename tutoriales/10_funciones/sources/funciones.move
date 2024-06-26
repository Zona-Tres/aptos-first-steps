address aptosz3 { // Ahora usamos una nueva sintaxis, ya que vamos a tener distintos modulos dentro la misma address.
    module funciones1 {
        use std::debug::print;
        use std::string::utf8;

        fun retorno(): u64 { // Las funciones pueden regresar algo, hasta ahora la mayoria de las funciones que usamos no regresaba nada.
            let a = 0u64;
            a // Para regresar algo, necesita ser la ultima linea en la expresion. Omitimos el ;
            // Esto es un retorno implicito
        }

        fun retorno_condicional(a: u64): bool { // Las funciones pueden incluir en el nombre: a a la z, A a la Z, _, digitos del 0 al 9.
            // El nombre de una funcion no puede tener _ al inicio, pero si despues del primer caracter.
            if (a > 0) {
                true
            } else {
                false
            } // Normalmente cerrariamos aqui, pero como el resultado del if lo vamos a regresar, no cerramos
        }

        public fun funcion_publica() { // Podemos declarar funciones publicas para ser llamadas desde otros modulos
            print(&utf8(b"Hola desde funciones1!"));
        }

        #[test]
        fun prueba() {
            retorno();
            let a = retorno_condicional(0); // Es importante notar que si vamos a regresar algo necesita ser consumido. A menos que tenga la habilida drop
            print(&a); // Resultado: [debug] false
        }
    }

    module funciones2 { // Nuevo modulo!
        use aptosz3::funciones1::{Self, funcion_publica}; // Usaremos este import para demostrar las distintas maneras de importar un modulo.

        fun llamada_externa() {
            // Podemos hacer llamado a funciones publicas:
            aptosz3::funciones1::funcion_publica(); // Esta forma de llamarla es cuando no importamos la funcion con use
            funciones1::funcion_publica(); // Esta forma es cuando importamos Self
            funcion_publica(); // Y por ultimo esta s cuando importamos la funcion directamente.
            // Las 3 llamadas son equivalentes, cual utilizar depende de tu caso de uso.
        }

        #[test]
        fun prueba() {
            llamada_externa(); // Resultado: [debug] "Hola desde funciones1!"
        }
    }

    module funciones3 {
        use std::debug::print;

        fun parametros(a: u64, b: u64) { // Las funciones pueden recibir parametros, cada uno separado por una coma y especificando el tipo esperado.
            print(&a); // Resultado: [debug] 1
            print(&b); // Resultado: [debug] 2
        }

        fun retorno_multiple(): (vector<u8>, u64) { // Las funciones pueden tener multiples retornos. Es necesario encerrarlos en parentesis.
            (b"Aptos", 0) // Lo mismo al regresarlos
        }

        fun retorno_explicito(): u8 { // Como vimos arriba, podemos omitir la palabra return si nuestro codigo evalua a un valor final
            return 100 // Aun asi, tambien podemos usar return si asi se requiere. Nota que tambien se omite ;
        }

        #[test_only] // Podemos importar modulos que se usaran solo en los tests con test_only
        use std::string::utf8; // Por ejemplo, este import solo lo usaremos abajo para imprimir el valor recibido, pero arriba no lo necesitamos.

        #[test]
        fun prueba() {
            let a = 1u64; // Los parametros tienen que ser del tipo esperado por la funcion.
            parametros(a, 2); // Al enviar parametros, recuerda separarlos con ,

            let (nombre, numero) = retorno_multiple(); // Al recibir una funcion con retorno multiple, asignamos nuevas variables para guardar cada valor.
            print(&utf8(nombre)); // Resultado: [debug] "Aptos"
            print(&numero); // Resultado: [debug] 0

            let retorno_explicito = retorno_explicito(); // Habia mencionado que las funciones y variables pueden tener el mismo nombre?
            print(&retorno_explicito); // Resultado: [debug] 100
        }
    }

    module funciones4 {
        public entry fun funcion_entry() { // Por ultimo, el modificador entry es escencialmente lo que seria el modificador main en otros lenguajes
            aptosz3::funciones1::funcion_publica(); // Son funciones que permiten que sean llamadas de manera segura e invocadas directamente.

            // No es un modificador restrictivo. Estas funciones pueden seguir siendo llamadas por otras funciones dentro del modulo.
        }

        #[test]
        fun prueba() {
            funcion_entry(); // Resultado: [debug] "Hola desde funciones1!"
        }

        // Recuerda que puedes ver mas informacion sobre las funciones y sus declaraciones en la documentacion oficial del lenguaje Move:
        // https://move-language.github.io/move/functions.html
    }
}
