function [st] = stateFromHand(hand,cardShowing)
%
% Returns the state (a three vector of numbers for a given hand of cards)
% 
% [players current sum, dealar showing card, usable ace] 
% 
% Cards are enoumerated 1:52, such that
% 
%  1:13 => A, 2, 3, ..., 10, J, Q, K      (of C)
% 14:26                                   (of D)
%                                         (of H)
%                                         (of S)
%
% Written by:
% -- 
% John L. Weatherwax                2007-12-07
% 
% email: wax@alum.mit.edu
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----

[hv,usableAce] = handValue(hand);

cardShowing = mod( cardShowing - 1, 13 ) + 1; 

st = [ hv, cardShowing, usableAce ]; 

return; 




