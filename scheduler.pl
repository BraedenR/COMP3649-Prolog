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

pairUp(Course,ScheduleElem) :-				% Format course into a schedule element
		ScheduleElem = {Course,_}.

		
solve(Courses,NumSlots,Schedule) :-
			maplist(pairUp(), Courses, Schedule),   % Format all courses into a schedule list
			allSlots(NumSlots,Schedule).

		
allSlots([]).
allSlots(NumSlots,[ {Course,Slot} | Rest ]) :- safeRows(Rest),
							  numList(1,NumSlots,Slots),
                              member(Slot, Slots),
							  ruleOut(Slot,Schedule,[{Course2,Slot2} | Rest2]),
						      slotCheck( {Course2,Slot2}, Rest2).

slotCheck(_,[]).
slotCheck({Course,Slot}, [{Course1,Slot1} | Rest]) :- 
                                    if((Slot == Slot1, isAdjacent(Course,Course1)),
										fail,
                                        slotCheck({Course,Slot}, Rest)
									   ).

ruleOut(_,[],[]) :- !.									   
ruleOut(SlotNum,[{Course,Slot} | Rest] , Schedule) :-
			ruleOut(SlotNum,Rest,Schedule2),
			ruleOutSlot(SlotNum,Course,Course2),
			Schedule = [{Course2,Slot} | Schedule2].