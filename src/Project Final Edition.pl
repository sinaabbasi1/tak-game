set([H|T],1,X,[[X|H]|T],_,_):-
    len(H,E),
    E<9,
    !.


set([H|T],1,X,[[X|H]|T],P1,P2):-
    len(H,E),
    E>8,
    X='b',
    write('Illegal move. This tile is full. Select another tile'),nl,
    play([H|T],player2,1,P1,P2),
    !.


set([H|T],1,X,[[X|H]|T],P1,P2):-
    len(H,E),
    E>8,
    X='w',
    write('Illegal move. This tile is full. Select another tile'),nl,
    play([H|T],player1,1,P1,P2),
    !.


set([H|Tail],N,X,[H|T],P1,P2):-
	N > 1,
	N1 is N-1,
	set(Tail,N1,X,T,P1,P2).

len([],0).

len([_|T],N):-
    len(T,D),
    N is D+1.


initialize(tak,[[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16]]).


play(Game) :-
	initialize(Game, Board),
	howToPlay(Board,player1,20,20),!.


showTheBoard([P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15,P16]):-
	write([P1,P2,P3,P4]),
	nl,
	write([P5,P6,P7,P8]),
	nl,
	write([P9,P10,P11,P12]),
	nl,
	write([P13,P14,P15,P16]),
	nl.




howToPlay(Board,Player,_,_):-
    changePlayer(Player,PPlayer),
    win(Board,PPlayer),write(PPlayer),write(' win!').

howToPlay(Board,Player,P1,P2):-
    not(win(Board,Player)),
    showTheBoard(Board),
    write('Turn: '),
	write(Player),nl,
    write('How do you want to play?'),nl,
    write(' "1" outside seals'),nl,
    write(' "2" inside seals'),nl,
    read(Op),
    play(Board,Player,Op,P1,P2).



changePlayer(player1,player2).
changePlayer(player2,player1).

numOfSeals(player1,P1,_,PlayerSeals):-
    PlayerSeals=P1.

numOfSeals(player2,_,P2,PlayerSeals):-
    PlayerSeals=P2.


play(Board,Player,1,P1,P2):-
    ((P1>0 ,Player = player1) ; (P2>0 ,Player = player2)),
	showTheBoard(Board),
    numOfSeals(Player,P1,P2,PlayerSeals),
	write('Turn: '),
	write(Player),
	nl,
    write('Remaining seals: '),write(PlayerSeals),nl,
	write('Select : '),
	read(N),
	move(Board,Player,N,1,P1,P2,_,_),
	nl,nl,
	sleep(0.1),!.

play(Board,Player,1,P1,P2):-
    write('YOU can NOT choose option 1'),nl,
    P1==0,
    howToPlay(Board,Player,P1,P2).

play(Board,Player,1,P1,P2):-
    write('YOU can NOT choose option 1'),nl,
    P2==0,
    howToPlay(Board,Player,P1,P2).


play(Board,Player,2,P1,P2):-
    showTheBoard(Board),
    write('Turn: '),
    write(Player),nl,
    write('Which tile do you want to choose?'),nl,
    read(N),
    move(Board,Player,N,2,P1,P2).

play(Board,Player,_,P1,P2):-
    howToPlay(Board,Player,P1,P2).


seal(player1,'w').
seal(player2,'b').


move(Board,Player,N,1,P1,P2,_,_):-
    N>16,
    write('Illegal move! Please select two numbers lesser than 17.'),nl,
    play(Board,Player,1,P1,P2).


move(Board,Player,N,1,P1,P2,_,_):-
    N<1,
    write('Illegal move! Please select two numbers higher than 0.'),nl,
    play(Board,Player,1,P1,P2).


move(Board,player1,N,1,P1,P2,P11,P22):-
    N<17,
    P11 is P1-1,
    P22=P2,
	seal(player1,S),
	set(Board,N,S,NBoard,P11,P22),
	changePlayer(player1,NPlayer),
	howToPlay(NBoard,NPlayer,P11,P22).

move(Board,player2,N,1,P1,P2,P11,P22):-
    N<17,
    P22 is P2-1,
    P11=P1,
	seal(player2,S),
	set(Board,N,S,NBoard,P11,P22),
	changePlayer(player2,NPlayer),
	howToPlay(NBoard,NPlayer,P11,P22).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



move(Board,Player,N,2,P1,P2):-
    N>16,
    write('Illegal move! Please select a number lesser than 17.'),nl,
    play(Board,Player,2,P1,P2).


move(Board,Player,N,2,P1,P2):-
    N<1,
    write('Illegal move! Please select a number higher than 0.'),nl,
    play(Board,Player,2,P1,P2).


move(Board,Player,N,2,P1,P2):-
    N<17,
    seal(Player,S),
    el(N,Board,Element),
    S\=Element,
    write('Choose another tile!'),nl,
    play(Board,Player,2,P1,P2).

