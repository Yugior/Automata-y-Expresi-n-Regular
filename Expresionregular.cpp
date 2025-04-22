// Horacio Villela Hernández A01712206 - 21/04/2025
// Validación de cadenas usando expresión regular
// Reglas:
// - Cadenas formadas por {0, 1, 2}
// - Deben contener al menos un '1' antes de cualquier '2'
// - Deben terminar en '002'

#include <iostream>
#include <regex>
#include <vector>

using namespace std;

/**
 * Valida si una cadena es aceptada por el lenguaje definido por el autómata.
 * 
 * Expresión regular: ^0*1(0|1)*(0|1|2)*002$
 * - ^            : Inicio de cadena
 * - 0*           : Ceros opcionales al principio
 * - 1            : Al menos un '1' obligatorio
 * - (0|1)*       : Secuencia opcional de ceros y unos
 * - (0|1|2)*     : Secuencia opcional de ceros, unos o doses
 * - 002$         : Termina en '002'
 * 
 * @param cadena La cadena a validar
 * @return true si es válida, false si no
 */
bool validarCadena(const string& cadena) {
    regex patron(R"(^0*1(0|1)*(0|1|2)*002$)");
    return regex_match(cadena, patron);
}

int main() {
    // Lista de pruebas de ejemplo

    vector<string> pruebas = {
        // Rechazadas: no cumplen la regla (no hay '1' antes del '2' o no terminan en 002)
        "2010202002",                // Inicia con '2'
        "1201200201001210012",        // No termina en 002
        "22121002",                  // Inicia con '2'
        "00201012112100212002",       // Transición inválida interna
        

        // Aceptadas: siguen el patrón y terminan en '002'
        "10001021201011211100021002",
        "1200000100001201000111200001002",
        "01020102012121002",
        "12121212100200101121200010002",
        "1201201211100021021020110201001201002",
        "121002",
        "1201021121002121002",
        "111002",
        "12002", //CASO DE PRUEBA RECHAZADO ANTERIORMENTE EN REVISION
        "1021002",
        "000000000010000000002"
    };

    // Evaluar y mostrar resultados
    for (const auto& cadena : pruebas) {
        cout << "Cadena: " << cadena << " -> "
             << (validarCadena(cadena) ? "Aceptada" : "Rechazada") << endl;
    }

    return 0;
}
