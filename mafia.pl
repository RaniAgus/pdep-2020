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



/* b. Deducir las personas que perdieron en una determinada ronda. O sea, aquellas que fueron:
- eliminadas en dicho ronda, ó 
- atacadas por la mafia, salvo que algún médico haya salvado a la persona, en dicha ronda.

Explicar qué conceptos permiten resolver este requerimiento sin la necesidad de armar listas. */



/* c. Casos de prueba */
% Al ser eliminado, la persona pierde en esa ronda (por ejemplo nick pierde en la primera ronda).


% Un atacado por la mafia pierde si nadie lo salva (por ejemplo homero en la cuarta ronda).


% Un atacado por la mafia no pierde si alguien lo salva (por ejemplo lisa en la primer ronda).


% A pesar de ser salvado, si te eliminan perdés (por ejemplo rafa en la segunda ronda).


% Si nunca fue eliminada ni atacada, la persona no perdió en ninguna ronda (por ejemplo maggie).


% En una ronda puede perder más de una persona (por ejemplo en la quinta ronda pierden bart y lisa).


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



/* b. Saber si alguien ganó, y en el caso que haya varios ganadores, conocerlos todos. Una persona 
es ganadora cuando no perdió pero todos sus contrincantes sí.

Explicar cómo se relaciona el concepto de inversibilidad con la solución. */



/* c. Casos de prueba. Nota: ¡Los nombres de los tests deben representar su clase de equivalencia! */

% Los contrincantes de tony (por ser de la mafia) son homero, burns, nick, hibbert, lisa y rafa.


% Los contrincantes de homero (por no ser de la mafia) son bart, tony y maggie.


% La única ganadora es maggie.


/***********************************************************************************************
3. IMBATIBLES (integrante 2)
La mafia se enteró de nuestro sistema y nos pidió información sobre algunos jugadores que considera 
imbatibles para poder planear mejor sus ataques. Nos contaron que:

- Un médico es imbatible cuando siempre salvó a alguien que estaba siendo atacado por la mafia.
- Un detective es imbatible cuando ha investigado a todas las personas que pertenecen a la mafia.
- El resto de las personas nunca son imbatibles.

Se pide: */

/* a. Saber si un jugador es imbatible.
Explicar cómo se relacionan los conceptos de inversibilidad y universo cerrado con la solución.*/




/* b. Casos de prueba. Nota: ¡Los nombres de los tests deben representar su clase de equivalencia!*/
% hibbert es un médico imbatible.

% nick no es un médico imbatible.

% lisa es una detective imbatible.

% rafa no es un detective imbatible.

% Homero (por ser civil) nunca es imbatible.

/*************************************************************************************************
4) MÁS INFO (dividido - evitar repetir lógica)
Nuestro sistema la está pegando y muchos jugadores se nos acercan con nuevos requerimientos, 
algunos con sentido, otros no tanto.

Implementar los predicados necesarios para: */

/* a. (ambos integrantes) Deducir las personas que siguen en juego al comenzar una determinada 
ronda, o sea, las que todavía no perdieron (sin importar si pierde en dicha ronda o posterior). */




/* b. (integrante 1) Conocer cuáles son las rondas interesantes que tuvo la partida. Una ronda es 
interesante si en dicha ronda siguen más de 7 personas en juego. También es interesante cuando
quedan en juego menos o igual cantidad de personas que la cantidad inicial de la mafia. */




/* c. (integrante 2) Saber quiénes vivieron el peligro, que son los civiles o detectives que jugaron
alguna ronda peligrosa. Se dice que una ronda es peligrosa cuando la cantidad de personas en juego
es 3 veces la cantidad de civiles con los que empezó la partida. */




/* Casos de prueba Nota: ¡Los nombres de los tests deben representar su clase de equivalencia!*/

% PUNTO A
% rafa sigue jugando en la segunda ronda, por más que pierda luego.


% nick no sigue jugando en la cuarta ronda, porque perdió antes.


% Las personas que llegan hasta la última ronda son maggie y burns.


% Todas las personas en juego juegan la primera ronda.


% PUNTO B
% La primera ronda es interesante por tener mucha gente.


% La última ronda es interesante porque quedan pocas personas.


% La tercera ronda no es interesante por tener 7 personas en juego.


% Las rondas interesantes son la primera, la segunda y la última.


% PUNTO C
% homero vivió el peligro por ser civil y haber jugado la cuarta ronda.


% lisa vivió el peligro por ser detective y haber jugado la cuarta ronda.


% tony no vivió el peligro por ser de la mafia.


% rafa no vivió el peligro por no haber jugado la cuarta ronda.


% Las personas que vivieron el peligro son homero, burns y lisa.



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

