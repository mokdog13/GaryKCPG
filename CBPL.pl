% Legal jumps along a line.
linjmp([x, x, o | T], [o, o, x | T]).
linjmp([o, x, x | T], [x, o, o | T]).
linjmp([H|T1], [H|T2]) :- linjmp(T1,T2).

% Rotate the board
rotate([[A, B, C, D, E, F],
        [G, H, I, J, K, L],
        [M, N, O, P, Q, R],
        [S, T, U, V, W, X]],
        [[S, M, G, A],
        [T, N, H, B],
        [U, O, I, C],
        [V, P, J, D],
        [W, Q, K, E],
        [X, R, L, F]]).

RTB([[A, B, C, D],
            [E, F, G, H],
            [I, J, K, L],
            [M, N, O, P],
            [Q, R, S, T],
            [U, V, W, X]],
            [[D, H, L, P, T, X],
            [C, G, K, O, S, W],
            [B, F, J, N, R, V],
            [A, E, I, M, Q, U]]).

% A jump on some line.
hj([A|T],[B|T]) :- linjmp(A,B).
hj([H|T1],[H|T2]) :- hj(T1,T2).

% One legal jump.
jump(B,A) :- hj(B,A).
jump(B,A) :- rotate(B,BR), hj(BR,BRJ), RTB(A,BRJ).
%jump(B,A) :- rotate(BR,B), hj(BR,BRJ), rotate(BRJ,A).

% Series of legal boards.
series(From, To, [From, To]) :- jump(From, To).
series(From, To, [From, By | Rest])
       :- jump(From, By),
         series(By, To, [By | Rest]).

% A solution.
solution(L) :- series([[o, x, x, x, x, x],
                       [x, x, x, x, x, x],
                       [x, x, x, x, x, x],
                       [x, x, x, x, x, x]], L).
