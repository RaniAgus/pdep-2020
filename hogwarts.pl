% Parte 1 - Sombrero Seleccionador

/*      -------------------------------------------------------------------------------------------
        | Sangre    | Corajudo | Amistoso | Orgulloso | Inteligente | Responsable   | Odiaría     |
-------------------------------|----------|-----------|-------------|---------------|-------------|
Harry   | Mestiza   |    X     |    X     |     X     |      X      |               | Slytherin   |
Draco   | Pura      |          |          |     X     |      X      |               | Hufflepuff  |
Hermoine| Impura    |          |          |     X     |      X      |      X        |     -       |
---------------------------------------------------------------------------------------------------
- Para Gryffindor, lo más importante es tener coraje.
- Para Slytherin, lo más importante es el orgullo y la inteligencia.
- Para Ravenclaw, lo más importante es la inteligencia y la responsabilidad.
- Para Hufflepuff, lo más importante es ser amistoso.
*/

mago(harry,mestiza).
mago(draco,pura).
mago(hermoine,impura).
mago(neville,pura).

caracter(harry,coraje).
caracter(harry,amistoso).
caracter(harry,orgullo).
caracter(harry,inteligencia).

caracter(draco,orgullo).
caracter(draco,inteligencia).

caracter(hermoine,inteligencia).
caracter(hermoine,orgullo).
caracter(hermoine,responsabilidad).

caracter(neville,responsabilidad).
caracter(neville,amistoso).
caracter(neville,coraje).

odiaria(harry,slytherin).
odiaria(draco,hufflepuff).

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

caracteristicaBuscada(gryffindor, coraje).
caracteristicaBuscada(slytherin, orgullo).
caracteristicaBuscada(slytherin, inteligencia).
caracteristicaBuscada(ravenclaw, inteligencia).
caracteristicaBuscada(ravenclaw, responsabilidad).
caracteristicaBuscada(hufflepuff, amistoso).

% 1- Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago y cualquier 
% casa excepto en el caso de Slytherin, que no permite entrar a magos de sangre impura.

permiteEntrar(slytherin,Mago):-
    mago(Mago,Sangre),
    Sangre \= impura.
permiteEntrar(Casa,Mago):-
    casa(Casa),
    mago(Mago,_),
    Casa \= slytherin.

% 2- Saber si un mago tiene el carácter apropiado para una casa, lo cual se cumple para cualquier 
% mago si sus características incluyen todo lo que se busca para los integrantes de esa casa, 
% independientemente de si la casa le permite la entrada.

tieneCaracterApropiado(Mago, Casa):-
    casa(Casa),
    mago(Mago,_),
    forall(caracteristicaBuscada(Casa,Caracter), caracter(Mago,Caracter)).

% 3- Determinar en qué casa podría quedar seleccionado un mago sabiendo que tiene que tener el 
% carácter adecuado para la casa, la casa permite su entrada y además el mago no odiaría que lo 
% manden a esa casa. Además Hermione puede quedar seleccionada en Gryffindor, porque al parecer 
% encontró una forma de hackear al sombrero.

podriaQuedar(Mago, Casa):-
    tieneCaracterApropiado(Mago,Casa),
    permiteEntrar(Casa, Mago),
    not(odiaria(Mago,Casa)).
podriaQuedar(hermoine,gryffindor).

% 4- Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos
% se caracterizan por ser amistosos y cada uno podría estar en la misma casa que el siguiente. No
% hace falta que sea inversible, se consultará de forma individual.

cadenaDeAmistades(Magos):-
    forall(member(Mago,Magos), caracter(Mago,amistoso)),
    cadenaDeCasas(Magos).

cadenaDeCasas([Mago1,Mago2|Amigos]):-
    podriaQuedar(Mago1, Casa),
    podriaQuedar(Mago2, Casa),
    cadenaDeCasas([Mago2|Amigos]).
cadenaDeCasas([_]).

% Parte 2 - La copa de las casas

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

