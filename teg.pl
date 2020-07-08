
continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania, australia).
estaEn(oceania, sumatra).
estaEn(oceania, java).
estaEn(oceania, borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina, brasil).
limitrofes(argentina, chile).
limitrofes(argentina, uruguay).
limitrofes(uruguay, brasil).
limitrofes(alaska, kamtchatka).
limitrofes(alaska, yukon).
limitrofes(canada, yukon).
limitrofes(alaska, oregon).
limitrofes(canada, oregon).
limitrofes(siberia, kamtchatka).
limitrofes(siberia, china).
limitrofes(china, kamtchatka).
limitrofes(japon, china).
limitrofes(japon, kamtchatka).
limitrofes(australia, sumatra).
limitrofes(australia, java).
limitrofes(australia, borneo).
limitrofes(australia, chile).


/*
  ____            _            _    
 |  _ \ __ _ _ __| |_ ___     / \   
 | |_) / _` | '__| __/ _ \   / _ \  
 |  __/ (_| | |  | ||  __/  / ___ \ 
 |_|   \__,_|_|   \__\___| /_/   \_\

*/

% 1. loLiquidaron/1 que se cumple para un jugador si no ocupa ningún país.
loLiquidaron(Jugador):-
    jugador(Jugador),
    not(ocupa(_,Jugador,_)).

% 2. ocupaContinente/2 que relaciona un jugador y un continente si el jugador ocupa todos los países del mismo.
ocupaContinente(Jugador,Continente):-
    jugador(Jugador),
    continente(Continente),
    forall(
        estaEn(Continente,Pais),
        ocupa(Pais,Jugador,_)
    ).

% 3. seAtrinchero/1 que se cumple para los jugadores que ocupan países en un único continente.
seAtrinchero(Jugador):-
    estaEnContinente(Jugador,Continente),
    forall(
        ocupa(Pais,Jugador,_),
        estaEn(Continente,Pais)
    ).

estaEnContinente(Jugador,Continente):-
    jugador(Jugador),
    continente(Continente),
    ocupa(Pais,Jugador,_),
    estaEn(Continente,Pais).

/*
  _____         _       
 |_   _|__  ___| |_ ___ 
   | |/ _ \/ __| __/ __|
   | |  __/\__ \ |_\__ \
   |_|\___||___/\__|___/

*/

:- begin_tests(lo_liquidaron).

    test(jugador_sin_pais_lo_liquidaron, nondet) :-
        loLiquidaron(blanco).
    test(jugador_con_pais_no_lo_liquidaron, fail) :-
        loLiquidaron(magenta).

:- end_tests(lo_liquidaron). 


:- begin_tests(ocupa_continente).

    test(jugador_con_todos_los_paises_ocupa_continente, nondet) :-
        ocupaContinente(negro,oceania).
    test(jugador_sin_todos_los_paises_no_ocupa_continente, fail) :-
        ocupaContinente(amarillo,asia).

:- end_tests(ocupa_continente). 


:- begin_tests(se_atrinchero).

    test(jugador_solo_en_un_continente_se_atrinchero, nondet) :-
        seAtrinchero(magenta).
    test(jugador_en_varios_continentes_no_se_atrinchero, fail) :-
        seAtrinchero(amarillo).

:- end_tests(se_atrinchero). 

/*
  ____            _         ____  
 |  _ \ __ _ _ __| |_ ___  | __ ) 
 | |_) / _` | '__| __/ _ \ |  _ \ 
 |  __/ (_| | |  | ||  __/ | |_) |
 |_|   \__,_|_|   \__\___| |____/ 
                                  
*/

/* 4. puedeConquistar/2 que relaciona un jugador y un continente si no ocupa dicho continente,
pero todos los países del mismo que no tiene son limítrofes a alguno que ocupa y a su vez ese
país no es de un aliado.
*/

puedeConquistar(Jugador,Continente):-
    jugador(Jugador),
    continente(Continente),
    not(ocupaContinente(Jugador,Continente)),
    forall(
        (   estaEn(Continente,Pais),  
        not(ocupa(Pais,Jugador,_))  ),
        puedeOcupar(Jugador,Pais)
    ).

puedeOcupar(Jugador,Pais):-
    not(paisAliado(Jugador,Pais)),
    ocupaLimitrofe(Jugador,Pais).

paisAliado(Jugador,Pais):-
    aliados(Jugador,Aliado),
    ocupa(Pais,Aliado,_).

ocupaLimitrofe(Jugador,Pais):-
    ocupa(OtroPais,Jugador,_),
    sonLimitrofes(Pais,OtroPais).

/*
5. elQueTieneMasEjercitos/2 que relaciona un jugador y un país si se cumple que es en ese país 
que hay más ejércitos que en los países del resto del mundo y a su vez ese país es ocupado por
ese jugador. 
*/

