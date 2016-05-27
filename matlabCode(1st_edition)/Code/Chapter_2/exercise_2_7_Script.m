% 
% A nonstationarity problem where the true action values start off equal and
% then follow individual random walks.  We compare two methods 
% 
% 1) estimating the action value using simple averages AND
% 2) estimating the action value using a constant geometric factor $\alpha=0.1$.
% 
% Inputs: 
%   nB: the number of bandits
%   nA: the number of arms
%   nP: the number of plays (times we will pull a arm)
%   sigmaReward: the standard deviation of the return from each of the arms
%   sigmaRW: the standard deviation of the random walk
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

%---
% My hypothesis is that as sigmaRW -> \infty alpha updating will perform better method 
%---

%nB=2000; nA=10; nP=5000; sigmaReward=1.0; sigmaRW=1.0; 
%exercise_2_7(nB,nA,nP,sigmaReward,sigmaRW);

%nB=2000; nA=10; nP=5000; sigmaReward=1.0; sigmaRW=10.0; 
%exercise_2_7(nB,nA,nP,sigmaReward,sigmaRW);

nB=2000; nA=10; nP=5000; sigmaReward=1.0; sigmaRW=30.0; 
exercise_2_7(nB,nA,nP,sigmaReward,sigmaRW);

