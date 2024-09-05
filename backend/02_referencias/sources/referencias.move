module aptosz3::referencias {
    use std::debug::print;

    fun practica() {
        // Tipo no referenciado:
        let a = 1;
        print(&a); // Para imprimir un tipo no referenciado necesitamos agregar la referencia al valor.

        // Tipo referenciado:
        let b = 7;
        let c : &u64 = &b;
        print(c); // Dado a que c ya fue declarado como tipo referenciado, no es necesario especificar la referencia.
    
        // Inmutable
        let original: u64 = 1;
        let copia_de_original = original; // Nota que no estamos pasando la referencia aqui.
        print(&copia_de_original); // Pero aqui si.

        let otra_copia = &original;
        print(otra_copia);

        // Mutable
        let copia_mutable = &mut original; 
        print(copia_mutable); // De nuevo, no es necesario pasar la referencia.

        *copia_mutable = 20;
        print(copia_mutable);
        print(&original); // Porque ahora el original es 20 si lo que modificamos fue la copia mutable? 
    }

    #[test]
    fun prueba() {
        practica();
    }
}
