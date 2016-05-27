function A = mk_ex_9_1_mz(ts)
% MK_EX_9_1_MZ - Makes the maze for example 9.1
%   
% Ones correspond to locations we can be.
% 
% Inputs:
%   ts: the timestep ... if the maze changes type after some point 
%       we can capture this behaviour with this switch
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

A = zeros(6,9); 
A(2:4,3) = 1; 
A(1:3,8) = 1; 
A(5,6) = 1; 


