module aptosz3::condicionales {
    use std::debug::print;
    use std::string::utf8;

    const ESinAcceso: u64 = 1; // Usualmente las constantes para indicar un error inician con E mayuscula, seguido de la razon del error.
    const NO_HAY_ACCESO: u64 = 2; // Aunque no es necesario, solo se descriptivo en tus errores.

    fun practica() {
        // If
        let a = 10;
        if (a > 0) { // La evaluacion de la condicion dentro del if tiene que dar un resultado booleano.
            print(&utf8(b"a es mayor a 0")); // La operacion despues de la evaluacion puede ser casi cualquier cosa.
        }; // Cerramos bloque.
        // Resultado: [debug] "a es mayor a 0"

        // Else
        if (a > 20) {
            print(&utf8(b"a es mayor a 20"));
        } else { // No cerramos bloque.
            print(&utf8(b"a no es mayor a 20"));
        }; // Hasta aca se cierra.
        // Resultado: [debug] "a no es mayor a 20"

        // Si la expresion da un resultado, es posible almacenarla en una variable
        let almacenada = if (a < 100) a else 100;
        print(&almacenada); // Resultado: [debug] 10

        // Abort
        let acceso_usuario: bool = true; // En este escenario, nuestro usuario tiene acceso a todas las funciones.
        // Normalmente tu tendrias que evaluar esto dependiendo de tu modulo.
        if(!acceso_usuario) { // Intenta quitar la negacion y ejecuta de nuevo.
            abort(1) // El codigo es regresado al usuario si la ejecucion aborta.
        } else {
            print(&utf8(b"Usuario tiene acceso."));
        };

        // Assert
        assert!(acceso_usuario, 1); // Otra forma de escribir la expresion anterior sin necesidad de regresar algo.
        // Intenta negar el acceso usando !

        // Codigos de error
        assert!(acceso_usuario, ESinAcceso); // Es buena practica especificar la razon de un abort/assert.
        assert!(acceso_usuario, NO_HAY_ACCESO);
    }

    #[test]
    fun prueba() {
        practica();
    }
}
