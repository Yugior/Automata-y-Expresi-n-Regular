% Horacio Villela Hernández A01712206 - 23/03/2025  Actualizacion 05/04/2025


% Modelo de Autómata Finito Determinista (DFA)


% Definimos las transiciones del autómata en forma:
% move(EstadoActual, EstadoSiguiente, Símbolo)
move(a, a, 0).
move(a, b, 1).
move(b, b, 0).
move(b, b, 1).
move(b, c, 2).
move(c, a, 0).
move(c, b, 1).

% Definimos el estado de aceptación: el autómata acepta si termina en el estado c
accepting_state(c).

% ----------------------------------------
% Función principal: parseDFA/1
% Verifica si una cadena (lista de símbolos) es aceptada por el autómata
% Condición adicional: debe terminar con los símbolos [0, 0, 2]
%
% Complejidad temporal: O(n)
% - Cada símbolo de la lista se recorre una sola vez
% - Las búsquedas de transición (move/3) son constantes si hay pocos estados
% ----------------------------------------

parseDFA(InputList) :-
    append(_, [0, 0, 2], InputList),  % Verifica que la cadena termine con [0, 0, 2]
    parseDFAHelper(InputList, a).     % Inicia el DFA en el estado 'a'

% ----------------------------------------
% Caso base: lista vacía -> verificar estado de aceptación
% ----------------------------------------
parseDFAHelper([], CurrentState) :-
    accepting_state(CurrentState),
    write('Accepted'), nl.

% ----------------------------------------
% Caso de rechazo: si no hay transición válida con el símbolo actual
% ----------------------------------------
parseDFAHelper([Symbol | _], CurrentState) :-
    \+ move(CurrentState, _, Symbol),  % No existe transición válida
    write('Rejected'), nl, !, fail.

% ----------------------------------------
% Caso recursivo: aplicar la transición y continuar
% ----------------------------------------
parseDFAHelper([Symbol | Rest], CurrentState) :-
    move(CurrentState, NextState, Symbol),
    parseDFAHelper(Rest, NextState).
