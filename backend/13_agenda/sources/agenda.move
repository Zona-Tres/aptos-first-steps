/// Modulo de una agenda sencilla utilizado como ejemplo en el programa de certificacion Aptos Developer Backend Expert.
/// Las funciones son:
/// * Crea recursos de Agenda en la cuenta del firmante
/// * Agrega Registros en la Agenda publicada en la cuenta del firmante
/// * Elimina y modifica dichos Registros
module cuenta::agenda {
    use aptos_std::table::{Self, Table};
    use std::string::String;
    use std::option::{Self, Option, is_some};
    use std::signer::address_of;

    /// Agenda ya inicializada. Cada cuenta puede tener solo 1 recurso de este tipo.
    const YA_INICIALIZADO: u64 = 1;
    /// Aun no se ha inicializado la Agenda.
    const NO_INICIALIZADO: u64 = 2;
    /// El Registro buscado no fue encontrado con el Nombre proporcionado.
    const REGISTRO_NO_EXISTE: u64 = 3;
    /// El nombre que se esta intentado usar ya existe
    const REGISTRO_YA_EXISTE: u64 = 4;
    /// No se proporcionaron valores a modificar.
    const NADA_A_MODIFICAR: u64 = 5;
    

    /// Estructura para usar como clave en la coleccion. No es del todo necesaria y podria sustituirse con una String,
    struct Nombre has copy, drop {
        nombre: String,
    }

    /// Estructura que guarda los datos que queramos almacenar de nuestros contactos. Puedes agregar mas si asi lo deseas.
    struct Registro has store, copy, drop { // Necesita la habilidd store para poder ser almacenada en la coleccion.
        telefono: u64,
        discord: String,
        correo: String,
        direccion: address,
    }

    /// Estructura que almacenara todos los registros de la cuenta.
    struct Agenda has key { // Necesita la habilidad key para poder ser usada en operaciones con el almacenamiento global.
        registros: Table<Nombre, Registro> // Vamos a usar Nombre como clave, y Registro como la estructura a almacenar.
    }

    /// Funciones
    /// Crea una nueva Agenda si no existe y la almacena en la cuenta del firmante
    public entry fun inicializar(cuenta: &signer) {
        assert!(!exists<Agenda>(address_of(cuenta)), YA_INICIALIZADO); // En dado caso de que YA exista la Agenda, abortamos el proceso.
        move_to(cuenta, Agenda {
            registros: table::new<Nombre, Registro>(),
        })
    }

    /// Agrega un registro a una Agenda existente.
    public entry fun agregar_registro(
        cuenta: &signer, 
        nombre: String, 
        telefono: u64, 
        discord: String, 
        correo: String, 
        direccion: address,
    ) acquires Agenda {
        assert!(exists<Agenda>(address_of(cuenta)), NO_INICIALIZADO); // Necesitamos que se haya corrido la funcion de inicializar primero.

        let registros = borrow_global_mut<Agenda>(address_of(cuenta));
        assert!(!table::contains(&registros.registros, Nombre { nombre }), REGISTRO_YA_EXISTE);

        table::add(&mut registros.registros, Nombre {
            nombre,
        }, Registro {
            telefono,
            discord,
            correo,
            direccion
        });
    }

    #[view]
    /// Obtiene el Registro relacionado con el Nombre dado.
    public fun obtener_registro(cuenta: address, nombre: String): Registro acquires Agenda {
        assert!(exists<Agenda>(cuenta), NO_INICIALIZADO);

        let registros = borrow_global<Agenda>(cuenta);
        let resultado = table::borrow(&registros.registros, Nombre { nombre });
        *resultado
    }

    /// Modifica el telefono del Registro relacionado con el Nombre dado.
    public entry fun modificar_telefono(cuenta: &signer, nombre: String, telefono: u64) acquires Agenda {
        assert!(exists<Agenda>(address_of(cuenta)), NO_INICIALIZADO);
        let registros = borrow_global_mut<Agenda>(address_of(cuenta));

        assert!(table::contains(&registros.registros, Nombre { nombre }), REGISTRO_NO_EXISTE);
        let telefono_actual = &mut table::borrow_mut(&mut registros.registros, Nombre { nombre }).telefono;
        *telefono_actual = telefono;
    }

    /// Modifica el discord del Registro relacionado con el Nombre dado.
    public entry fun modificar_discord(cuenta: &signer, nombre: String, discord: String) acquires Agenda {
        assert!(exists<Agenda>(address_of(cuenta)), NO_INICIALIZADO);
        let registros = borrow_global_mut<Agenda>(address_of(cuenta));

        assert!(table::contains(&registros.registros, Nombre { nombre }), REGISTRO_NO_EXISTE);
        let discord_actual = &mut table::borrow_mut(&mut registros.registros, Nombre { nombre }).discord;
        *discord_actual = discord;
    }

