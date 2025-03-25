# Implementación de Autómatas y Expresiones Regulares

## Horacio Villela Hernandez A01712206

## Descripción

El lenguaje elegido para esta evidencia es uno matemático. Se define como un conjunto de cadenas compuestas por los símbolos 0, 1 y 2, con dos reglas claras:

- Debe haber un 1 antes de un 2 siempre.
- La cadena debe terminar con la secuencia 002.

## Diseño

En una versión inicial del autómata, algunos estados no tenían transiciones que permitieran continuar el procesamiento de la cadena, lo que resultaba en estados finales sin conexión. Para corregir esto, se implementaron transiciones de bucle al final, permitiendo que el autómata procese más entradas sin quedar atrapado en estados sin salida.

### Bocetos Iniciales

![Automata evidence 1](BocetosOriginales.png)

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

```
/^0*1(0|1)*(2(0|1)*(((0*1(0|1))|1(0|1)*)))*002$/gm
```
## Implementación

Tras diseñar el autómata, su funcionamiento se tradujo a un archivo en Prolog para realizar pruebas y modificaciones de ser necesario.

Se establecen las relaciones entre los estados usando la estructura:

```prolog
move(CurrentState, NextState, Symbol).
```

Y se define el estado de aceptación con:

```prolog
accepting_state(c).
```

Para verificar si una cadena es aceptada, se utiliza la función `parseDFA/1`, que primero valida si la entrada termina en 002, y luego llama a la función recursiva `parseDFAHelper/2` para recorrer la cadena símbolo por símbolo:

```prolog
parseDFA(InputList) :-
    append(_, [0, 0, 2], InputList),
    parseDFAHelper(InputList, a).
```

Casos de la recursión:

- **Caso base:** Si la lista está vacía, verificamos si el estado actual es de aceptación e imprimimos "Accepted":

```prolog
parseDFAHelper([], CurrentState) :-
    accepting_state(CurrentState),
    write('Accepted'), nl.
```

- **Caso de rechazo inmediato:** Si no existe una transición válida desde el estado actual con el símbolo dado, se rechaza la cadena:

```prolog
parseDFAHelper([Symbol | _], CurrentState) :-
    \+ move(CurrentState, _, Symbol),
    write('Rejected'), nl, !, fail.
```

- **Caso recursivo:** Se avanza en la cadena, aplicando la transición correspondiente al siguiente estado:

```prolog
parseDFAHelper([Symbol | Rest], CurrentState) :-
    move(CurrentState, NextState, Symbol),
    parseDFAHelper(Rest, NextState).
```

## Complejidad

La complejidad del sistema es **O(n)**, ya que cada símbolo de la cadena se procesa una única vez, recorriéndola de manera lineal hasta llegar al estado final.

## Testing

Las pruebas del autómata están escritas en el archivo `TestAutomata.pl`. Si se desean probar cadenas usando la expresión regular, se pueden encontrar en el archivo `ExpresionRegular.cpp`. Este programa fue desarrollado en C++ utilizando las bibliotecas **regex** y **vector**. La primera permite evaluar la expresión regular, mientras que la segunda almacena las diferentes cadenas a validar.

## References

CS154: Introduction to Automata and Complexity Theory. (n.d.). http://infolab.stanford.edu/~ullman/ialc/spr10/spr10.html

Tejedor, J. (2020, September 1). Introducción a expresiones regulares. Acceseo. https://www.acceseo.com/introduccion-a-expresiones-regulares.html




