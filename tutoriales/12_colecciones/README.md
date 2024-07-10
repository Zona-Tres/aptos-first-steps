# Colecciones

## Ejecutando el tutorial

> :information_source: Recuerda que debes navegar en tu terminal a este directorio:
>```sh
>cd tutoriales/12_colecciones
>```

Ingresa a tu terminal y ejecuta el siguiente comando:

```sh
aptos move test
```

Deberías de obtener el siguiente resultado:
```sh
INCLUDING DEPENDENCY AptosStdlib
INCLUDING DEPENDENCY MoveStdlib
BUILDING Colecciones
Running Move unit tests
[debug] 30
[debug] 31
[debug] 32
[debug] false
[ PASS    ] 0x5a6f6e612054726573::tabla::prueba
[debug] 0x5a6f6e612054726573::mapa_simple::Libro {
  titulo: "El alquimista",
  autor: "Paulo Cohelo",
  publicado: 1988
}
[debug] 0x5a6f6e612054726573::mapa_simple::Libro {
  titulo: "El Alquimista",
  autor: "Paulo Cohelo",
  publicado: 1988
}
[debug] "[ 123, 425 ]"
[debug] "[
  0x5a6f6e612054726573::mapa_simple::Libro {
    titulo: \"El Alquimista\",
    autor: \"Paulo Cohelo\",
    publicado: 1988
  },
  0x5a6f6e612054726573::mapa_simple::Libro {
    titulo: \"Carrie\",
    autor: \"Stephen King\",
    publicado: 1974
  }
]"
[debug] "[ 123, 425 ]"
[debug] "[
  0x5a6f6e612054726573::mapa_simple::Libro {
    titulo: \"El Alquimista\",
    autor: \"Paulo Cohelo\",
    publicado: 1988
  },
  0x5a6f6e612054726573::mapa_simple::Libro {
    titulo: \"Carrie\",
    autor: \"Stephen King\",
    publicado: 1974
  }
]"
[debug] "Some(425)"
[debug] "Some(0x5a6f6e612054726573::mapa_simple::Libro {
  titulo: \"Carrie\",
  autor: \"Stephen King\",
  publicado: 1974
})"
[ PASS    ] 0x5a6f6e612054726573::mapa_simple::prueba
Test result: OK. Total tests: 2; passed: 2; failed: 0
{
  "Result": "Success"
}
```

## Tutorial

Puedes encontrar la documentación para este tutorial dentro del archivo `sources/colecciones.move`. Cada una de las declaraciones tiene un comentario para ayudarte a entender cada uno de los temas tocados.

> :information_source: Recuerda que puedes encontrar más información sobre las colecciones y sus métodos en la [documentación](https://github.com/aptos-labs/aptos-core/tree/main/aptos-move/framework/aptos-stdlib/doc) oficial del Aptos Core.