move(Board,Player,N,2,P1,P2):-
    N<17,
    seal(Player,S),
    el(N,Board,Element),
    S==Element,
    write('Which direction do you want to move? up/down/left/right'),nl,
    read(Dir),nl,
    write('How many seals do you want to pick?'),nl,
    read(Num),
    checkIfAllowed(Board,Player,N,Dir,Num,P1,P2).
%%%%%%%%%%%%%
%%checkHeadAll([H|T],Number,H):-
  %%  Black(H,0),
    %%Number < 21,
%    NNumber is Number + 1,
 %   checkheadAll(T,NNumber,H).

%Black(H,NumB):-
 %   checkHeadAll(_,_,H),
  %  H == 'b',
   % NumB1 is NumB + 1,
    %NumB is NumB1.




%%%%%%%%%%%%%

%----------rev(L,L2)--------------

rev(L,L2):-
    rev(L,[],L2).

rev([],L,L).

rev([H|T],L2,L3):-
    rev(T,[H|L2],L3).

%---------sublist-----------
sublist([X|_],1,1,[X]).
sublist([],_,_,[]).% I use this one for the case bases
sublist([X|Xs],1,K,[X|Ys]):-
       K>1,
       K1 is K-1,
       sublist(Xs,1,K1,Ys).
sublist([_|Xs],I,K,Ys):-
       I > 1,
       I1 is I-1,
       sublist(Xs,I1,K,Ys).
%----------concat------------
conc([],L,L).
conc([H|T],T2,[H|T3]):-
    conc(T,T2,T3).
%------replace-
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > 0, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

%------trim--
trim( L     , 0 , L ):-!.
trim( [_|T] , N , R ) :-
  N > 0 ,
  N1 is N-1 ,
  trim( T , N1 , R )
  .


checkIfAllowed(Board,Player,N,_,Num,P1,P2):-
    Num>4,
    write('Try Again. select a number lesser than 5'),nl,
    move(Board,Player,N,2,P1,P2).


checkIfAllowed(Board,Player,N,up,_,P1,P2):-
    N1 is N-4,
    N1<1,
    write('Can not move this direction'),nl,
    move(Board,Player,N,2,P1,P2).


checkIfAllowed(Board,Player,N,down,_,P1,P2):-
    N1 is N+4,
    N1>16,
    write('Can not move this direction'),nl,
    move(Board,Player,N,2,P1,P2).

checkIfAllowed(Board,Player,N,left,_,P1,P2):-
    N1 is N mod 4,
    N1==1,
    write('Can not move this direction'),nl,
    move(Board,Player,N,2,P1,P2).


checkIfAllowed(Board,Player,N,right,_,P1,P2):-
    N1 is N mod 4,
    N1==0,
    write('Can not move this direction'),nl,
    move(Board,Player,N,2,P1,P2).

checkIfAllowed(Board,Player,N,up,Num,P1,P2):-
    N1 is N-4,
    ele(N,Board,L1), %-- list onsor N board ro be ma mide
    ele(N1,Board,L2), %-- list onsor N1 ro be ma mide
    sublist(L1,1,Num,L3), %--sublist onsor N
    conc(L3,L2,L4),
    replace(Board,N1,L4,NBoard),
    trim(L1,Num,L5),
    replace(NBoard,N,L5,NnBoard),
    changePlayer(Player,NPlayer),
	howToPlay(NnBoard,NPlayer,P1,P2).

checkIfAllowed(Board,Player,N,down,Num,P1,P2):-
    N1 is N+4,
    ele(N,Board,L1), %-- list onsor N board ro be ma mide
    ele(N1,Board,L2), %-- list onsor N1 ro be ma mide
    sublist(L1,1,Num,L3), %--sublist onsor N
    conc(L3,L2,L4),
    replace(Board,N1,L4,NBoard),
    trim(L1,Num,L5),
    replace(NBoard,N,L5,NnBoard),
    changePlayer(Player,NPlayer),
    howToPlay(NnBoard,NPlayer,P1,P2).


checkIfAllowed(Board,Player,N,left,Num,P1,P2):-
    N1 is N-1,
    ele(N,Board,L1), %-- list onsor N board ro be ma mide
    ele(N1,Board,L2), %-- list onsor N1 ro be ma mide
    sublist(L1,1,Num,L3), %--sublist onsor N
    conc(L3,L2,L4),
    replace(Board,N1,L4,NBoard),
    trim(L1,Num,L5),
    replace(NBoard,N,L5,NnBoard),
    changePlayer(Player,NPlayer),
	howToPlay(NnBoard,NPlayer,P1,P2).

checkIfAllowed(Board,Player,N,right,Num,P1,P2):-
    N1 is N+1,
    ele(N,Board,L1), %-- list onsor N board ro be ma mide
    ele(N1,Board,L2), %-- list onsor N1 ro be ma mide
    sublist(L1,1,Num,L3), %--sublist onsor N
    conc(L3,L2,L4),
    replace(Board,N1,L4,NBoard),
    trim(L1,Num,L5),
    replace(NBoard,N,L5,NnBoard),
    changePlayer(Player,NPlayer),
	howToPlay(NnBoard,NPlayer,P1,P2).


