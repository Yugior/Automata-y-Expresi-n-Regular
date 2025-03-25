# E1 Implementation of Lexical Analysis (Automaton and Regular Expression)
Horacio Villela Hernandez A01712206

## Descripcion
El lenguaje elegiido para la evidencia es uno matematico. a esto se refiere que se puede tener todas las posiblilidades de '0'1'2' con dos reglas claras:

1. Debe haber un 1 antes de un 2 siempre
2. Debe de terminar con la secuencia '002'


## Diseño

En una versión inicial del autómata, algunos estados no tenían transiciones que permitieran continuar el procesamiento de la cadena, lo que resultaba en estados finales sin conexión. Para corregir esto, se implementaron transiciones de bucle al final, permitiendo que el autómata pueda procesar más entradas sin quedar atrapado en estados sin salida.

Bocetos Iniciales![Automata evidence 1](BocetosOriginales.png)

Pro estas mismas limitantes, el diseño final sigue estas reglas:

1. Siempre debe haber un 1 antes de un 2 en la cadena.

2. La cadena debe terminar en "002" para ser aceptada.

3. Se utilizan tres estados:

    A. (estado inicial), que permite la recepción de ceros y espera la llegada de un 1.

    B.  que indica que se ha encontrado un 1 y gestiona la aparición del 2.

    C. (estado de aceptación), que solo se alcanza si la cadena termina en "002".

![Automata evidence 1](Automata.png)

Al agregar bucles en el estado final y asegurar transiciones adecuadas, el autómata ahora es capaz de procesar correctamente todas las cadenas que cumplen con las reglas del lenguaje.

El autómata funciona de la siguiente manera:

| Estado Inicial | Input | Estdo Final|
| -------------- | ------| -----------|
| A             | 0     | A           |
| A             | 1     | B           |
| B             | 0     | B           |
| B             | 1     | B           |
| B             | 2     | C           |
| C             | 0     | A           |
| C             | 1     | B           |


Y este mismo se representa e implementa de forma exacta en esta expresion regular:

<strong>/^0*1(0|1)*(2(0|1)*(((0*1(0|1))|1(0|1)*)))*002$/gm</strong>

## Implementacion
Después de diseñar el autómata, se debe traducir su funcionamiento a un archivo en Prolog para poder probarlo y modificarlo de ser necesario.

Con esto dicho, se establecen las relaciones entre los estados usando el siguiente formato:
<strong>move(CurrentState,NextState,Symbol)</strong>

Y después de definir todas las transiciones, debemos indicar cuál es el estado de aceptación utilizando la siguiente regla:
<strong>accepting_state(c)</strong>

Para verificar si una cadena es aceptada, se utiliza la función parseDFA/1, que primero valida si la entrada termina en "002", y luego llama a la función recursiva parseDFAHelper/2 para recorrer la cadena símbolo por símbolo:

<strong>parseDFA(InputList) :-
    append(_, [0, 0, 2], InputList),
    parseDFAHelper(InputList, a)</strong>

En el caso base; si la lista está vacía, verificamos si el estado actual es de aceptación e imprimimos <strong>"Accepted</strong>

<strong>parseDFAHelper([], CurrentState) :-
    accepting_state(CurrentState),
    write('Accepted'), nl.
    
Por otro lado en el caso de rechazo inmediato; si no existe una transición válida desde el estado actual con el símbolo dado, se rechaza la cadena.

<strong>parseDFAHelper([Symbol | _], CurrentState) :-
    \+ move(CurrentState, _, Symbol),
    write('Rejected'), nl, !, fail.

En el caso de la función recursiva se avanza en la cadena, aplicando la transición correspondiente al siguiente estado.

<strong>parseDFAHelper([Symbol | Rest], CurrentState) :-
    move(CurrentState, NextState, Symbol),
    parseDFAHelper(Rest, NextState).

## Complejidad
La complejidad del sistema es O(n), ya que cada símbolo de la cadena se procesa una única vez, recorriéndola de manera lineal hasta llegar al estado final.

## Testing
Las pruebas del automata estan escritas en el siguiente archivo <strong>TestAutomata.pl</strong>

En caso de probar las cadenas usando la expresion regular, se pueden encontrar en el archivo <strong>Expresionregular.cpp</strong>
Aqui se desarrollo el programa usando C++ bajo las librerias "redex" y vector", La primera nos ayuda a leer la RE, mientras la segunda nos ayuda para almacenar las diferentes cadenas a validar.

## References

CS154: Introduction to Automata and Complexity Theory. (n.d.). http://infolab.stanford.edu/~ullman/ialc/spr10/spr10.html

Tejedor, J. (2020, September 1). Introducción a expresiones regulares. Acceseo. https://www.acceseo.com/introduccion-a-expresiones-regulares.html




