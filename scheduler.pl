:- module( scheduler,
			[
			  schedule/3
			]
		  ).
		  
:- use_module('Course.pl').

schedule(CourseData,NumSlots,Schedule) :-
		% Create courses list,
		solution(Courses,Schedule).

/*
solution(Courses,Schedule) :- 
	uniqueCourses(Courses,Schedule),
	safeRows(Schedule).

eightUniqueColumns([1/_,2/_,3/_,4/_,5/_,6/_,7/_,8/_]).

safeRows([]).
safeRows([ X / Y | Rest ]) :- safeRows(Rest),
							  numList(1,NumSlots,Slots),
                              member(Y, Slots),
						      noAttack( X / Y, Rest).

noAttack(_,[]).
noAttack(X / Y, [X1 / Y1 | Rest]) :- Y =\= Y1,				  % not in the same row
									 abs(X-X1) =\= abs(Y-Y1), % not on the same diagonal
                                     noAttack(X / Y, Rest).
*/