% 
% Demonstrate the technique of optimisitc initial values
% We compare two methods both epsilon=0.1 greedy
% 
% 1) evaluate the algorithm performance when the initial action values are taken = +5
% 2) evaluate the algorithm performance when the initial action values are taken = 0
% 
% Inputs: 
%   nB: the number of bandits
%   nA: the number of arms
%   nP: the number of plays (times we will pull a arm)
%   sigmaReward: the standard deviation of the return from each of the arms
% 
% Written by:
% -- 
% John L. Weatherwax                2007-11-13
% 
% email: wax@alum.mit.edu
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----

%close all; 

nB=2000; nA=10; nP=1000; sigmaReward=1.0; 
opt_initial_values(nB,nA,nP,sigmaReward);
