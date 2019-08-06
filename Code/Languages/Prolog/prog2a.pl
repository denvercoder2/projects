% Scott Holley
% CS424 Program 2a, Implementation of Intersection and a Check for disjoint
% Disjoint meaning that two lists do not share the same element
% All work is my own.
%-----------------------------------------------------%
% Disjoint Rule:
% Two sets A and B are disjoint if and only if their intersection is the empty set
%----------------------------------------------------%

% this check function checks the list to see if it contains
% an element that is also an element of the other list
check(X,[X|_]) :- !.
check(X,[_|T]):- check(X,T).

% disjoint_check tales two lists and makes the comparison using the 
% above check function
disjoint_check([], _, []).
disjoint_check([Head|T1tail], T2, T3) :-
        check(Head, T2), !, T3 = [Head|T3_end],

        % since the point of the program was to implement disjoint, logically, disjoint is true
        % only if intersection is not true, meaning that the list returned is not populated with any
        % element that is in both lists. These functions do comparisons on both lists and return elements 
        % they share, so if they do not contain an intersection, then the lists are disjoint
        
        % Statement that only appears if the two lists share elements
        writeln('\n            --------------------------------------------------------------------------------------
            Not disjoint because intersection returned value(s) that was present in both lists
            --------------------------------------------------------------------------------------.\n'),
        disjoint_check(T1tail, T2, T3_end).

% this will compare the elements of the first list with the elements of the second list
% if the first list has only 2 elements, for example, there are only two compare statements
% disjoint check will compare the element in list one with every element in list two
% and return a blank list if they do not share any elements (i.e. Disjoint property)

disjoint_check([_|T1tail], T2, T3) :-
     % Statement that only appears if the two lists do not share elements
    writeln('\n        -------------------------------------------------------------------------------------------------
        Checking if element is in both lists... Element does not apear in other list.  (Disjoint is true.)
        -------------------------------------------------------------------------------------------------'),
        disjoint_check(T1tail, T2, T3).
%--------------------------------------------------------------------------------------------------------------%

    % To run this based on the logic I've implemented use: disjoint_check([list 1], [list 2], L)
    % L will return the common elements if they share any which disproves the disjoint attribute, there is a message explaining this
    % If the list is returned empty, then the disjoint attribute is present as the two lists share no elements. 
    % It will check for each element you give it in the list
%--------------------------------------------------------------------------------------------------------------%
