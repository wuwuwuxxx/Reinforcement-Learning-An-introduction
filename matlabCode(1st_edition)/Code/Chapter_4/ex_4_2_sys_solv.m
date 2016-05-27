%
% Written by:
% -- 
% John L. Weatherwax                2007-12-03
% 
% email: wax@alum.mit.edu
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----

gamma = 0.9;

A = [ 1, -gamma/4; -gamma/4, (1-gamma/4) ];
b = [ -1-14*gamma, -1-9*gamma ]; 

vs = A \ b(:)


