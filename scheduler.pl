:- module( scheduler,
			[
			  schedule/3
			]
		  ).
		  
:- use_module('Course.pl').

schedule(CourseData,NumSlots,Schedule) :-
		maplist(newCourse(NumSlots),CourseData,Courses),	% Create all courses
		maplist(setAdjacent(Courses),Courses,CourseList),	% Create adjoined list of courses
		solver(CourseList,Schedule).


isAdjacent(course(_,_,Adjacent,_),course(Name2,_,_,_)) :-
				member(Name2,Adjacent).

pairUp(Course,ScheduleElem) :-
		ScheduleElem = {Course,_}.
			   
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