    /// Modifica el correo del Registro relacionado con el Nombre dado.
    public entry fun modificar_correo(cuenta: &signer, nombre: String, correo: String) acquires Agenda {
        assert!(exists<Agenda>(address_of(cuenta)), NO_INICIALIZADO);
        let registros = borrow_global_mut<Agenda>(address_of(cuenta));

        assert!(table::contains(&registros.registros, Nombre { nombre }), REGISTRO_NO_EXISTE);
        let correo_actual = &mut table::borrow_mut(&mut registros.registros, Nombre { nombre }).correo;
        *correo_actual = correo;
    }

    /// Modifica la direccion del Registro relacionado con el Nombre dado.
    public entry fun modificar_direccion(cuenta: &signer, nombre: String, direccion: address) acquires Agenda {
        assert!(exists<Agenda>(address_of(cuenta)), NO_INICIALIZADO);
        let registros = borrow_global_mut<Agenda>(address_of(cuenta));

        assert!(table::contains(&registros.registros, Nombre { nombre }), REGISTRO_NO_EXISTE);
        let direccion_actual = &mut table::borrow_mut(&mut registros.registros, Nombre { nombre }).direccion;
        *direccion_actual = direccion;
    }

    /// Modifica el Nombre con el que esta guardado un registro.
    public entry fun modificar_nombre(cuenta: &signer, nombre_actual: String, nombre_nuevo: String) acquires Agenda {
        // En realidad no existe una operacion para esto pero podemos hacer una copia de los valores, guardarlos con el nuevo nombre, y eliminar el registro anterior
        assert!(exists<Agenda>(address_of(cuenta)), NO_INICIALIZADO);

        let registros = borrow_global_mut<Agenda>(address_of(cuenta));
        assert!(table::contains(&registros.registros, Nombre { nombre: nombre_actual }), REGISTRO_NO_EXISTE);
        assert!(!table::contains(&registros.registros, Nombre { nombre: nombre_nuevo }), REGISTRO_YA_EXISTE);

        let registro = table::borrow(&registros.registros, Nombre { nombre: nombre_actual });
        table::add(&mut registros.registros, Nombre { nombre: nombre_nuevo }, *registro); // Aqui se hace la copia
        table::remove(&mut registros.registros, Nombre { nombre: nombre_actual });
    }

    /// Modifica el Registro relacionado con el Nombre dado.
    /// Esta funcion no puede ser usada en consola.
    /// Pero puedes probarla en el explorador: https://explorer.aptoslabs.com/
    public entry fun modificar_registro(
        cuenta: &signer, 
        nombre: String, 
        telefono: Option<u64>, // Esta funcion acepta parametros del tipo Option, si un valor no es necesario para la operacion lo podemos ignorar.
        discord: Option<String>,
        correo: Option<String>, 
        direccion: Option<address>,
    ) acquires Agenda {
        assert!(exists<Agenda>(address_of(cuenta)), NO_INICIALIZADO);
        assert!(is_some(&telefono) || is_some(&discord) || is_some(&correo), NADA_A_MODIFICAR); // Evaluamos que al menos 1 valor haya sido enviado para modificarlo en el Regitro.

        let registros = borrow_global_mut<Agenda>(address_of(cuenta));

        assert!(table::contains(&registros.registros, Nombre { nombre }), REGISTRO_NO_EXISTE);
        let registro = table::borrow_mut(&mut registros.registros, Nombre { nombre });
        
        // Y evaluamos cada una de las Option. Si tienen un valor, se modifica, si no, no pasa nada.
        if (is_some(&telefono)) registro.telefono = *option::borrow(&telefono);
        if (is_some(&discord)) registro.discord = *option::borrow(&discord);
        if (is_some(&correo)) registro.correo = *option::borrow(&correo);
        if (is_some(&direccion)) registro.direccion = *option::borrow(&direccion);
    }
    
    /// Elimina el Registro en base al Nombre dado.
    public entry fun eliminar_registro(cuenta: &signer, nombre: String) acquires Agenda {
        assert!(exists<Agenda>(address_of(cuenta)), NO_INICIALIZADO);

        let registros = borrow_global_mut<Agenda>(address_of(cuenta));
        assert!(table::contains(&registros.registros, Nombre { nombre }), REGISTRO_NO_EXISTE);

        table::remove(&mut registros.registros, Nombre { nombre });
    }
}
