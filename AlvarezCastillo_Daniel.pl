%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Author: Daniel Alvarez Castillo %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Exercice_01 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*************************************************************************************/
/* We assert the initial and final states.                                           */
/*************************************************************************************/

% solve_problem(sokoban, X).
	
initial_state(sokoban, p(7,5,6)).
goal(8).
goal(9).
final_state(sokoban, p(_,X,Y)) :- goal(X), goal(Y), X \= Y.

/*************************************************************************************/
/* Now we implement our table of moves.                                              */
/*************************************************************************************/

move(p(A1,BA1,BB1),m(A1,BA1,BB1,up,A2,BA2,BB1)) :-
	BA1 is A1 - 3,
	BA2 is BA1 - 3,
	A2 is A1 - 3.
move(p(A1,BA1,BB1),m(A1,BA1,BB1,up,A2,BA1,BB2)) :-
	BB1 is A1 - 3,
	BB2 is BB1 - 3,
	A2 is A1 - 3.
move(p(A1,BA1,BB1),m(A1,BA1,BB1,up,A2,BA1,BB1)) :-
	A2 is A1 - 3.

move(p(A1,BA1,BB1),m(A1,BA1,BB1,down,A2,BA2,BB1)) :-
	BA1 is A1 + 3,
	BA2 is BA1 + 3,
	A2 is A1 + 3.
move(p(A1,BA1,BB1),m(A1,BA1,BB1,down,A2,BA1,BB2)) :-
	BB1 is A1 + 3,
	BB2 is BB1 + 3,
	A2 is A1 + 3.
move(p(A1,BA1,BB1),m(A1,BA1,BB1,down,A2,BA1,BB1)) :-
	A2 is A1 + 3.

move(p(A1,BA1,BB1),m(A1,BA1,BB1,left,A2,BA2,BB1)) :-
	A1 \= 4,
	A1 \= 7,
	BA1 is A1 - 1,
	BA2 is BA1 - 1,
	A2 is A1 - 1.
move(p(A1,BA1,BB1),m(A1,BA1,BB1,left,A2,BA1,BB2)) :-
	A1 \= 4,
	A1 \= 7,
	BB1 is A1 - 1,
	BB2 is BB1 - 1,
	A2 is A1 - 1.
move(p(A1,BA1,BB1),m(A1,BA1,BB1,left,A2,BA1,BB1)) :-
	A1 \= 4,
	A1 \= 7,
	A2 is A1 - 1.

move(p(A1,BA1,BB1),m(A1,BA1,BB1,right,A2,BA2,BB1)) :-
	A1 \= 3,
	A1 \= 6,
	BA1 is A1 + 1,
	BA2 is BA1 + 1,
	A2 is A1 + 1.
move(p(A1,BA1,BB1),m(A1,BA1,BB1,right,A2,BA1,BB2)) :-
	A1 \= 3,
	A1 \= 6,
	BB1 is A1 + 1,
	BB2 is BB1 + 1,
	A2 is A1 + 1.
move(p(A1,BA1,BB1),m(A1,BA1,BB1,right,A2,BA1,BB1)) :-
	A1 \= 3,
	A1 \= 6,
	A2 is A1 + 1.

/*************************************************************************************/
/* We now implement the state update functionality.                                  */
/*************************************************************************************/

update(p(A1,BA1,BB1),m(A1,BA1,BB1,_,A2,BA2,BB2),p(A2,BA2,BB2)).

/*************************************************************************************/
/* Implementation of the predicate that checks whether a state is legal              */
/* according to the constraints imposed by the problem's statement.                  */
/*************************************************************************************/

legal(p(A,BA,BB)) :-
	A >= 1,
	A =< 9,
	BA >= 1,
	BA =< 9,
	BB >= 1,
	BB =< 9,
	A \= BA,
	A \= BB,
	BA \= BB.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Exercice_02 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*************************************************************************************/
/* We assert the initial and final states.                                           */
/*************************************************************************************/

% solve_problem(sliding_puzzle, X).

%initial_state(sliding_puzzle, p(ok)).
%final_state(sliding_puzzle, p(ok)).

/*************************************************************************************/
/* Now we implement our table of moves.                                              */
/*************************************************************************************/



/*************************************************************************************/
/* We now implement the state update functionality.                                  */
/*************************************************************************************/



/*************************************************************************************/
/* Implementation of the predicate that checks whether a state is legal              */
/* according to the constraints imposed by the problem's statement.                  */
/*************************************************************************************/



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*************************************************************************************/
/* A reusable depth-first problem solving framework.                                 */
/*************************************************************************************/

/* The problem is solved is the current state is the final state.                    */

solve_dfs(Problem, State, _, []) :-
	final_state(Problem, State).

/* To perform a state transition we follow the steps below:                          */
/* - We choose a move that can be applied from our current state.                    */
/* - We create the new state which results from performing the chosen move.          */
/* - We check whether the new state is legal (i.e. meets the imposed constraints.    */
/* - Next we check whether the newly produced state was previously visited. If so    */
/*   then we discard such a move, since we're most probably in a loop!               */
/* - If all the above conditions are fulfilled, then we consolidate the chosen move  */
/*   and then we continue searching for the solution. Note that we have stored the   */
/*   newly created state for loop checking!                                          */

solve_dfs(Problem, State, History, [Move|Moves]) :-
	move(State, Move),
	update(State, Move, NewState),
	legal(NewState),
	\+ member(NewState, History),
	solve_dfs(Problem, NewState, [NewState|History], Moves).

/*************************************************************************************/
/* Solving the problem.                                                              */
/*************************************************************************************/

solve_problem(Problem, Solution) :-
	initial_state(Problem, Initial),
	solve_dfs(Problem, Initial, [Initial], Solution).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