%    Harry anduvo fuera de cama.
accion(harry, fueraDeCama).
%    Hermione fue al tercer piso y a la sección restringida de la biblioteca.
accion(hermione, irA(tercerPiso)).
accion(hermione, irA(seccionRestringida)).
%    Harry fue al bosque y al tercer piso.
accion(harry, irA(bosque)).
accion(harry, irA(tercerPiso)).
%    Draco fue a las mazmorras.
accion(draco, irA(mazmorras)).
%    A Ron le dieron 50 puntos por su buena acción de ganar una partida de ajedrez mágico.
accion(ron, buenaAccion(ajedrezMagico, 50)).
%    A Hermione le dieron 50 puntos por usar su intelecto para salvar a sus amigos de una muerte horrible.
accion(hermione, buenaAccion(salvarAmigos, 50)).
%    A Harry le dieron 60 puntos por ganarle a Voldemort.
accion(harry, buenaAccion(derrotarVoldemort, 60)).

/* PUNTO 4: Hermione respondió a la pregunta de dónde se encuentra un Bezoar, de 
dificultad 20, realizada por el profesor Snape, y cómo hacer levitar una pluma, de dificultad 
25, realizada por el profesor Flitwick.*/
accion(hermione,responderPregunta(dondeEncontrarUnBezoar,20,snape)).
accion(hermione,responderPregunta(comoHacerLevitarUnaPluma,25,flitwick)).

/*
    El bosque, que resta 50 puntos.
    La sección restringida de la biblioteca, que resta 10 puntos.
    El tercer piso, que resta 75 puntos.
*/
malaAccion(fueraDeCama, -50).
malaAccion(irA(Lugar), Puntaje):-
    lugarProhibido(Lugar, Puntaje).

lugarProhibido(bosque, -50).
lugarProhibido(seccionRestringida, -10).
lugarProhibido(tercerPiso, -75).

% 1- a. Saber si un mago es buen alumno, que se cumple si hizo alguna acción y ninguna de las cosas 
% que hizo se considera una mala acción (que son aquellas que provocan un puntaje negativo).

esBuenAlumno(Mago):-
    accion(Mago,_),
    forall(accion(Mago,Accion),not(malaAccion(Accion,_))).

% b- Saber si una acción es recurrente, que se cumple si más de un mago hizo esa misma acción.

accionRecurrente(Accion):-
    accion(Mago1, Accion),
    accion(Mago2, Accion),
    Mago1 \= Mago2.

% 2- Saber cuál es el puntaje total de una casa, que es la suma de los puntos obtenidos por sus 
% miembros.

puntajeGenerado(Accion, Puntaje):-
    malaAccion(Accion, Puntaje).
puntajeGenerado(buenaAccion(_, Puntaje), Puntaje).
/* PUNTO 4: los puntos que se otorgan equivalen a la dificultad de la pregunta, a menos que la 
haya hecho Snape, que da la mitad de puntos en relación a la dificultad de la pregunta. */
puntajeGenerado(responderPregunta(_,Puntaje, Profesor), Puntaje):-
    Profesor \= snape.
puntajeGenerado(responderPregunta(_,Dificultad, snape), Puntaje):-
    Puntaje is Dificultad / 2.

puntajeTotal(Casa, PuntajeTotal):-
    esDe(_,Casa),
    findall(PuntajeAccion,
        ( esDe(Mago,Casa), accion(Mago, Accion), puntajeGenerado(Accion, PuntajeAccion) ),
        Puntajes),
    sum_list(Puntajes, PuntajeTotal).
    
% 3- Saber cuál es la casa ganadora de la copa, que se verifica para aquella casa que haya obtenido 
% una cantidad mayor de puntos que todas las otras.

casaGanadora(Casa):-
    puntajeTotal(Casa,Puntaje),
    forall((puntajeTotal(OtraCasa, OtroPuntaje), Casa \= OtraCasa), Puntaje > OtroPuntaje).

/* 4- Queremos agregar la posibilidad de ganar puntos por responder preguntas en clase. La 
información que nos interesa de las respuestas en clase son: cuál fue la pregunta, cuál es la 
dificultad de la pregunta y qué profesor la hizo.

Respuesta copiada arriba para no recibir warnings: Líneas 125 y 163. */

