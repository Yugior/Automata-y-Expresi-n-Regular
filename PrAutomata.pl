%Horacio Villela Hernandez A01712206 23/03/2025 
% Definimos las transiciones del autómata
move(a, a, 0).
move(a, b, 1).
move(b, b, 0).
move(b, b, 1).
move(b, c, 2).
move(c, a, 0).
move(c, b, 1).

% Estado de aceptación: la cadena debe terminar en "002"
accepting_state(c).

% Función principal para evaluar si una cadena es aceptada por el autómata
parseDFA(InputList) :-
    append(_, [0, 0, 2], InputList), % Verifica que termine en "002"
    parseDFAHelper(InputList, a).

% Caso base: si la lista está vacía, verificamos si el estado actual es de aceptación
parseDFAHelper([], CurrentState) :-
    accepting_state(CurrentState),
    write('Accepted'), nl.

% Caso de rechazo inmediato si no hay una transición válida
parseDFAHelper([Symbol | _], CurrentState) :-
    \+ move(CurrentState, _, Symbol),
    write('Rejected'), nl, !, fail.

% Caso recursivo: avanzamos en la cadena verificando las transiciones
parseDFAHelper([Symbol | Rest], CurrentState) :-
    move(CurrentState, NextState, Symbol),
    parseDFAHelper(Rest, NextState).

