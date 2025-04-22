%  Aceptadas: contienen al menos un 1 antes de cualquier 2 y terminan en 002
?- aceptar([1, 0, 0, 2]).
Aceptada.

?- aceptar([0, 1, 0, 0, 2]).
Aceptada.

?- aceptar([1, 2, 1, 2, 0, 0, 2]).
Aceptada.

?- aceptar([0, 0, 1, 0, 0, 2]).
Aceptada.

?- aceptar([1, 1, 0, 1, 0, 2, 0, 0, 2]).
Aceptada.

?- aceptar([0, 1, 2, 1, 0, 0, 2]).
Aceptada.

%  Rechazadas: por alguna de las siguientes razones:
% - No hay un 1 antes que un 2
% - No termina en [0,0,2]
% - Transiciones inválidas según el autómata

?- aceptar([0, 0, 2]).
Rechazada: transición inválida.    % No hay ningún 1 antes del primer 2

?- aceptar([2, 0, 0, 2]).
Rechazada: transición inválida.    % Empieza directamente con un 2

?- aceptar([1, 0, 0, 1, 2]).
Rechazada: no termina en 002

?- aceptar([1, 1, 1, 1, 2]).
Rechazada: no termina en 002

?- aceptar([0, 0, 0, 0, 2]).
Rechazada: no hay un 1 antes del 2

?- aceptar([1, 0, 2]).
Rechazada: no termina en 002

?- aceptar([1, 2, 0, 1, 2, 1, 2, 1, 0, 1, 0, 1, 0, 0, 1, 2, 0, 0, 2]).
Rechazada: contiene subtransiciones inválidas en medio

