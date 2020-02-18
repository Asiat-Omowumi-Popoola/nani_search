
% Simple queries of nani search. 
% Identification of rooms
room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).

% The rooms and their connections.
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

% Things and their locations
location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).


% The properties of various things.
edible(apple).
edible(crackers).
tastes_yucky(broccoli).

% Where the player is at beginning of the game.
here(kitchen).

sleeps(A).

% Query to find out things to eat in a specific location 
where_food(M,N) :- 
location(M,N), edible(M), tastes_yucky(M). 

% checking for connection btw rooms
connect(X,Y):-door(X,Y).
connect(X,Y):-door(Y,X).

% listing things in each room

list_things(Place):-location(X, Place),tab(2),
write(X),nl,fail.

% list things in everywhere.
list_things(_).
% list connecting rooms
list_connections(Place):-
connect(Place,X),
tab(2),
write(X),
nl,fail.
list_connections(_).

% kowning where you are in the game.

look:-
 here(Place),
 write('You are in the '), write(Place), nl,
 write('You can see:'), nl,
 list_things(Place),
 write('You can go to:'), nl,
 list_connections(Place).

% things in every room and there connections.
 look(M):-
 room(M),
 write('You are in the '), write(M),nl,
 write('You can see'), nl,
 list_things(M),
 write('You can go'), nl,
 list_connections(M), fail.


% look in to check for things located in an arguement.
look_in(Y):-location(X,Y),
tab(2),
write(X),nl,fail.

% Managing data
go_to(Place):-
 can_go(Place),
 move(Place),
 look.
 
 can_go(Place):-
 here(X),
 connect(X, Place).
 can_go(Place):-
 write('You cannot get '), write(Place), write('from here.'),nl,
 fail. 

% It retracts the old clause for here/1 and replaces it with a new one. 
 move(Place):-
 retract(here(X)),
 asserta(here(Place)).

 take(X):-
 can_take(X),
 take_object(X).
 
 can_take(Thing) :-
 here(Place),
 location(Thing, Place).

 can_take(Thing) :- 
 write('There is no '), write(Thing),
 write(' here.'),
 nl, fail.

 take_object(X):-
 retract(location(X,_)),
 asserta(have(X)),
 write('taken'), nl.
 
 backtracking_assert(X):-
 asserta(X).
backtracking_assert(X):-
 retract(X),fail.
% Exercise
put(X):- retract(have(X)), asserta(location(X,_)).
inventory:- have(X),write(X),nl,fail.

turn_on(flashlight).
turn_off(flashlight).

open(X):- connect(X,Y).

