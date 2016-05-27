function [deck] = shufflecards()
%
% Returns a shuffled deck of cards.
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

deck = randperm( 52 ); 
