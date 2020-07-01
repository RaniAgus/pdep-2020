
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
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

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

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).


% PARTE A

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
    jugador(Jugador),
    estaEnContinente(Jugador, Continente),
    forall(
        ocupa(Pais,Jugador,_),
        estaEn(Continente,Pais)
    ).

estaEnContinente(Jugador, Continente):-
    jugador(Jugador),
    continente(Continente),
    ocupa(Pais,Jugador,_),
    estaEn(Continente,Pais).

:- begin_tests(teg).

test(jugador_sin_pais_lo_liquidaron, nondet) :-
    loLiquidaron(blanco).
test(jugador_con_pais_no_lo_liquidaron, fail) :-
    loLiquidaron(magenta).

test(jugador_con_todos_los_paises_ocupa_continente, nondet) :-
    ocupaContinente(amarillo,americaDelNorte).
test(jugador_sin_todos_los_paises_no_ocupa_continente, fail) :-
    ocupaContinente(amarillo,asia).

test(jugador_solo_en_un_continente_se_atrinchero, nondet) :-
    seAtrinchero(magenta).
test(jugador_en_varios_continentes_no_se_atrinchero, fail) :-
    seAtrinchero(amarillo).

:- end_tests(teg). 

%% PARTE B

/* 4. puedeConquistar/2 que relaciona un jugador y un continente si no ocupa dicho continente,
pero todos los países del mismo que no tiene son limítrofes a alguno que ocupa y a su vez ese
país no es de un aliado.

puedeConquistar(Jugador,Continente):-
    jugador(Jugador),
    continente(Continente),
    not(ocupaContinente(Jugador,Continente)),
    forall(
        estaEn(Continente,Pais),
        puedeOcupar(Jugador,Pais)
    ).

puedeOcupar(Jugador,Pais):-
    jugador(Jugador),
    ocupa(Pais,Jugador,_).
puedeOcupar(Jugador,Pais):-
    jugador(Jugador),
    not(paisAliado(Jugador,Pais)),
    ocupa(OtroPais,Jugador,_),
    sonLimitrofes(Pais,OtroPais).

paisAliado(Jugador,Pais):-
    jugador(Jugador),
    aliados(Jugador,Aliado),
    ocupa(Pais,Aliado,_).

*/
