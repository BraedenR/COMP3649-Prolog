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

			
solver([],_).
solver([course(Name,_,Adj,Slots) | Rest], Schedule) :-
	% Get desired slot
		member(X,Slots),
	% ruleOut slot with the grabbed timeslot
		ruleOut(X,Adj,Rest,UpdatedCourses),
	% append to schedule
		NewSchedule = [{Name,X}|Schedule],
	% recurse 
		solver(UpdatedCourses,NewSchedule).

ruleOut(_,_,[],_).
ruleOut(Slot,Adj,[Course|Rest],NewCourses) :-
			Course = course(Name,_,_,_),
			if(member(Name,Adj),
				(
					ruleOutSlot(Slot,Course,NewCourse),
					NewCourses2 = [NewCourse | NewCourses],
					ruleOut(Slot,Adj,Rest,NewCourses2)
				),
				(
					NewCourses2 = [Course | NewCourses],
					ruleOut(Slot,Adj,Rest,NewCourses2)
				)
			   ).
			   

if(Test,Then) :- if(Test,Then,true).
if(Test,Then,Else) :- Test, !, Then ; Else.

foldr(_,G,[],G) :- !.
foldr(F,G,[X | XS], A) :- foldr(F,G,XS,A2),
                          call(F,X,A2,A).			   
/*
isAdjacent(course(_,_,Adjacent,_),course(Name2,_,_,_)) :-
				member(Name2,Adjacent).

pairUp(Course,ScheduleElem) :-				% Format course into a schedule element
		ScheduleElem = {Course,_}.

		
solve(Courses,NumSlots,Schedule) :-
			maplist(pairUp(), Courses, Schedule),   % Format all courses into a schedule list
			allSlots(NumSlots,Schedule).

		
allSlots(_,[]). :- !.
allSlots(NumSlots,[ {Course,Slot} | Rest ]) :- allSlots(NumSlots,Rest),
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
*/