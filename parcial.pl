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

persona(Persona):-
    herramienta(Persona,_).

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

/* 4- Conocer las personas que puedeConstruir un elemento, para lo que se necesita tener los 
ingredientes ahora en el inventario y además contar con una o más herramientas que sirvan para 
construirlo. */

puedeConstruir(Persona, Elemento):-
    tieneIngredientesPara(Persona, Elemento),
    tieneHerramientasPara(Persona, Elemento).

tieneHerramientasPara(Persona, Elemento):-
    herramienta(Persona, Herramienta),
    herramientaFabricaElemento(Herramienta, Elemento).

% Las cucharas y círculos sirven cuando soportan la cantidad de ingredientes del elemento 
cuantosIngredientesRequiere(Elemento, Cantidad):-
    findall(Ingrediente,seConstruyeCon(Elemento, Ingrediente), Ingredientes),
    length(Ingredientes, Cantidad).  

% Las cucharas soportan tantos ingredientes como centímetros/10
herramientaFabricaElemento(cuchara(Cms), Elemento):-
    cuantosIngredientesRequiere(Elemento, Cantidad),
    Cantidad =< Cms / 10.
% Los círculos alquímicos soportan tantos ingredientes como metros * cantidad de niveles).
herramientaFabricaElemento(circulo(Cms, Niveles), Elemento):-
    cuantosIngredientesRequiere(Elemento, Cantidad),
    Cantidad =< Cms / 100 * Niveles.
% Para los elementos vivos sirve el libro de la vida (y para los elementos no vivos el libro inerte).
herramientaFabricaElemento(libro(vida), Elemento):- 
    estaVivo(Elemento).
herramientaFabricaElemento(libro(inerte), Elemento):- 
    not(estaVivo(Elemento)).

/* Por ejemplo, beto puede construir el silicio (porque tiene tierra y tiene el libro inerte, que le 
sirve para el silicio), pero no puede construir la presión (porque a pesar de tener hierro y vapor, 
no cuenta con herramientas que le sirvan para la presión). Ana, por otro lado, sí puede construir 
silicio y presión. */

:- begin_tests(puede_construir_tests).
    test(puede_construir_con_libro_inerte, nondet):-
        puedeConstruir(beto, silicio).
    test(no_puede_construir_sin_herramienta, fail):-
        puedeConstruir(beto, presion).
    test(puede_construir_inversible_para_elementos, 
        set(Elementos == [pasto,presion,silicio])
    ):-
        puedeConstruir(ana, Elementos).
    test(puede_construir_inversible_para_personas, 
    set(Personas == [ana, cata])
    ):-
        puedeConstruir(Personas, pasto).
    test(cuchara_fabrica_elemento, nondet):-
        herramientaFabricaElemento(cuchara(30), hierro).
    test(cuchara_no_fabrica_elemento, fail):-
        herramientaFabricaElemento(cuchara(29), hierro).
    test(circulo_fabrica_elemento, nondet):-
        herramientaFabricaElemento(circulo(100,3), hierro).
    test(circulo_no_fabrica_elemento, fail):-
        herramientaFabricaElemento(circulo(99,3), hierro).

:- end_tests(puede_construir_tests).


/* 5- Saber si alguien es todopoderoso, que es cuando tiene todos los elementos primitivos (los 
que no pueden construirse a partir de nada) y además cuenta con herramientas que sirven para 
construir cada elemento que no tenga. */

esTodopoderoso(Persona):-
    persona(Persona),
    forall(elementoPrimitivo(Elemento),tiene(Persona,Elemento)),
    forall(
        ( seConstruyeCon(Elemento,_), not(tiene(Persona,Elemento)) ),
        tieneHerramientasPara(Persona, Elemento)
    ).

elementoPrimitivo(Elemento):-
    elemento(Elemento),
    not(seConstruyeCon(Elemento,_)).

elemento(Elemento):-
    seConstruyeCon(_,Elemento).
elemento(Elemento):-
    tiene(_,Elemento).

% Por ejemplo, cata es todopoderosa, pero beto no.

:- begin_tests(es_todopoderoso_tests).
    test(es_todopoderoso_es_inversible, set(Personas == [cata])):-
        esTodopoderoso(Personas).
    test(no_es_todopoderoso, fail):-
        esTodopoderoso(beto).
    test(elementos_primitivos, set(Primitivos == [agua,fuego,tierra,aire])):-
        elementoPrimitivo(Primitivos).
:- end_tests(es_todopoderoso_tests).

% 6. Conocer quienGana, que es quien puede construir más cosas.
quienGana(Persona):-
    cuantosPuedeConstruir(Persona, Cantidad),
    forall(
        (cuantosPuedeConstruir(OtraPersona, OtraCantidad), Persona \= OtraPersona),
        OtraCantidad < Cantidad
    ).

cuantosPuedeConstruir(Persona, Cantidad):-
    persona(Persona),
    findall(Elemento, puedeConstruir(Persona, Elemento), ElementosConDuplicados),
    sort(ElementosConDuplicados, Elementos),
    length(Elementos, Cantidad).

% Por ejemplo, cata gana, pero beto no.
:- begin_tests(quien_gana_tests).
    test(quien_gana_es_inversible, set(Personas == [cata])):-
        esTodopoderoso(Personas).
    test(no_gana, fail):-
        esTodopoderoso(beto).
    test(cuantos_puede_construir, nondet):-
        cuantosPuedeConstruir(cata, 4).
:- end_tests(quien_gana_tests).

% 7. En la línea 32: "Cata no tiene vapor" se cumple por principio de universo cerrado.

/* 8- Hacer una nueva versión del predicado puedeConstruir (se puede llamar puedeLlegarATener) 
para considerar todo lo que podría construir si va combinando todos los elementos que tiene 
(y siempre y cuando tenga alguna herramienta que le sirva para construir eso). Un jugador puede 
llegar a tener un elemento si o bien lo tiene, o bien tiene alguna herramienta que le sirva para 
hacerlo y cada ingrediente necesario para construirlo puede llegar a tenerlo a su vez. */

puedeLlegarATener(Persona, Elemento):-
    tiene(Persona, Elemento).
puedeLlegarATener(Persona, Elemento):-
    puedeTenerIngredientesPara(Persona, Elemento),
    tieneHerramientasPara(Persona, Elemento).

puedeTenerIngredientesPara(Persona, Elemento):-
    tieneIngredientesPara(Persona, Elemento).
puedeTenerIngredientesPara(Persona, Elemento):-
    forall(seConstruyeCon(Elemento, Ingrediente), puedeTenerIngredientesPara(Persona, Ingrediente)).

% Por ejemplo, cata podría llegar a tener una playstation, pero beto no.

:- begin_tests(puede_llegar_a_tener_tests).
    test(cata_puede_llegar_a_tener_todo, 
        set(Elementos == [fuego, tierra, agua, aire, pasto, hierro, vapor, silicio, huesos, presion, playstation, plastico])
    ):-
        puedeLlegarATener(cata, Elementos).
    test(persona_no_puede_llegar_a_tener_elemento, fail):-
        puedeLlegarATener(beto, playstation).
:- end_tests(puede_llegar_a_tener_tests).