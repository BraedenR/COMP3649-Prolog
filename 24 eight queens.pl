% The eight queens problem
%
% Where can we put 8 queens on a 8x8 chessboard so that none of the queens can take each other.
%
% Design a data structure for our answer.
%   List of eight ordered pairs of numbers from 1 to 8.
%     Ordered pairs:  p / q (is an ordered pair -- just don't use "is" or =:= with it).
%   Our answer will look something like:
%      [1/3, 2/5, 3/8, 4/1, ...]

solution(S) :- 
	eightUniqueColumns(S),
	safeRows(S).

eightUniqueColumns([1/_,2/_,3/_,4/_,5/_,6/_,7/_,8/_]).

safeRows([]).
safeRows([ X / Y | Rest ]) :- safeRows(Rest),
                              member(Y, [1,2,3,4,5,6,7,8]),
						      noAttack( X / Y, Rest).

noAttack(_,[]).
noAttack(X / Y, [X1 / Y1 | Rest]) :- Y =\= Y1,				  % not in the same row
									 abs(X-X1) =\= abs(Y-Y1), % not on the same diagonal
                                     noAttack(X / Y, Rest).
										  
                    