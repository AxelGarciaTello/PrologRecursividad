%=====================|
%García Tello Axel    |
%=====================|
%Lista y recursión    |
%Ejercicios en Prolog |
%=====================|

%1) [] contiene_numero/1. Verificar si una lista contiene algún elemento
%numérico.
%contiene_numero(<lista>).
%Verdadero si <lista> es una lista que contiene algún elemento numérico,
%Falso en cualquier otro caso.

contiene_numero([X])   :- number(X).          %Sí la lista solo tiene un número: verdadero.
contiene_numero([X|L]) :- number(X),!;        %Sí el primer elemento es un número: verdadero.
                          contiene_numero(L). %Sí no, sigue buscando.

%2) [] inserta_ceros/2. Intercalar ceros después de cada elemento original.
%inserta_ceros(<lista>,<respuesta>).
%Verdadero si <respuesta> es una lista con los mismos elementos que
%<lista>, pero con un cero agregado después de cada elemento original.
%La lista vacía debe conservarse.

inserta_ceros([],[]).                               %Sí es una lista vacía: conservala.
inserta_ceros([X],[X,0])     :- !.                  %Sí la lista solo tiene un elemento, agrega un 0 después de él.
inserta_ceros([X|L],[X,0|R]) :- inserta_ceros(L,R). %Toma el primer elemento y agrega un 0 después de él,
                                                    %después continua con la lista.

%3) [sin usar append] rota/3. Rotar los elementos de una lista algún
%número de posiciones hacia la derecha.
%rota(<lista>,<n>,<respuesta>).
%Verdadero si <respuesta> es una lista con los mismos elementos que
%<lista>, pero rotados hacia la derecha <n> posiciones.

rota(X,1,[Y|Z]) :- is_list(X),                   %Sí solo es una rotación, verifica que es una lista.
                   reverse(X,[Y|L]),             %Voltea la lista y toma su primer elemento (último elemento de la lista original).
                   reverse(L,Z),!.               %Voltea el restande de la lista, devuelve el último elemento al inicio
                                                 %y el resto de la lista normal.
rota(X,N,R)     :- is_list(X), number(N), N > 1, %Sí son más rotaciones, verifica que tenemos los elementos adecuados.
                   N1 is N-1,                    %Crea una variable N1 = N-1.
                   rota(X,1,R1),                 %Rota una vez.
                   rota(R1,N1,R).                %Rota las N-1 veces que falten.

%4) [sin usar reverse, ni append] reversa_simple/2. Invertir una lista.
%reversa_simple(<lista>,<respuesta>).
%Verdadero si <respuesta> es la inversión de primer nivel de <lista>.

lista_ultimo(_,0,[])    :- !.                     %Devuelve una lista vacía sí buscamos el elemento 0 de la lista.
lista_ultimo(X,N,[U|R]) :- N1 is N-1,             %Crea una variable N1 = N-1.
                           nth1(N,X,U),           %Busca el elemento N de la lista y devuelvelo al inicio.
                           lista_ultimo(X,N1,R).  %Busca el elemento N-1 de la lista.
reversa_simple(X,R)     :- is_list(X),            %Verifica que tenemos una lista.
                           length(X,N),           %Calcula el tamaño de la lista.
                           lista_ultimo(X,N,R).   %Busca el último elemento de la lista.

%5) [sin usar select] inserta0_en/4. Inserta un término arbitrario en alguna
%posición específica de una lista.
%inserta0_en(<término>,<lista>,<posición>,<resultado>).
%Verdadero si <resultado> es una lista con los mismos elementos que <lista>
%pero con <término> insertado en la posición <posición>, considerando el
%inicio de la lista como posición 0.

inserta0_en(X,Y,0,[X|Y])     :- is_list(Y).              %Sí se quiere agregar el elemento en la posición 0,
                                                         %colocalo al inicio.
                                                         %Verifica que el seundo elemento es una lista.
inserta0_en(X,[Y|L],N,[Y|R]) :- number(N), N > 0,        %Verifica que tenemos los elementos adecuados.
                                length([Y|L],T),
                                T >= N,                  %Revisa que la posición no sea mayor que la lista.
                                N1 is N-1,               %Crea una variable N1 = N-1.
                                inserta0_en(X,L,N1,R),!. %Quita el primer elemento de la lista y por X en la posición N-1.

%6) [] promedio_parcial/3. Calcular el promedio (media aritmética) de los
%primeros n elementos de una lista.
%promedio_parcial(<lista>,<n>,<resultado>).
%Verdadero si <resultado> es un número que representa el promedio de los
%primeros <n> elementos de <lista>.

%Función base obtenida de la clase.
suma([X|_],1,X) :- number(X).                   %Sí solo se quiere sumar el primer elemento,
                                                %el resultado es el mismo elemento (solo sí es numérico).
