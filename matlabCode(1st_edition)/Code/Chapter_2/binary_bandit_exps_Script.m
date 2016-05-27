% 
% Duplicates the binary bandit experiments.
% 
% Inputs: 
%   nB: the number of bandits
%   nP: the number of plays (times we will pull a arm)
%   p_win: p_win(i) is the probability we win when we pull arm i.
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

close all; 
clc; 
clear; 

% binary bandit A: 
nB=2000; nP=500; p_win = [0.1, 0.2]; % <- the first hard problem 


nB=2000; nP=500; p_win = [0.9, 0.1]; % <- try an easy problem 
nB=2000; nP=500; p_win = [0.05, 0.85]; % <- another easy problem 

% binary bandit B: 
%nB=2000; nP=500; p_win = [0.8, 0.9]; % <- another hard problem
%binary_bandit_exps(nB,nP,p_win);


binary_bandit_exps;

