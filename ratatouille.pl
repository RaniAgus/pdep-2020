rata(remy,gusteaus).
rata(emile,chezMilleBar).
rata(django,pizzeriaJeSuis).

persona(linguini).
persona(colette).
persona(horst).
persona(skinner).
persona(amelie).

trabaja(linguini,gusteaus).
trabaja(colette,gusteaus).
trabaja(horst,gusteaus).
trabaja(skinner,gusteaus).
trabaja(amelie,cafeDes2Moulins).

cocina(linguini,ratatouille,3).
cocina(linguini,sopa,5).
cocina(colette,salmonAsado,9).
cocina(horst,ensaladaRusa,8).

/*
1. Saber si un plato está en el menú de un restaurante, que es cuando alguno de los empleados 
lo sabe cocinar.
*/

% menu(ratatouille,gusteaus). ==> menu/2: Plato con un restaurante

menu(Plato,Restaurante):-
    trabaja(Cocinero,Restaurante),
    cocina(Cocinero,Plato,_).

/*
2. Saber quién cocina bien un determinado plato, que es verdadero para una persona si su experiencia 
preparando ese plato es mayor a 7, ó si tiene un tutor que cocina bien el plato. Nos contaron que 
Linguini tiene como tutor a toda rata que viva en el lugar donde trabaja, además que Amelie es la 
tutora de Skinner.
También se sabe que remy cocina bien cualquier plato que exista, y el resto de las ratas no cocina 
bien nada.
*/

cocinaBien(Cocinero,Plato):-
    cocina(Cocinero,Plato,Experiencia),
    Experiencia > 7.
cocinaBien(Cocinero,Plato):-
    persona(Cocinero),
    tutor(Tutor,Cocinero),
    cocinaBien(Tutor,Plato).
cocinaBien(remy,Plato):-
    cocina(_,Plato,_).
% El resto no cocina bien nada ==> ES FALSE POR UNIVERSO CERRADO

tutor(Rata,linguini):-
    trabaja(linguini,Restaurante),
    rata(Rata,Restaurante).
tutor(amelie,skinner).

/*
3. Saber si alguien es chef de un restó. Los chefs son, de los que trabajan en el restó, aquellos 
que cocinan bien todos los platos del menú ó entre todos los platos que sabe cocinar suma una 
experiencia de al menos 20.
*/

chef(Cocinero,Restaurante):-
    trabaja(Cocinero,Restaurante),
    requisitoChef(Cocinero,Restaurante).

requisitoChef(Cocinero,Restaurante):-
    forall(menu(Plato,Restaurante),cocinaBien(Cocinero,Plato)).
requisitoChef(Cocinero,_):-
    findall(Experiencia,cocina(Cocinero,_,Experiencia),Experiencias),
    sumlist(Experiencias,ExperienciaTotal),
    ExperienciaTotal >= 20.

/*
4. Deducir cuál es la persona encargada de cocinar un plato en un restaurante, que es quien más 
experiencia tiene preparándolo en ese lugar.
Nota: si sos la única persona que cocina el plato, sos el encargado, dado que tenés más experiencia
cocinando el plato que las demás personas.
*/

encargado(Cocinero,Plato,Restaurante):-
    trabaja(Cocinero,Restaurante),
    cocina(Cocinero,Plato,Experiencia),
    forall(
        ( companieros(Cocinero, OtroCocinero) , 
          cocina(OtroCocinero,Plato,OtraExperiencia) ),
        Experiencia > OtraExperiencia
    ).

companieros(Cocinero,OtroCocinero):-
    trabaja(Cocinero,Restaurante),
    trabaja(OtroCocinero,Restaurante),
    Cocinero \= OtroCocinero.