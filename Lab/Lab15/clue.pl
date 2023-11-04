victim(mr_boddy).
victim(cook).
victim(motorist).
victim(police_officer).
victim(yvette).
victim(singing_telegram).

suspect(professor_plum).
suspect(mrs_peacock).
suspect(mrs_white).
suspect(miss_scarlet).
suspect(colonel_mustard).
suspect(mr_green).
suspect(wadsworth).

weapon(wrench).
weapon(candlestick).
weapon(lead_pipe).
weapon(knife).
weapon(revolver).
weapon(rope).

room(hall).
room(kitchen).
room(lounge).
room(library).
room(billiard_room).

murder(mr_boddy,candlestick,hall).
murder(cook,knife,kitchen).
murder(motorist,wrench,lounge).
murder(police_officer,lead_pipe,library).
murder(singing_telegram,revolver,hall).
murder(yvette,rope,billiard_room).

% List of Motives
motive(Everyone, mr_boddy) :- Everyone \= wadsworth.
motive(mrs_peacock, cook).
motive(colonel_mustard, motorist).
motive(miss_scarlet, yvette).
motive(colonel_mustard, yvette).
motive(mrs_white, yvette).
motive(miss_scarlet, police_officer).
motive(professor_plum, singing_telegram).
motive(wadsworth, singing_telegram).

% Weapons that suspects did not used
cant_use(colonel_mustard, rope).
cant_use(professor_plum, revolver).
cant_use(mrs_peacock, candlestick).

% Rooms not visited
not_visited(miss_scarlet, billiard_room).
not_visited(professor_plum, kitchen).
not_visited(colonel_mustard, R) :- murder(mr_boddy, _, R).

% Alibi
alibi(mrs_white, mr_boddy).
alibi(mr_green, _).
alibi(miss_scarlet, V) :- murder(V, _, R), murder(_, revolver, R).

% Update accuse to solve the murders.
% Add more facts and rules as needed.
accuse(V,S) :- murder(V,W,R), suspect(S), motive(S,V), not(cant_use(S,W)), not(not_visited(S,R)), not(alibi(S,V)).