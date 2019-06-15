% Scott Holley
% CS424 Program 2b, Family Tree in prolog
% All work is my own.

%--------------------------------------------------------------------------%
male(scott).        % me
male(scotty).       % my dad
male(christian).    % brother
male(josh).         % cousin
male(james).        % fake son
male(joe).          % grandfather
male(joey).         % uncle
male(jimmy).        % bro dad
male(bobby).        % sis dad 

female(tiffany).    % grandmother
female(rose).       % my mom
female(mary).       % sister
female(amber).      % fake daughter
female(janie).      % sis mom
female(sarah).      % bro mom

parent(scotty,scott).       % dad and me
parent(bobby,mary).        % dad and sister
parent(jimmy,christian).   % dad and brother
parent(rose,scott).         % mom and me
parent(janie,mary).         % mom and sister
parent(sarah,christian).    % mom and brother
parent(joe,rose).           % grandpa and mom
parent(tiffany,rose).       % grandma and mom
parent(joe, joey).          % grandpa and uncle
parent(tiffany, joey).      % grandma and uncle
parent(mickey,josh).        % cousin
parent(scott,amber).        % fake daughter
parent(scott,james).        % fake son
parent(joey,josh).          % cousin and uncle


% father is both male and has parent relationship (child, parent)
father(X,Y) :- male(X), parent(X,Y).
% mother is both female and has parent relationship (child, parent)
mother(X,Y) :- female(X), parent(X,Y).
% uncle is brother and shares parent with mom, being a brother, he is also male
uncle(X,Y) :- brother(X,Mom), parent(Mom,Y).
%--------------------------------------------------------------------------%
% son is male and has a parent relationship of (parent, son)
son(X,Y) :- male(X), parent(Y,X).
% daughter is female and has a parent relationship of (parent, son)
daughter(X,Y) :- female(X), parent(Y,X).
%--------------------------------------------------------------------------%
% grandfather is male and has a parent relationship of (parent, child) and hence has relationship (grandparent, parents child)
grandfather(X,Y) :- male(X), parent(X,Person), parent(Person,Y).
% grandmother is male and has a parent relationship of (parent, child) and hence has relationship (grandparent, parents child)
grandmother(X,Y) :- female(X), parent(X,Person), parent(Person,Y).
%--------------------------------------------------------------------------%
% sister is female and and shares parent relationship 
sister(X,Y) :- female(X), parent(Par,X), parent(Par,Y), X \= Y.
% brother is male and shares parent relationship with other siblings
brother(X,Y) :-  male(X), parent(Person,X),parent(Person,Y), X \= Y.
% cousin has uncle which is brother of mom, and is the son of moms brother (has a father relationship)
cousin(X,Y) :- uncle(U,X), male(X), father(U,Y).
%--------------------------------------------------------------------------%

 