% Horacio Villela Hernández A01712206 - 21/04/2025
% Autómata Finito Determinista (AFD)
% Reglas:
% - Cadena compuesta por símbolos {0, 1, 2}
% - Siempre debe haber un 1 antes que un 2
% - Debe terminar en [0, 0, 2]

% ----------------------------------------
% Transiciones: transicion(EstadoActual, EstadoSiguiente, Simbolo)
% ----------------------------------------

transicion(q0, q0, 0).
transicion(q0, q1, 1).

transicion(q1, q1, 1).
transicion(q1, q1, 2).
transicion(q1, q2, 0).

transicion(q2, q1, 1).
transicion(q2, q1, 2).
transicion(q2, q3, 0).

transicion(q3, q1, 1).
transicion(q3, q4, 2).
transicion(q3, q3, 0).

% Desde q4, podemos continuar procesando más símbolos
transicion(q4, q1, 1).  % si aparece un 1, volvemos a q1
transicion(q4, q2, 0).  % si aparece un 0, pasamos a q2
transicion(q4, q1, 2).  % si aparece un 2, seguimos en q1 (ya hay un 1 previo)

% Estado de aceptación
estado_final(q4).

% ----------------------------------------
% aceptar/1
% Verifica si una cadena (lista de símbolos) es aceptada por el AFD
% Condiciones:
% - Termina en [0, 0, 2]
% - Sigue transiciones válidas
% ----------------------------------------

aceptar(Cadena) :-
    append(_, [0, 0, 2], Cadena),   % Verifica que termine en 002
    procesar(Cadena, q0).          % Inicia desde el estado q0

% ----------------------------------------
% Caso base: cadena vacía y estado final
% ----------------------------------------
procesar([], EstadoActual) :-
    estado_final(EstadoActual),
    write('Aceptada'), nl.

% ----------------------------------------
% Rechazo si no hay transición válida
% ----------------------------------------
procesar([Simbolo | _], EstadoActual) :-
    \+ transicion(EstadoActual, _, Simbolo),
    write('Rechazada: transición inválida'), nl, !, fail.

% ----------------------------------------
% Caso recursivo: aplicar transición y continuar
% ----------------------------------------
procesar([Simbolo | Resto], EstadoActual) :-
    transicion(EstadoActual, SiguienteEstado, Simbolo),
    procesar(Resto, SiguienteEstado).
