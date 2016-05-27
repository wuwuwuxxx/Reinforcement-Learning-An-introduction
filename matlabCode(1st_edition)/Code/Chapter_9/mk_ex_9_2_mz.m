function A = mk_ex_9_2_mz(ts)
% MK_EX_9_2_MZ - Makes the maze for example 9.2
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

if( ts<1000 )
  A(4,1:8) = 1;  % the first maze
else
  A(4,2:9) = 1;  % the second maze
end

