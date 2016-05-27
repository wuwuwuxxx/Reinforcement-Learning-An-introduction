% MNT_EXAMPLE_SCRIPT - Solve the mountain valley problem, using linear, gradient-decent SARSA(\lambda)
% with binary features and an \epsilon-greedy policy
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

clc; close all; 

% the probabiity of an exploratory move: 
epsilon = 0.0; 

% discount factor: 
gamma = 1.0; 
%gamma = 0.9; 

% the learning parameter: 
%alpha = 0.5; 
alpha = 0.005; 

% blending parameter: 
lambda = 0.9; 

% the type of elagability trace (accumulating or replacing)
%ACC_ET = 1; 
ACC_ET = 0; 

% How many episodes we will learn from:
nEpisodes = 1e1; 
nEpisodes = 1e2; %
nEpisodes = 9e3; % <- official number of max total number of epsiodes ...

[theta,avg_ts_per_episode] = mnt_car_learn(nEpisodes, epsilon,gamma,alpha,lambda,ACC_ET, 1);
fprintf('avg_ts_per_episode = %10.3f\n',avg_ts_per_episode); 
