#include <iostream>
#include <regex>
#include <vector>

using namespace std;

bool validarCadena(const string& cadena) {
    regex patron(R"(^0*1(0|1)*(2(0|1)*(((0*1(0|1))|1(0|1)*)))*002$)");
    return regex_match(cadena, patron);
}

int main() {
    vector<string> pruebas = {
        // Cadenas que deben ser rechazadas
        "2010202002",
        "12121211010102001210200000002",
        "120120020100121002",
        "22121002",
        "1201012112100212002",

        // Cadenas que deben ser aceptadas
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

    for (const auto& cadena : pruebas) {
        cout << "Cadena: " << cadena << " -> " 
             << (validarCadena(cadena) ? "Aceptada" : "Rechazada") << endl;
    }

    return 0;
}
