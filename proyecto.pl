:- dynamic (conocido/3).

tamañosombrero(X):-menu_pregunta('Que tan grande es el sombrero?',tamañosombrero,X,[pequeño,mediano,grande,desconocido]).
colorsombrero(X):-menu_pregunta('De que color es el sombrero?',colorsombrero,X,[naranja,rojo,gris,violeta,desconocido]).
formasombrero(X):-menu_pregunta('Que forma tiene el sombrero?',formasombrero,X,[embudo,convexo,plano,desconocido]).
colorlaminas(X):-menu_pregunta('Que color tienen sus laminas?',colorlaminas,X,[blanco,gris,desconocido]).
colorcarne(X):-menu_pregunta('De que color es su carne?',colorcarne,X,[amarillo,blanco,desconocido]).
altura(X):-menu_pregunta('Que tan alto es?',altura,X,[alto,mediano,corto,desconocido]).
grosor(X):-menu_pregunta('Que tan grueso es?',grosor,X,[grueso,mediano,delgado,desconocido]).
manchas(X):-pregunta('Tiene manchas ',manchas,X).
textura(X):-pregunta('Su textura es ',textura,X).
olor(X):-pregunta('Su olor es ',olor,X).

respuesta(amanita_caesarea):-nl,write('Esta seta es comestible'),nl.
respuesta(amanita_muscaria):-nl,write('Esta seta es venenosa'),nl.
respuesta(boletus_aereus):-nl,write('Esta seta es comestible'),nl.
respuesta(entoloma_sinuatum):-nl,write('Esta seta es toxica'),nl.
respuesta(lepista_nuda):-nl,write('Esta seta es comestible'),nl.
respuesta(paxillus_involutus):-nl,write('Esta seta es mortal'),nl.
respuesta(amanita_phalloides):-nl,write('Esta seta es Mortal'),nl.
respuesta(clitocybe_gibba):-nl,write('Esta seta es comestible'),nl.
respuesta(tricholoma_terreum):-nl,write('Esta seta es comestible'),nl.
respuesta(pleorotus_eryngii):-nl,write('Esta seta es comestible'),nl.


seta(amanita_caesarea):-
	colorsombrero(naranja),
	colorcarne(amarillo),
	textura(suave),
	respuesta(amanita_caesarea).
seta(clitocybe_gibba):-
	colorsombrero(naranja),
	formasombrero(embudo),
	respuesta(clitocybe_gibba).

seta(amanita_muscaria):-
	colorsombrero(rojo),
	formasombrero(plano),
	colorlaminas(blanco),
	colorcarne(blanco),
	manchas(blanco),
	respuesta(amanita_muscaria).
seta(pleorotus_eryngii):-
	colorsombrero(rojo),
	formasombrero(plano),
	colorcarne(amarillo),
	respuesta(pleorotus_eryngii).
seta(paxillus_involutus):-
	colorsombrero(rojo),
	formasombrero(convexo),
	manchas(gris),
	respuesta(paxillus_involutus).
seta(boletus_aereus):-
	colorsombrero(gris),
	formasombrero(convexo),
	textura(porosa),
	respuesta(boletus_aereus).
seta(entoloma_sinuatum):-
	colorsombrero(gris),
	formasombrero(convexo),
	olor(agradable),
	respuesta(entoloma_sinuatum).
seta(tricholoma_terreum):-
	colorsombrero(gris),
	formasombrero(plano),
	colorlaminas(gris),
	textura(porosa),
	respuesta(tricholoma_terreum).
seta(lepista_nuda):-
	colorsombrero(violeta),
	formasombrero(convexo),
	olor(agradable),
	respuesta(lepista_nuda).
seta(amanita_phalloides):-
	colorsombrero(violeta),
	olor(desagradable),
	respuesta(amanita_phalloides).

pregunta(_,A,V) :- conocido(si,A,V), !.
pregunta(_,A,V) :- conocido(_,A,V), !, fail.
pregunta(P,A,V) :-
	write(P),
	write(V),
	write('? : '),
	read(Resp),
	assert(conocido(Resp,A,V)),
	Resp == si.

menu_pregunta(_,A,V,_) :- conocido(si,A,V), !.
menu_pregunta(_,A,V,_) :- conocido(no,A,V), !, fail.
menu_pregunta(P,A,V,MenuLista) :-
	write(P),nl,
	write(MenuLista),nl,read(Resp),
	checar(Resp,P,A,V,MenuLista),
	negaciones(MenuLista,A,Resp),!,
	Resp == V,!.

member(X,[X|_]).
member(E,[_|Y]):- member(E,Y).

checar(X,_,_,_,MenuLista) :- member(X,MenuLista), !.
checar(_,P,A,V,MenuLista) :- write('Ese valor no es valido, intente nuevamente'), nl,
	menu_pregunta(P,A,V,MenuLista).

negaciones([],_,_):-!.
negaciones([X|Y],A,X):-assert(conocido(si,A,X)),negaciones(Y,A,X).
negaciones([X|Y],A,V):-assert(conocido(no,A,X)),negaciones(Y,A,V).

solucion :-
	abolish(conocido,3),
	assert(conocido(asd,asd,asd)),
	seta(X),
	write('La seta es: '),
	write(X), nl.
solucion :- write('No se encontró una respuesta.'), nl.
