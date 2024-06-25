module aptosz3::cadenas {
    use std::debug::print;
    use std::string::{utf8, is_empty, append, append_utf8, insert};
    use aptos_std::string_utils::{to_string, debug_string};

    fun practica() {
        // Cadenas
        
        // Bytes
        let cadena_bytes = b"Hello World!";
        print(&cadena_bytes); // Resultado: [debug] 0x48656c6c6f20576f726c6421
        print(&utf8(cadena_bytes)); // Resultado: [debug] "Hello World!"
        
        // Hex
        let cadena_hexadecimal = x"48656C6C6F20576F726C6421";
        print(&cadena_hexadecimal); // Resultado: [debug] 0x48656c6c6f20576f726c6421 Notas alguna similitud?
        print(&utf8(cadena_hexadecimal)); // Resultdo: [debug] "Hello World!"

        // Operaciones
        let cadena_vacia = b"";
        let validacion = is_empty(&utf8(cadena_vacia)); // Validando si la cadena esta vacia
        print(&validacion); // Resultdo: [debug] true

        let cadena_utf8 = utf8(cadena_vacia);
        append_utf8(&mut cadena_utf8, b"Hola"); // Concatenando 2 cadenas utf8. Nota que pasamos una referencia mutable.
        print(&cadena_utf8); // Resultado: [debug] "Hola"

        let otra_cadena = utf8(b"Adios");
        append(&mut cadena_utf8, otra_cadena); // Concatenando 2 cadenas.
        print(&cadena_utf8); // Resultado: [debug] "HolaAdios"

        let hex_a_utf8 = utf8(cadena_hexadecimal);
        append(&mut cadena_utf8, hex_a_utf8); // Recuerda que puedes usar tanto bytes como hex.
        print(&cadena_utf8); // Resultado: [debug] "HolaAdiosHello World!"

        let intruso = utf8(b"INSERTAME");
        insert(&mut cadena_utf8, 4, intruso); // Insertando una cadena.
        print(&cadena_utf8); // Resultado: [debug] "HolaINSERTAMEAdiosHello World!"

        let escape = utf8(b"\nEsto se imprimira en una nueva linea.");
        append(&mut cadena_utf8, escape);
        print(&cadena_utf8); // Resultado: [debug] "HolaINSERTAMEAdiosHello World!
                                              //            Esto se imprimira en una nueva linea."

        // String utils
        let numero = 100u16; // Podemos convertir variables a cadenas.
        print(&to_string<u16>(&numero)); // Resultado: [debug] "100" Nota que se imprime como cadena, y no como numero.

        let v: vector<u16> = vector[10, 20, 30]; // Tambien podemos convertir cosas mas complejas
        print(&debug_string(&v)); // Resultado: [debug] "[ 10, 20, 30 ]" Nota: No funciona con u8.

        // Recuerda que puedes obtener informacion sobre las demos operaciones en:
        // https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/move-stdlib/doc/string.md
        // https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/aptos-stdlib/doc/string_utils.md
    }

    #[test]
    fun prueba() {
        practica();
    }
}
