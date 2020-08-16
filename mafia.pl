% rol(Persona, Rol).
rol(homero, civil).
rol(burns, civil).
rol(bart, mafia).
rol(tony, mafia).
rol(maggie, mafia).
rol(nick, medico).
rol(hibbert, medico).
rol(lisa, detective).
rol(rafa, detective).

/*********************************************************************************************
1) RONDAS (ambos integrantes)
El moderador nos contó que el juego se desarrolla por rondas, donde cada persona que sigue 
en juego ejecuta una acción, que puede ser una de las siguientes

- Atacar una persona: nos interesa quién es la persona atacada. En cada ronda la mafia elige
una persona a quién atacar.
- Salvar una persona: nos interesa saber la persona salvada y el médico que lo salva. En cada
ronda cada médico elige una persona a quién salvar en caso de que la mafia la ataque.
- Investigar a una persona: nos interesa conocer tanto el detective como a la persona que está
investigando. En cada ronda cada detective investiga a una persona para saber si es parte de 
la mafia o no.
- Eliminar a una persona: solamente se necesita el nombre de la persona eliminada. Al finalizar
la ronda, todas las personas que siguen en juego debaten y eligen una persona para eliminar del
juego.

Modelar las acciones anteriores de forma tal que se pueda: */

/* a. Expandir la base de conocimiento agregando información de las acciones que se produjeron 
en cada ronda. */
accion(1,atacar(lisa)).
accion(1,salvar(nick,nick)).
accion(1,salvar(hibbert,lisa)).
accion(1,investigar(lisa,tony)).
accion(1,investigar(rafa,lisa)).
accion(1,eliminar(nick)).

accion(2,atacar(rafa)).
accion(2,salvar(hibbert,rafa)).
accion(2,investigar(lisa,bart)).
accion(2,investigar(rafa,maggie)).
accion(2,eliminar(rafa)).

accion(3,atacar(lisa)).
accion(3,salvar(hibbert,lisa)).
accion(3,investigar(lisa,burns)).
accion(3,eliminar(hibbert)).

accion(4,atacar(homero)).
accion(4,investigar(lisa,homero)).
accion(4,eliminar(tony)).

accion(5,atacar(lisa)).
accion(5,investigar(lisa,maggie)).
accion(5,eliminar(bart)).

accion(6,atacar(burns)).

/* b. Deducir las personas que perdieron en una determinada ronda. O sea, aquellas que fueron:
- eliminadas en dicho ronda, ó 
- atacadas por la mafia, salvo que algún médico haya salvado a la persona, en dicha ronda.

Explicar qué conceptos permiten resolver este requerimiento sin la necesidad de armar listas. */
perdio(Ronda, Persona):-
    rol(Persona,_),
    loEliminaron(Ronda,Persona).

loEliminaron(Ronda,Persona):-
    accion(Ronda,eliminar(Persona)).
loEliminaron(Ronda,Persona):-
    accion(Ronda,atacar(Persona)),
    not(accion(Ronda,salvar(_,Persona))).

/* c. Casos de prueba */
:- begin_tests(rondas_tests).
% Al ser eliminado, la persona pierde en esa ronda (por ejemplo nick pierde en la primera ronda).
test(jugador_eliminado_pierde_en_esa_ronda, nondet):-
    perdio(1,nick).
% Un atacado por la mafia pierde si nadie lo salva (por ejemplo homero en la cuarta ronda).
test(jugador_atacado_pierde_si_no_lo_salvan, nondet):-
    perdio(4,homero).
% Un atacado por la mafia no pierde si alguien lo salva (por ejemplo lisa en la primer ronda).
test(jugador_atacado_no_pierde_si_lo_salvan, fail):-
    perdio(1,lisa).
% A pesar de ser salvado, si te eliminan perdés (por ejemplo rafa en la segunda ronda).
test(jugador_salvado_pierde_si_lo_eliminan, nondet):-
    perdio(2,rafa).
