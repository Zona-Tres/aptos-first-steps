// Esta vez usaremos la direccion explicita en vez de la nombrada.
module 0x5A6F6E612054726573::address { // No esta dentro de una expresion, por lo que no es necesario @

    use std::debug::print; // Cuando importamos usando use en realidad std es una direccion nombrada
    use 0x1::signer::Self; // 0x1 es la direccion a la que hace referencia std

    fun practica_address() {
        let a1: address = @0x1; // version corta de 0x00000000000000000000000000000001
        print(&a1); // Resultado: [debug] @0x1
        let a2: address = @0xBEBE; // version corta de 0x0000000000000000000000000000BEBE
        print(&a2); // Resultado: [debug] @0xbebe
        let a3: address = @66;
        print(&a3); // Resultado: [debug] @0x42
    }

    fun practica_signer(cuenta: signer) {
        print(&cuenta); // Resultado: [debug] signer(@0xaaaa)
        
        // Operaciones
        let s = signer::address_of(&cuenta); // Podemos usarla para convertir un signer en un address
        print(&s); // Resultado: [debug] @0xaaaa

        let s = signer::borrow_address(&cuenta); // O para crear una referencia a una address
        print(s); // Resultado: [debug] @0xaaaa
    }

    #[test(cuenta = @0xAAAA)] // Para testing. Pasamos una variable que fungira como la cuenta firmando transacciones
    fun prueba(cuenta: signer) {
        practica_address();
        practica_signer(cuenta); // Recuerda pasarla como parametro!
    }
}
