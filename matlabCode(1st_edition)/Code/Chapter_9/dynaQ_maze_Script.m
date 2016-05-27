% DYNAQ_MAZE_SCRIPT - Implements the DynaQ Algorithm on the simple maze example found in Chapter 9
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

close all; 
clc; 

% sample_discrete.m
addpath( genpath( '../../../FullBNT-1.0.4/KPMstats/' ) ); 

% the learning rate: 
alpha = 1e-1; 

% the probability of a random action (non-greedy): 
epsilon = 0.1; 

% the discount factor: 
gamma = 0.95;
%gamma = 1.0; 

% the beginning and terminal states (in matrix notation): 
s_start = [ 3, 1 ]; 
s_end   = [ 1, 9 ]; 

MAX_N_STEPS=30; 
%MAX_N_STEPS=1e3;
MAX_N_STEPS=1e4;
MAX_N_STEPS=1e5;
MAX_N_STEPS=1e6;
%MAX_N_STEPS=10e6;

% the number of steps to do in planning: 
nPlanningSteps = 0; 
nPlanningSteps = 5; 
nPlanningSteps = 50; 

[Q,ets,numFinishes,Model_ns,Model_nr] = dynaQ_maze(alpha,epsilon,gamma,nPlanningSteps,@mk_ex_9_1_mz,s_start,s_end,MAX_N_STEPS);

% get our initial maze: 
MZ = mk_ex_9_1_mz(0); [sideII,sideJJ] = size(MZ); 

% compute the (negative) cost to go and the optimal (greedy with respect to the state-value function) policy: 
pol_pi = zeros(sideII,sideJJ); V = zeros(sideII,sideJJ); 
for ii=1:sideII,
  for jj=1:sideJJ,
    sti = sub2ind( [sideII,sideJJ], ii, jj ); 
    [V(ii,jj),pol_pi(ii,jj)] = max( Q(sti,:) ); 
  end
end

plot_mz_policy(pol_pi,MZ,s_start,s_end);
title( 'policy (1=>up,2=>down,3=>right,4=>left); start=green; stop=red' ); 
fn = sprintf('dynaQ_maze_policy_nE_%d',MAX_N_STEPS); saveas( gcf, fn, 'png' ); 

figure; imagesc( V ); colormap(flipud(jet)); colorbar; 
title( 'state value function' ); 
fn = sprintf('dynaQ_maze_state_value_fn_nE_%d',MAX_N_STEPS); saveas( gcf, fn, 'png' ); 

figure; plot( 1:length(ets), ets, '-x' ); 
title( sprintf('timesteps to reach goal (number of Planning steps=%5d)',nPlanningSteps) ); grid on; drawnow; 
fn = sprintf('dynaQ_q_learning_rate_nPS_%d',nPlanningSteps); saveas( gcf, fn, 'png' ); 

%close all; 
clear functions; 
return; 
