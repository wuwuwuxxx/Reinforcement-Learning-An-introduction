% 
% We need execute (at the shell) the following: 
% 
% export LD_PRELOAD=/lib/libgcc_s.so.1
% 
% Written by:
% -- 
% John L. Weatherwax                2008-02-19
% 
% email: wax@alum.mit.edu
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----

% create the mex file to drive the "tiles.C" code: 
%
mex GetTiles_Mex.C tiles.C

% we duplicate the example on the web page: 
vars_array = [ rand, rand ]/0.25; 

num_tilings = 10; 

memory_size = 3*10*10*10; 

a = 1; 

tiles = GetTiles_Mex(num_tilings,vars_array,memory_size,a); 

for ai=1:3,
  tiles = GetTiles_Mex(num_tilings,vars_array,memory_size,ai)
end

% check in a very dumb way for memory leaks: 
tic
for ai=1:300000,
  tiles = GetTiles_Mex(num_tilings,vars_array,memory_size,ai);
end
toc


clear functions; 