% Si nunca fue eliminada ni atacada, la persona no perdió en ninguna ronda (por ejemplo maggie).
test(jugador_nunca_atacado_no_pierde, fail):-
    perdio(_,maggie).
% En una ronda puede perder más de una persona (por ejemplo en la quinta ronda pierden bart y lisa).
test(pueden_perder_mas_de_uno_en_una_ronda,
    set( Personas == [bart,lisa] )
):-
    perdio(5, Personas).

:- end_tests(rondas_tests).

/*********************************************************************************************
2) GANADOR (integrante 1)
Algo que a todo el mundo le interesa es saber si ya hay un ganador, y en el caso que lo haya saber 
quién es. Nos contaron que existen dos bandos en el juego:
- Por un lado, los integrantes de la mafia.
- Y por el otro, el resto de los jugadores.

El juego termina cuando un bando logra sacar por completo al otro del juego.

Necesitamos: */

/* a. Conocer los contrincantes de una persona, o sea, los del otro bando. Si la persona pertenece
a la mafia, los contrincantes son todos aquellos que no forman parte de la mafia; y viceversa.
Esta  relación debe ser SIMÉTRICA (no importa el orden de los parámetros. Si R(A,B) se cumple,
entonces también R(B,A)). */

contrincantes(X,Y):- contrincante(X,Y).
contrincantes(X,Y):- contrincante(Y,X).

contrincante(Persona,Contrincante):-
    rol(Persona,mafia),
    rol(Contrincante,Rol),
    Rol \= mafia.

/* b. Saber si alguien ganó, y en el caso que haya varios ganadores, conocerlos todos. Una persona 
es ganadora cuando no perdió pero todos sus contrincantes sí.

Explicar cómo se relaciona el concepto de inversibilidad con la solución. 

Rta: Se relaciona en cuanto a que, para conocer todos los ganadores, tengo que poder pasarle a 
la regla un individuo sin matchear, y que Prolog me retorne todos los individuos con los que
se cumple esa regla. Además, dentro de forall, la regla contrincantes/2 debe ser inversible para
encontrar todos los contrincantes de esa persona.
*/
ganador(Persona):-
    rol(Persona,_),
    not(perdio(_,Persona)),
    forall( contrincantes(Persona,Contrincante),
            perdio(_,Contrincante)
    ).


/* c. Casos de prueba. Nota: ¡Los nombres de los tests deben representar su clase de equivalencia! */
:- begin_tests(ganador_tests).
% Los contrincantes de tony (por ser de la mafia) son homero, burns, nick, hibbert, lisa y rafa.
    test(contrincantes_de_uno_que_pertenece_a_la_mafia,
        set(Contrincantes == [homero,burns,nick,hibbert,lisa,rafa])
    ):-
        contrincantes(tony,Contrincantes).
% Los contrincantes de homero (por no ser de la mafia) son bart, tony y maggie.
    test(contrincantes_de_uno_que_no_pertenece_a_la_mafia,
        set(Contrincantes == [bart,tony,maggie])
    ):-
        contrincantes(homero,Contrincantes).
% La única ganadora es maggie.
    test(ganador_es_inversible,
        set(Ganadores == [maggie])
    ):-
        ganador(Ganadores).
:- end_tests(ganador_tests).

/***********************************************************************************************
3. IMBATIBLES (integrante 2)
La mafia se enteró de nuestro sistema y nos pidió información sobre algunos jugadores que considera 
imbatibles para poder planear mejor sus ataques. Nos contaron que:

- Un médico es imbatible cuando siempre salvó a alguien que estaba siendo atacado por la mafia.
- Un detective es imbatible cuando ha investigado a todas las personas que pertenecen a la mafia.
- El resto de las personas nunca son imbatibles.

Se pide: */

