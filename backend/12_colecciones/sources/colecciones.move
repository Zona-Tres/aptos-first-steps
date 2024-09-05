address aptosz3 {
    module tabla {
        use std::debug::print;
        use aptos_std::table::{Self, Table};
        use std::string::{String,utf8};
        use std::signer::address_of;

        struct Tabla has key { // Dado a que utilizaremos este struct con operaciones del global_storage, necesita tener la habilidad key
            tabla: Table<String, u8> // Declaramos tipo
        }

        fun practica(cuenta: &signer) acquires Tabla {
            // Inicializando
            let tabla = table::new<String, u8>(); // Declaracion de una nueva tabla
            move_to(cuenta, Tabla { tabla }); // Moviendo el recurso
            
            // Agregando elementos
            let  tabla_mutable = borrow_global_mut<Tabla>(address_of(cuenta)); // Obtenemos referencia mutable
            table::add(&mut tabla_mutable.tabla, utf8(b"Juanito"), 30u8);
            table::add(&mut tabla_mutable.tabla, utf8(b"Rosarito"), 25u8);

            // Obteniendo un valor
            let juanito = table::borrow(&mut tabla_mutable.tabla, utf8(b"Juanito"));
            print(juanito);

            // Actualizando un valor
            // Upsert inserta el valor si no existe, o lo actualiza si si existe.
            table::upsert(&mut tabla_mutable.tabla, utf8(b"Juanito"), 31u8);
            print(table::borrow(&mut tabla_mutable.tabla, utf8(b"Juanito")));

            // O podemos hacer borrow del propio valor
            let juanito = table::borrow_mut(&mut tabla_mutable.tabla, utf8(b"Juanito"));
            *juanito = 32;
            print(table::borrow(&mut tabla_mutable.tabla, utf8(b"Juanito")));

            // Eliminando un valor
            table::remove(&mut tabla_mutable.tabla, utf8(b"Juanito"));

            // Contiene
            let contiene = table::contains(&mut tabla_mutable.tabla, utf8(b"Juanito"));
            print(&contiene);

            // Puedes revisar las demas operaciones de table en la documentacion oficial:
            // https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/aptos-stdlib/doc/table.md#0x1_table_add_box
        }

        #[test(cuenta = @0xBEBE)]
        fun prueba(cuenta: signer) acquires Tabla {
            practica(&cuenta);
        }
    }

    module mapa_simple {
        use std::debug::print;
        use std::string_utils::debug_string;
        use std::simple_map::{Self, SimpleMap};
        use std::string::{String, utf8};
        use std::signer::address_of;
        use std::option::Self;

        struct MapaSimple has key {
            mapa: SimpleMap<u16, Libro> // Declaramos tipo
        }

        struct Libro has store, copy, drop {
            titulo: String,
            autor: String,
            publicado: u16,
        }

        fun practica(cuenta: &signer) acquires MapaSimple {
            // Inicializando
            let mapa_nuevo = simple_map::new<u16, Libro>();
            move_to(cuenta, MapaSimple { mapa: mapa_nuevo });

            // Anadiendo registros
            let mapa = borrow_global_mut<MapaSimple>(address_of(cuenta)).mapa;
            let libro1 = Libro { titulo: utf8(b"El alquimista"), autor: utf8(b"Paulo Cohelo"), publicado: 1988u16 };
            let libro2 = Libro { titulo: utf8(b"Carrie"), autor: utf8(b"Stephen King"), publicado: 1974u16 };
            simple_map::add(&mut mapa, 123, libro1);
            simple_map::add(&mut mapa, 425, libro2);

            // Obtener un valor
            let libro = simple_map::borrow(&mapa, &123u16);
            print(libro);

            // Modificar un valor
            let libro = simple_map::borrow_mut(&mut mapa, &123u16);
            libro.titulo = utf8(b"El Alquimista");
            print(libro);

            // Obtener todas las claves
            let claves = simple_map::keys(&mapa);
            print(&debug_string(&claves));

            // Obtener todas los valores
            let valores = simple_map::values(&mapa);
            print(&debug_string(&valores));

            // Obtener claves + valores
            let (keys, vals) = simple_map::to_vec_pair(mapa);
            print(&debug_string(&keys));
            print(&debug_string(&vals));

            // Insertar o actualizar un valor
            let libro3 = Libro { titulo: utf8(b"It"), autor: utf8(b"Stephen King"), publicado: 1974u16 };
            let (upsert1, upsert2) = simple_map::upsert(&mut mapa, 425, libro3);
            print(&debug_string(&upsert1));
            print(&debug_string(&upsert2));

            // Puedes revisar las demas operaciones de simple_map en la documentacion oficial:
            // https://github.com/aptos-labs/aptos-core/blob/main/aptos-move/framework/aptos-stdlib/doc/simple_map.md#0x1_simple_map_add
        }

        #[test(cuenta = @0xBEBE)]
        fun prueba(cuenta: signer) acquires MapaSimple {
           practica(&cuenta);
        }
    }
}