elQueTieneMasEjercitos(Jugador,Pais):-
    jugador(Jugador),
    ocupa(Pais,Jugador,Tropas),
    forall(
        (   ocupa(OtroPais,Jugador,OtrasTropas),
            OtroPais \= Pais                    ),
        Tropas >= OtrasTropas
    ).

%% 6. Se agrega lo siguiente a la base de conocimiento:

objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo, ocuparPaises(2,americaDelSur)). 
objetivo(blanco, destruirJugador(negro)). 
objetivo(magenta, destruirJugador(blanco)). 
objetivo(negro, ocuparContinente(oceania)).
objetivo(negro, ocuparContinente(americaDelSur)). 

cuantosPaisesOcupaEn(Jugador,Continente,Cantidad):-
    jugador(Jugador),
    continente(Continente),
    findall(Pais,(ocupa(Pais,Jugador,_),estaEn(Continente,Pais)),Paises),
    length(Paises,Cantidad).

/* 
7. cumpleObjetivos/1 que se cumple para un jugador si cumple todos los objetivos que tiene.
Los objetivos se cumplen de la siguiente forma:
- ocuparContinente: el jugador debe ocupar el continente indicado
- ocuparPaises: el jugador debe ocupar al menos la cantidad de países indicada de ese continente
- destruirJugador: se cumple si el jugador indicado ya no ocupa ningún país
*/

cumpleObjetivos(Jugador):-
    jugador(Jugador),
    forall(objetivo(Jugador,Objetivo), seCumple(Jugador,Objetivo)).

seCumple(Jugador,ocuparContinente(Continente)):-
    ocupaContinente(Jugador, Continente).
seCumple(_,destruirJugador(Jugador)):-
    loLiquidaron(Jugador).
seCumple(Jugador,ocuparPaises(Cantidad,Continente)):-
    cuantosPaisesOcupaEn(Jugador,Continente,Ocupados),
    Ocupados >= Cantidad.

/*
8. leInteresa/2 que relaciona un jugador y un continente, y es cierto cuando alguno de sus 
objetivos implica hacer algo en ese continente (en el caso de destruirJugador, si el jugador 
a destruir ocupa algún país del continente).
*/

leInteresa(Jugador,Continente):-
    continente(Continente),
    objetivo(Jugador,Objetivo),
    not(seCumple(Jugador,Objetivo)),
    interesaContinente(Continente,Objetivo).

interesaContinente(Continente,ocuparContinente(Continente)).
interesaContinente(Continente,destruirJugador(Jugador)):-
    cuantosPaisesOcupaEn(Jugador,Continente,Cantidad),
    Cantidad > 0.
interesaContinente(Continente,ocuparPaises(_,Continente)).

/*
  _____         _       
 |_   _|__  ___| |_ ___ 
   | |/ _ \/ __| __/ __|
   | |  __/\__ \ |_\__ \
   |_|\___||___/\__|___/

*/

:- begin_tests(puede_conquistar).

    test(jugador_no_puede_conquistar_continente_ya_ocupado, fail) :-
        puedeConquistar(negro,oceania).
    test(jugador_no_puede_conquistar_paises_aliados, fail) :-
        puedeConquistar(magenta,americaDelSur).
    test(jugador_no_puede_conquistar_continente_sin_limitrofes, fail) :-
        puedeConquistar(negro,americaDelSur).
    test(jugador_puede_conquistar_continente, nondet) :-
        puedeConquistar(negro,asia).

:- end_tests(puede_conquistar). 


:- begin_tests(el_que_tiene_mas_ejercitos).

    test(pais_no_es_el_que_tiene_mas_ejercitos, fail) :-
        elQueTieneMasEjercitos(amarillo,brasil).
    test(pais_es_el_que_tiene_mas_ejercitos, nondet) :-
        elQueTieneMasEjercitos(amarillo,canada).

:- end_tests(el_que_tiene_mas_ejercitos). 


:- begin_tests(cumple_objetivos).

    test(jugador_cumple_algun_objetivo_pero_no_todos, fail) :-
        cumpleObjetivos(negro).
    test(jugador_cumple_objetivos, nondet) :-
        cumpleObjetivos(magenta).

    test(no_se_cumple_ocupar_paises, fail) :-
        seCumple(magenta,ocuparPaises(3,americaDelSur)).
    test(se_cumple_ocupar_paises, nondet) :-
        seCumple(magenta,ocuparPaises(2,americaDelSur)).

:- end_tests(cumple_objetivos). 


:- begin_tests(le_interesa).

    test(continente_no_le_interesa_a_jugador_que_cumplio_objetivos, fail) :-
        leInteresa(magenta,_).
    test(continente_no_le_interesa_a_jugador_sin_objetivos_alli, fail) :-
        leInteresa(negro,asia).
    test(continente_le_interesa_a_jugador, nondet) :-
        leInteresa(negro,americaDelSur).

:- end_tests(le_interesa). 