suma([X|L],N,R) :- number(X), number(N), N > 1, %Verifica que tenemos los elementos adecuados.
                   N1 is N-1,                   %Crea una variable N1 = N-1.
                   suma(L,N1,R1),               %Suma los N-1 elementos después del primero
                   R is X+R1,!.                 %Al resultado sumale el primer elemento y será nuestro nuevo resultado.
promedio_parcial(X,N,R) :- is_list(X),          %Verifica que tenemos los elementos adecuados.
                           suma(X,N,R1),        %Suma los N elementos de la lista.
                           R is R1/N.           %El resultado es la suma dividida entre el número de elementos.

%7) [sin optimizar] fibonacci/2. Calcular cada término en la serie de
%Fibonacci.
%fibonacci(<n>,<resultado>).
%Verdadero si <resultado> es el número Fibonacci correspondiente a <n>.

fibonacci(0,1) :- !.                                  %Casos iniciales de fibonacci.
fibonacci(1,1) :- !.
fibonacci(X,R) :- number(X), X > 0,                   %Verifica que es un número positivo.
                  X1 is X-1, X2 is X-2,               %Crea una variable X1 = X-1 y X2 = X-2.
                  fibonacci(X1,R1), fibonacci(X2,R2), %Calcula fibonacci de X1 y X2
                  R is R1+R2.                         %Suma los resultados, seran el resultado final.

%8) [] simplifica/2. Eliminar de una lista todos los elemento que se
%encuentren duplicados.
%simplifica(<lista>,<resultado>).
%Verdadero si <resultado> es una lista con los mismos elementos que
%<lista> pero con sólo una instancia de cada elemento.

%Función para eliminar elementos de una lista obtenida de la siguiete fuente:
%xPasos, (2011,mayo 16). "PROLOG: Borra elemento de una lista", [Online]. Referencia:
%https://xpasos.wordpress.com/2011/05/16/prolog-borra-elemento-de-una-lista/
eliminar(_,[],[]).
eliminar(X,[X|L], R) :- eliminar(X,L,R), !.
eliminar(X,[Y|L],[Y|R]) :- eliminar(X,L,R).

%Función base obtenida de la siguiente fuente:
%evgeniuz, (2010, febrero 14). "Eliminar duplicados en la lista(Prolog)", [Online]. Referencia:
%https://www.it-swarm-es.com/es/list/eliminar-duplicados-en-la-lista-prolog/968488372/
simplifica([],[]).                             %Caso base.
simplifica([X|L],[X|R]) :- \+ member(X,L),     %Sí el primero elemento ya no es parte del resto de la lista, devuelvelo en el resultado.
                           simplifica(L,R).    %Evalua el resto de la lista.
simplifica([X|L],R)     :- member(X,L),        %Sí el primero elemento se repite, no lo devuelvas.
                           eliminar(X,L,A),    %Elimina todos los elementos iguales al primero.
                           simplifica(A,R), !. %Evalua el resto de la lista.

%9) [] depura/2. Eliminar de una lista todos los elementos que NO es
%encuentren duplicados, cuando menos, una vez.
%depura(<lista>,<resultado>).
%Verdadero si <resultado> es una lista conteniendo sólo una instancia de
%cada elemento en <lista> que sí tenía repeticiones.

depura([],[]).                          %Caso base.
depura([X|L],[X|R]) :- member(X,L),     %Sí el primero elemento se repite, devuelvelo en el resultado.
                       eliminar(X,L,A), %Elimina todos los elementos iguales al primero.
                       depura(A,R),!.   %Evalua el resto de la lista.
depura([X|L],R)     :- \+ member(X,L),  %Sí el primero elemento ya no es parte del resto de la lista, no lo devuelvas.
                       depura(L,R).     %Evalua el resto de la lista.


%10) [] maximo/2. Identificar el mayor valor de entre aquellos contenidos en
%una lista.
%maximo(<lista>,<resultado>).
%Verdadero si <resultado> es el mayor valor numérico contenido en
%<lista>. No todos los elementos necesitan ser numéricos.

maximo([X],0)   :- \+ number(X).                  %Sí la lista solo es un elemento no numérico, el resultado es 0.
maximo([X],X)   :- number(X).                     %Sí la lista solo es un elemento numérico, el resultado es ese mismo elemento.
maximo([X|L],R) :- maximo(L,R),                   %Calcula el máximo valor del resto de la lista.
                  (number(X),((X > R, R is X), !; %Sí el primer elemento es un número mayor que el máximo, devuelvelo como resultado.
                  X =< R), !;                     %Sí no es mayor, quedate con el resultado actual.
                  \+ number(X)).                  %Sí el primer elemento no es un número, quedate con el resultado actual.
