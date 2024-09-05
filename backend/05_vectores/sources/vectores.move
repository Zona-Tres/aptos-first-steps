module aptosz3::vectores {
    use std::debug::print;
    use std::vector::{empty, length, borrow, borrow_mut, push_back}; // Solo para crear un vector no es necesario importar la libreria.
    // Pero las operaciones de los vectores (como push, pop_back) si necesitan que la importes.

    fun practica() {
        // Vectores
        let _vacio: vector<u64> = vector[]; // Un vector vacio.
        let _vacio2 = empty<u32>(); // Otra forma de crear un vector vacio.
        let _v1: vector<u8> = vector[10, 20, 30]; // Un vector de u8 inicializado con 3 elementos.
        let _v2: vector<vector<u16>> = vector[
            vector[10, 20],
            vector[30, 40]
        ]; // Un vector de vectores u16 inicializado con 2 elementos, cada uno con 2 elementos.

        // Operaciones
        let v3: vector<u8> = vector[1, 2, 3];

        let elemento = *borrow(&v3, 0); // Obteniendo el primer elemento del vector.
        print(&elemento); // Resultado: [debug] 1

        let longitud = length(&v3); // Obteniendo la longitud del vector.
        print(&longitud); // Resultado: [debug] 3

        *borrow_mut(&mut v3, 1) = 55; // Sustituyendo un valor en el vector.
        print(borrow(&v3, 1)); // Resultado: [debug] 5

        push_back(&mut v3, 40); // Agregando un elemento al final del vector.
        print(borrow(&v3, 3)); // Resultado: [debug] 40

        // Recuerda que puedes obtener informacion sobre las demos operaciones en:
        // https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/move-stdlib/doc/vector.md
    }

    #[test]
    fun prueba() {
        practica();
    }
}
