% Aquí escribir los predicados.
viveEn(tiaAgatha, dreadbury).
viveEn(carnicero, dreadbury).
viveEn(charles, dreadbury).

odiaA(charles,Odiado):-
    viveEn(Odiado, dreadbury),
    not(odiaA(tiaAgatha, Odiado)).

odiaA(tiaAgatha, Odiado):-
    viveEn(Odiado, dreadbury),
    Odiado \= carnicero.

odiaA(carnicero, Odiado):-
    odiaA(tiaAgatha,Odiado).

masRicoQue(Odiado,tiaAgatha):-
    viveEn(Odiado, dreadbury),
    not(odiaA(carnicero,Odiado)).

mataA(Asesino, Victima):-
    odiaA(Asesino, Victima),
    not(masRicoQue(Asesino, Victima)).

/*
1. El programa debe resolver el problema de quién mató a la tía Agatha.
Mostrar la consulta utilizada y la respuesta obtenida.

 ?- mataA(Asesino, tiaAgatha).
Asesino = tiaAgatha ;
false.

2. Agregar los mínimos hechos y reglas necesarios para poder consultar:

- Si existe alguien que odie a milhouse.

?- odiaA(_, milhouse).
false.

- A quién odia charles.

?- odiaA(charles, Odiado).
Odiado = carnicero ;
false.

- El nombre de quien odia a agatha.

?- odiaA(Odiador, tiaAgatha).
Odiador = tiaAgatha ;
Odiador = carnicero.

- Todos los odiadores y sus odiados.

?- odiaA(Odiador, Odiado).
Odiador = charles,
Odiado = carnicero ;
Odiador = Odiado, Odiado = tiaAgatha ;
Odiador = tiaAgatha,
Odiado = charles ;
Odiador = carnicero,
Odiado = tiaAgatha ;
Odiador = carnicero,
Odiado = charles.

- Si es cierto que el carnicero odia a alguien.

?- odiaA(carnicero, _).
true .

*/