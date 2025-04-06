// Horacio Villela Hernández A01712206 - 23/03/2025 - Actualizacion 05/04/2025

#include <iostream>
#include <regex>
#include <vector>

using namespace std;

/**
 * Función que valida si una cadena cumple con un patrón específico
 * definido mediante una expresión regular.
 *
 * @param cadena La cadena a validar
 * @return true si la cadena cumple el patrón, false en caso contrario
 *
 * Complejidad temporal: O(n)
 * - La función `regex_match` de la STL realiza una evaluación del patrón en tiempo *lineal en el mejor caso*,
 *   pero puede llegar a ser *cuadrática o peor* (O(n^2) o más) dependiendo de la expresión y del motor de regex usado (backtracking).
 * - En este caso, la expresión es compleja y anidada, por lo que **en el peor caso se aproxima a O(n^2)**.
 */
bool validarCadena(const string& cadena) {
    // Expresión regular que define el lenguaje aceptado
    regex patron(R"(^0*1(0|1)*(2(0|1)*(((0*1(0|1))|1(0|1)*)))*002$)");
    return regex_match(cadena, patron);
}

int main() {
    // Conjunto de pruebas: cadenas que deberían ser rechazadas o aceptadas
    vector<string> pruebas = {
        // Cadenas que deben ser rechazadas (no cumplen el patrón)
        "2010202002",
        "12121211010102001210200000002",
        "120120020100121002",
        "22121002",
        "1201012112100212002",
        "12002",

        // Cadenas que deben ser aceptadas (cumplen el patrón)
        "10001021201011211100021002",
        "1200000100001201000111200001002",
        "01020102012121002",
        "12121212100200101121200010002",
        "1201201211100021021020110201001201002",
        "121002",
        "1201021121002121002",
        "111002",
        "1002",
        "1021002"
    };

    // Evaluación de cada cadena
    for (const auto& cadena : pruebas) {
        cout << "Cadena: " << cadena << " -> " 
             << (validarCadena(cadena) ? "Aceptada" : "Rechazada") << endl;
    }

    return 0;
}
