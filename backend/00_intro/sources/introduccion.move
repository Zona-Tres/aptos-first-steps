module introduccion::practica_aptos {
    use std::debug::print;
    use std::string::utf8;

    fun practica() {
        print(&utf8(b"Hello, World!"));
    }

    #[test]
    fun prueba() {
        practica();
    }
}