/* a. Saber si un jugador es imbatible.

Explicar cómo se relacionan los conceptos de inversibilidad y universo cerrado con la solución.

Rta: En cuanto a la inversibilidad, estamos aprovechando que la regla accion\3 es inversible para
que, en el forall, podamos obtener todas las personas a las que salva un médico en todas las
rondas. Por otro lado, "el resto de las personas nunca son imbatibles" no lleva regla por el 
concepto de universo cerrado.*/

esImbatible(Medico):-
    rol(Medico, medico),
    forall(
      accion(Ronda,salvar(Medico,Salvado)),
      accion(Ronda,atacar(Salvado)) 
    ).
esImbatible(Detective):-
    rol(Detective,detective),
    forall(
        rol(Mafioso, mafia),
        accion(_,investigar(Detective,Mafioso))    
    ).

/* b. Casos de prueba. Nota: ¡Los nombres de los tests deben representar su clase de equivalencia!*/
:- begin_tests(imbatibles_tests).
% hibbert es un médico imbatible.
    test(medico_imbatible, nondet):-
        esImbatible(hibbert).
% nick no es un médico imbatible.
    test(medico_no_imbatible, fail):-
        esImbatible(nick).
% lisa es una detective imbatible.
    test(detective_imbatible, nondet):-
        esImbatible(lisa).
% rafa no es un detective imbatible.
    test(detective_no_imbatible, fail):-
        esImbatible(rafa).
% Homero (por ser civil) nunca es imbatible.
    test(un_civil_nunca_es_imbatible, fail):-
        esImbatible(homero).
:- end_tests(imbatibles_tests).

/*************************************************************************************************
4) MÁS INFO (dividido - evitar repetir lógica)
Nuestro sistema la está pegando y muchos jugadores se nos acercan con nuevos requerimientos, 
algunos con sentido, otros no tanto.

Implementar los predicados necesarios para: */

/* a. (ambos integrantes) Deducir las personas que siguen en juego al comenzar una determinada 
ronda, o sea, las que todavía no perdieron (sin importar si pierde en dicha ronda o posterior). */

sigueEnJuego(Ronda, Persona):-
    rol(Persona,_),
    noPerdio(Ronda, Persona).

noPerdio(Ronda, Persona):-
    perdio(RondaPerdio,Persona),
    RondaPerdio >= Ronda.
noPerdio(_, Persona):-
    not(perdio(_,Persona)).

/* b. (integrante 1) Conocer cuáles son las rondas interesantes que tuvo la partida. Una ronda es 
interesante si en dicha ronda siguen más de 7 personas en juego. También es interesante cuando
quedan en juego menos o igual cantidad de personas que la cantidad inicial de la mafia. */

esInteresante(Ronda):-
    personasEnJuego(Ronda, Cantidad),
    esCantidadInteresante(Cantidad).

personasEnJuego(Ronda, Cantidad):-
    accion(Ronda,_),
    findall(Persona, sigueEnJuego(Ronda,Persona),Personas),
    length(Personas,Cantidad).

esCantidadInteresante(CantPersonas):-
    CantPersonas > 7.
esCantidadInteresante(CantPersonas):-
    personasPorRol(mafia, CantMafiosos),
    CantPersonas =< CantMafiosos.

personasPorRol(Rol, Cantidad):-
    findall(Persona, rol(Persona, Rol), Personas),
    length(Personas,Cantidad).

/* c. (integrante 2) Saber quiénes vivieron el peligro, que son los civiles o detectives que jugaron
alguna ronda peligrosa. Se dice que una ronda es peligrosa cuando la cantidad de personas en juego
es 3 veces la cantidad de civiles con los que empezó la partida. */

vivioElPeligro(Persona):-
    civilODetective(Persona),
    esPeligrosa(Ronda),
    sigueEnJuego(Ronda, Persona).

civilODetective(Persona):-
    rol(Persona,civil).
civilODetective(Persona):-
    rol(Persona,detective).

esPeligrosa(Ronda):-
    personasEnJuego(Ronda, CantPersonas),
    personasPorRol(civil, CantCiviles),
    CantPersonas is 3 * CantCiviles.