%----------getting HEAD of an element
el(N,Board,Element):-
    el2(N,1,Board,Element).


el2(N,J,[[H|_]|_],Element):-
    N==J,
    Element=H,!.


el2(N,J,[_|T],Element):-
    N\=J,
    J2 is J+1,
    el2(N,J2,T,Element).

%----------getting an element
ele(N,Board,Element):-
    ele2(N,1,Board,Element).


ele2(N,J,[H|_],Element):-
    N==J,
    Element=H,!.


ele2(N,J,[_|T],Element):-
    N\=J,
    J2 is J+1,
    ele2(N,J2,T,Element).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


upDownWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_],_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_]].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],_,_,_,[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],_,_,_,[S|_],[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],_,_,_,[S|_],[S|_],[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_]].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],_,_,_,[S|_],_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],[S|_],_,_,_,[S|_],_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],[S|_],[S|_],_,_,_,[S|_]].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],_,_,[S|_],[S|_],_,_,[S|_],_,_,_,[S|_],_,_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],_,_,_,[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],_,_,_,[S|_],[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_]].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],_,_,_,[S|_],_,_,[S|_],[S|_],_,_,[S|_],_,_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],_,_,_,[S|_],_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],[S|_],_,_,_,[S|_]].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],_,[S|_],[S|_],[S|_],_,[S|_],_,_,_,[S|_],_,_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],_,_,[S|_],[S|_],_,_,[S|_],_,_,_,[S|_],_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],_,_,_,[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_]].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],_,_,_,[S|_],_,[S|_],[S|_],[S|_],_,[S|_],_,_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],_,_,_,[S|_],_,_,[S|_],[S|_],_,_,[S|_],_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],_,_,_,[S|_]].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,[S|_],[S|_],[S|_],[S|_],[S|_],[S|_],_,_,_,[S|_],_,_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,[S|_],_,[S|_],[S|_],[S|_],_,[S|_],_,_,_,[S|_],_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,[S|_],_,_,[S|_],[S|_],_,_,[S|_],_,_,_,[S|_],_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,[S|_],_,_,_,[S|_],[S|_],[S|_],[S|_],[S|_],[S|_],_,_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,[S|_],_,_,_,[S|_],_,[S|_],[S|_],[S|_],_,[S|_],_,_].

upDownWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,[S|_],_,_,_,[S|_],_,_,[S|_],[S|_],_,_,[S|_],_].

%----------------------------------------------------------------------

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],[S|_],[S|_],[S|_],_,_,_,_,_,_,_,_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,[S|_],[S|_],[S|_],[S|_],_,_,_,_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,_,_,_,[S|_],[S|_],[S|_],[S|_],_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,_,_,_,_,_,_,_,[S|_],[S|_],[S|_],[S|_]].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],[S|_],_,_,_,[S|_],[S|_],[S|_],_,_,_,_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],[S|_],_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],[S|_]].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],[S|_],[S|_],_,_,_,[S|_],[S|_],_,_,_,_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [[S|_],[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_]].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],[S|_],[S|_],[S|_],[S|_],_,_,_,_,_,_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,[S|_],[S|_],_,_,_,[S|_],[S|_],[S|_],_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_],[S|_]].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],[S|_],[S|_],[S|_],[S|_],_,_,_,_,_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,[S|_],[S|_],[S|_],_,_,_,[S|_],[S|_],_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,[S|_],[S|_],[S|_],_,_,_,[S|_],_,_,_,[S|_],[S|_]].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],[S|_],[S|_],_,[S|_],_,_,[S|_],[S|_],_,_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,[S|_],[S|_],[S|_],[S|_],[S|_],_,_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,_,_,_,[S|_],[S|_],_,_,_,[S|_],[S|_],[S|_]].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],[S|_],_,_,[S|_],_,[S|_],[S|_],[S|_],_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,_,[S|_],[S|_],[S|_],[S|_],[S|_],_,_,_,_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,_,_,_,[S|_],[S|_],[S|_],_,_,_,[S|_],[S|_]].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,[S|_],[S|_],[S|_],_,[S|_],_,_,_,[S|_],_,_,[S|_],[S|_],_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,[S|_],[S|_],[S|_],_,[S|_],_,_,[S|_],[S|_],_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,_,_,_,_,[S|_],[S|_],[S|_],[S|_],[S|_],_,_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,[S|_],[S|_],_,_,[S|_],_,_,_,[S|_],_,[S|_],[S|_],[S|_],_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,_,[S|_],[S|_],_,_,[S|_],_,[S|_],[S|_],[S|_],_].

leftRightWin(Board, Player):-
    seal(Player,S),
    Board = [_,_,_,_,_,_,_,_,_,_,[S|_],[S|_],[S|_],[S|_],[S|_],_].


win(Board, Player) :- upDownWin(Board, Player).
win(Board, Player) :- leftRightWin(Board, Player).


