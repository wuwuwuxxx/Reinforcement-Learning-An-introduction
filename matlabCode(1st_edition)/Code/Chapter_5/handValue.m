function [hv,usableAce] = handValue(hand)
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

% compute 1:13 indexing for each card: 
values = mod( hand - 1, 13 ) + 1; 
% map face cards (11,12,13)'s to 10's: 
values = min( values, 10 );
sv     = sum(values); 
% Promote soft ace
if (any(values==1)) && (sv<=11)
   sv = sv + 10;
   usableAce = 1; 
else
   usableAce = 0; 
end

hv = sv; 