/* CASOS DE PRUEBA. Nota: ¡Los nombres de los tests deben representar su clase de equivalencia!*/

% PUNTO A
:- begin_tests(sigue_en_juego_tests).
% rafa sigue jugando en la segunda ronda, por más que pierda luego.
    test(sigue_en_juego_aunque_pierda_en_esa_ronda, nondet):-
        sigueEnJuego(2,rafa).
% nick no sigue jugando en la cuarta ronda, porque perdió antes.
test(no_sigue_en_juego_porque_perdio_rondas_anteriores,fail):-
    sigueEnJuego(4,nick).
% Las personas que llegan hasta la última ronda son maggie y burns.
    test(sigue_en_juego_inversible_para_personas,
        set(Personas == [maggie,burns])
    ):-
        sigueEnJuego(6, Personas).
% Todas las personas en juego juegan la primera ronda.
    test(todos_juegan_la_primera_ronda,
        set(Personas == [maggie,burns,homero,lisa,rafa,bart,hibbert,nick,tony])
    ):-
        sigueEnJuego(1,Personas).
:- end_tests(sigue_en_juego_tests).

% PUNTO B
:- begin_tests(es_interesante_tests).
% La primera ronda es interesante por tener mucha gente.
    test(ronda_con_mucha_gente_es_interesante,nondet):-
        esInteresante(1).
% La última ronda es interesante porque quedan pocas personas.
    test(ronda_interesante_con_pocas_personas,nondet):-
        esInteresante(6).
% La tercera ronda no es interesante por tener 7 personas en juego.
    test(ronda_con_siete_personas_no_es_interesante, fail):-
        esInteresante(3).
% Las rondas interesantes son la primera, la segunda y la última.
    test(rondas_interesantes,
        set(Rondas == [1,2,6])
    ):-
        esInteresante(Rondas).
:- end_tests(es_interesante_tests).

% PUNTO C
:- begin_tests(vivio_el_peligro_tests).
% homero vivió el peligro por ser civil y haber jugado la cuarta ronda.
    test(civil_vivio_el_peligro,nondet):-
        vivioElPeligro(homero).
% lisa vivió el peligro por ser detective y haber jugado la cuarta ronda.
    test(detective_vivio_el_peligro, nondet):-
        vivioElPeligro(lisa).
% tony no vivió el peligro por ser de la mafia.
    test(no_vivio_el_peligro, fail):-
        vivioElPeligro(tony).
% rafa no vivió el peligro por no haber jugado la cuarta ronda.
    test(detective_no_vivio_el_peligro,fail):-
        vivioElPeligro(rafa).
% Las personas que vivieron el peligro son homero, burns y lisa.
    test(vivio_el_peligro_es_inversible,
        set( Personas == [homero, burns, lisa] )
    ):-
        vivioElPeligro(Personas).
:- end_tests(vivio_el_peligro_tests).

/**********************************************************************************************
5) ESTRATEGIA (ambos integrantes)
A partir de que nuestro sistema se popularizó entre la comunidad, las estrategias llevadas a 
cabo por las personas que juegan activamente son cada vez más complejas. Nos pidieron ayuda para
identificar a estos jugadores y sus estrategias.
Para lograr esto, algo que deberá saber son las personas responsables y afectadas de una
determinada acción:
- Atacar una persona: las personas responsables son todas las que conforman la mafia.
La persona afectada es la atacada.
- Salvar una persona: la persona responsable es el médico, la afectada es la persona salvada.
- Investigar a una persona: la persona responsable es el detective que investiga, la afectada
es la persona investigada.
- Eliminar a una persona: las personas responsables son todos los contrincantes (punto 2.a) de
la persona eliminada. La persona afectada es la eliminada.

Resolver: */

/* a. Conocer los jugadores profesionales, que son aquellos que le hicieron algo a todos sus 
contrincantes, o sea que las acciones de las que el profesional es responsable terminaron 
afectando a todos sus contrincantes.*/

