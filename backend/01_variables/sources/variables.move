module aptosz3::variables {
    use std::debug::print;
    use std::string::utf8;
    use std::vector;
    
    // Las constantes solo se pueden usar en el modulo donde fueron declaradas.
    // La primer letra de una constante siempre tiene que ser una letra mayuscula de la A a la Z.
    // Despues de la primer letra, puede llevar: letras de a a la z, o de A a la Z, asi como digitos del 0 al 9, o guion bajo _.
    // El codigo en Move no acepta acentos en nigun lugar, ni siquiera en comentarios.
    const SALUDO: vector<u8> = b"Hola, Mundo!";
    const Valor_verdadero: bool = true;

    fun practica() {
        // Haciendo uso de constantes:
        print(&utf8(SALUDO)); // Resultado: [debug] "Hola, Mundo!"
        print(&Valor_verdadero); // Resultado: [debug] true

        // Declarando varables:
        let a = 1; // Las variables en Move se declaran con let
        let b = a + a;
        print(&a); // Resultado: [debug] 1
        print(&b); // Resultado: [debug] 2

        //Nombrando variables:
        // Las variables pueden tener: letras de a a la z, o de A a la Z, asi como digitos del 0 al 9, o guion bajo _.
        // Pueden comenzar con letras de la a a la z o con guion bajo.
        // Su nombre no puede comenzar con una letra mayuscula (A - Z).
        let _c = 3; // Por lo general usamos _ al inicio del nombre para indicar que es una variable que no sera usada.
        let una_variable_con_un_nombre_muy_largo = b"Aptos";
        let _camelCase = false;
        print(&utf8(una_variable_con_un_nombre_muy_largo)); // Resultado: [debug] "Aptos"

        // Anotaciones de tipo:
        // Puedes especificar el tipo de una variable antes de declararla
        let _d: address = @0x0;
        // Sin embargo, esto no siempre es necesario.
        // Solo se debe de hacer cuando el compilador no puede inferir el tipo por si solo.
        // Por ejemplo: let v1 = vector::empty(); dara error porque el sistema no sabe el tipo resultante de la funcion vector::empty().
        let _v2: vector<u64> = vector::empty();

        // Declaracion multiple:
        let (x0, x1) = (0, 1); // Puedes declarar multiples variables al mismo tiempo.
        print(&x0); // Resultado: [debug] 0
        print(&x1); // Resultado: [debug] 1

        // Reasignacion
        let _e = 0;
        _e = 100;
        print(&_e);

        // Scope
        let f = 5; // Variables declaradas fuera de un scope pueden ser usadas dentro de los scopes declarados al mismo nivel de la variable.
        { // Abriendo un nuevo scope
            let g = f + f;
            print(&g); // Resultado: [debug] 10
        }; // Cerrando el scope
        // print(&g); aqui daria error, dado a que fue declarado en otro scope, y una vez cerrado, ya no tenemos acceso a esa variable.
        // Sin embargo, dado a que ya no estamos en ese scope, podemos redeclararla y usarla:
        let g = f + f + f;
        print(&g); // Resultado: [debug] 15

        // Shadowing
        // Si una variable es redeclarada, la declaracion anterior se ignora.
        let _h = 1;
        let _h = false; // De hecho, puedes cambiar el tipo de una variable anteriormente declarada.
        print(&_h); // Resultado: [debug] false
    }

    #[test]
    fun prueba() {
        practica();
    }
}
