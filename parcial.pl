/*
Nombre: Ranieri, Agustin Ezequiel
Legajo: 167755-0
*/

/* Se tiene la siguiente base de conocimientos: */

herramienta(ana, circulo(50,3)).
herramienta(ana, cuchara(40)).
herramienta(beto, circulo(20,1)).
herramienta(beto, libro(inerte)).
herramienta(cata, libro(vida)).
herramienta(cata, circulo(100,5)).

% Los círculos alquímicos tienen diámetro en cms y cantidad de niveles.
% Las cucharas tienen una longitud en cms.
% Hay distintos tipos de libro.

persona(Persona):-
    herramienta(Persona,_).

/* 1. Modelar los jugadores y elementos y agregarlos a la base de conocimiento, utilizando los 
ejemplos provistos. */

% Ana tiene agua, vapor, tierra y hierro.

tiene(ana, agua).
tiene(ana, vapor).
tiene(ana, tierra).
tiene(ana, hierro).

% Beto tiene lo mismo que Ana.
tiene(beto,Elemento):- tiene(ana, Elemento).

% Cata tiene fuego, tierra, agua y aire, pero no tiene vapor.
tiene(cata, fuego).
tiene(cata, tierra).
tiene(cata, agua).
tiene(cata, aire).
% "Cata no tiene vapor" se cumple por principio de universo cerrado

% Para construir pasto hace falta agua y tierra.
seConstruyeCon(pasto, agua).
seConstruyeCon(pasto, tierra).

% Para construir hierro hace falta fuego, agua y tierra.
seConstruyeCon(hierro, fuego).
seConstruyeCon(hierro, agua).
seConstruyeCon(hierro, tierra).

% Para hacer huesos hace falta pasto y agua.
seConstruyeCon(huesos, pasto).
seConstruyeCon(huesos, agua).

% Para hacer presión hace falta hierro y vapor (que se construye con agua y fuego).
seConstruyeCon(presion, hierro).
seConstruyeCon(presion, vapor).

seConstruyeCon(vapor, agua).
seConstruyeCon(vapor, fuego).

% Para hacer una playstation hace falta silicio (que se construye sólo con tierra), 
% hierro y plástico (que se construye con huesos y presión).
seConstruyeCon(playstation, silicio).
seConstruyeCon(playstation, hierro).
seConstruyeCon(playstation, plastico).

seConstruyeCon(silicio, tierra).

seConstruyeCon(plastico, huesos).
seConstruyeCon(plastico, presion).

/* 2- Saber si un jugador tieneIngredientesPara construir un elemento, que es cuando tiene en su 
inventario todo lo que hace falta. */

tieneIngredientesPara(Persona, Elemento):-
    persona(Persona),
    seConstruyeCon(Elemento, _),
    forall(seConstruyeCon(Elemento, Ingrediente), tiene(Persona, Ingrediente)).

% Por ejemplo, ana tiene los ingredientes para el pasto, pero no para el vapor.

:- begin_tests(tiene_ingredientes_para_tests).
    test(jugador_tiene_ingredientes, nondet):-
        tieneIngredientesPara(ana, pasto).
    test(jugador_no_tiene_ingredientes, fail):-
        tieneIngredientesPara(ana, vapor).
    test(tiene_ingredientes_para_es_inversible_para_personas,
        set(Personas == [ana, beto, cata])
    ):-
        tieneIngredientesPara(Personas, silicio).
    test(tiene_ingredientes_para_es_inversible_para_elementos,
        set(Elementos == [pasto, presion, silicio])
    ):-
    tieneIngredientesPara(ana, Elementos).
:- end_tests(tiene_ingredientes_para_tests).

/* 3- Saber si un elemento estaVivo. Se sabe que el agua, el fuego y todo lo que fue construido a 
partir de ellos, están vivos. */

estaVivo(agua).
estaVivo(fuego).
estaVivo(Elemento):-
    seConstruyeCon(Elemento, OtroElemento),
    estaVivo(OtroElemento).

% Debe funcionar para cualquier nivel. Por ejemplo, la play station y los huesos están vivos, 
% pero el silicio no.

:- begin_tests(esta_vivo_tests).
    test(esta_vivo_es_inversible, 
        set(Elementos == [agua, fuego, pasto, hierro, huesos, presion, vapor, playstation, plastico])
    ):-
        estaVivo(Elementos).
:- end_tests(esta_vivo_tests).

/*
4- Conocer las personas que puedeConstruir un elemento, para lo que se necesita tener los ingredientes 
ahora en el inventario y además contar con una o más herramientas que sirvan para construirlo. 

Por ejemplo, beto puede construir el silicio (porque tiene tierra y tiene el libro inerte, que le 
sirve para el silicio), pero no puede construir la presión (porque a pesar de tener hierro y vapor, 
no cuenta con herramientas que le sirvan para la presión). Ana, por otro lado, sí puede construir 
silicio y presión.
*/

puedeConstruir(Persona, Elemento):-
    tieneIngredientesPara(Persona, Elemento),
    tieneHerramientasPara(Persona, Elemento).

tieneHerramientasPara(Persona, Elemento):-
    herramienta(Persona, Herramienta),
    fabricaElemento(Herramienta, Elemento).

% Para los elementos vivos sirve el libro de la vida (y para los elementos no vivos el libro inerte).
fabricaElemento(libro(vida), Elemento):- 
    estaVivo(Elemento).
fabricaElemento(libro(inerte), Elemento):- 
    not(estaVivo(Elemento)).

% Además, las cucharas y círculos sirven cuando soportan la cantidad de ingredientes del elemento 
cuantosIngredientesRequiere(Elemento, Cantidad):-
    findall(Ingrediente,seConstruyeCon(Elemento, Ingrediente), Ingredientes),
    length(Ingredientes, Cantidad).  

% Las cucharas soportan tantos ingredientes como centímetros/10
fabricaElemento(cuchara(Cms), Elemento):-
    cuantosIngredientesRequiere(Elemento, Cantidad),
    Cantidad < Cms / 10.
% Los círculos alquímicos soportan tantos ingredientes como metros * cantidad de niveles).

 
