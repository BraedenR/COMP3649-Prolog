% make a course data structure -- course/4

%         Input     Input     Output
newCourse(NumSlots,(Name,Ids),course(Name,Ids,[],AvailableSlots)) :- 
            numlist(1,NumSlots,AvailableSlots).
			
%              Input          Input        Output
% setAdjacent( ListOfCourses, InputCourse, OutputCourse)
% The output course is the same as the input course but with an adjacency list
setAdjacent( ListOfCourses, course(Name,Ids,_,Slots), 
                            course(Name,Ids,Adjacents,Slots) ) :- 
							   foldr(compareCourse(Name,Ids),
							         [],
									 ListOfCourses,
									 Adjacents).
% helper for the above
compareCourse(Name1,Ids1, course(Name2,Ids2,_,_), Adjacent, AdjacentAdded) :-
     if( (Name1 = Name2 ; intersection(Ids1,Ids2,[]) ) ,
	     Adjacent = AdjacentAdded,
		 AdjacentAdded = [Name2 | Adjacent]
	   ).

% we have to build if using !
if(Test,Then) :- if(Test,Then,true).
if(Test,Then,Else) :- Test, !, Then ; Else.

foldr(_,G,[],G) :- !.
foldr(F,G,[X | XS], A) :- foldr(F,G,XS,A2),
                          call(F,X,A2,A).
			