profesional(Persona):-
    rol(Persona,_),
    forall(
        contrincantes(Persona, Contrincante),
        afecto(_, Persona, Contrincante, _)
    ).

afecto(Ronda, Responsable, Afectado, atacar(Afectado)):-
    rol(Responsable, mafia),
    accion(Ronda,atacar(Afectado)).
afecto(Ronda, Responsable, Afectado, salvar(Responsable,Afectado)):-
    rol(Responsable, medico),
    accion(Ronda,salvar(Responsable,Afectado)).
afecto(Ronda, Responsable, Afectado, investigar(Responsable,Afectado)):-
    rol(Responsable, detective),
    accion(Ronda,investigar(Responsable,Afectado)).
afecto(Ronda, Responsable, Afectado, eliminar(Afectado)):-
    contrincantes(Responsable,Afectado),
    accion(Ronda, eliminar(Afectado)).

/* b. Encontrar una “estrategia” que se haya desenvuelto en la partida. Una estrategia es una
serie de acciones que se desarrollan a lo largo de la partida y deben cumplir que:
- La estrategia está conformada por acciones, correspondientes a una acción por cada ronda de la
partida.
- Las acciones sucedieron en orden durante la partida.
- Las acciones están encadenadas, lo que significa que la persona afectada por la acción anterior
es la responsable de la siguiente.
- Una estrategia debe cumplir, además, que comienza con una acción de la primera ronda y termina 
con una de la última.
*/

estrategia(Estrategia):-
    rol(PrimerResponsable, _),
    estrategiaDesdeRonda(1, PrimerResponsable, Estrategia).

estrategiaDesdeRonda(Ronda, Responsable, [Accion|Estrategia]):-
    afecto(Ronda, Responsable, ResponsableSig, Accion),
    RondaSig is Ronda + 1,
    estrategiaDesdeRonda(RondaSig, ResponsableSig, Estrategia).
estrategiaDesdeRonda(RondaInexistente, _,[]):- % Sería la última ronda + 1
    not(accion(RondaInexistente, _)). 
                                        
/*c. Casos de prueba a definir por estudiantes.*/

% PUNTO A
:- begin_tests(profesional_tests).
    test(detective_investiga_a_todos_es_profesional, nondet):-
        profesional(lisa).
    test(medico_que_no_elimina_ni_salva_a_contrincantes_no_es_profesional, fail):-
        profesional(hibbert).
    test(mafioso_que_elimina_a_sus_contrincantes_es_profesional, nondet):-
        profesional(tony).
    test(profesional_es_inversible,
        set( Profesionales == [maggie,tony,bart,rafa,lisa] )
    ):-
        profesional(Profesionales).
:- end_tests(profesional_tests).

% PUNTO B
:- begin_tests(estrategia_tests).
    test(estrategia_ejemplo, nondet):-
        estrategia([atacar(lisa), 
                    investigar(lisa, bart), 
                    atacar(lisa), 
                    investigar(lisa, homero), 
                    eliminar(bart), 
                    atacar(burns)]
        ).

    test(estrategias_tienen_misma_longitud_que_la_cantidad_de_rondas, nondet):-
        forall( estrategia(Estrategia),
                length(Estrategia, 6)
        ).

    test(estrategias_tienen_una_accion_por_ronda, nondet):-
        forall(estrategia(Estrategia),
                forall( nth1(Ronda, Estrategia, Accion),
                        accion(Ronda, Accion))
        ).

    test(afectado_ronda_anterior_es_responsable_ronda_siguiente, nondet):-
        forall(estrategia(Estrategia),
                forall( (nth1(Ronda, Estrategia, Accion), RondaSig is Ronda + 1, nth1(RondaSig, Estrategia, AccionSig)),
                        (afecto(Ronda,_,Persona, Accion), afecto(RondaSig, Persona,_, AccionSig))
                )
        ).
:- end_tests(estrategia_tests).