% DYNAQPLUS_MAZE_SCRIPT - Implements the DynaQ Algorithm on the simple maze example found in Chapter 9
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

% get our initial maze (the blocking maze): 
MZ = mk_ex_9_2_mz(0); [sideII,sideJJ] = size(MZ); 

% the beginning and terminal states (in matrix notation): 
s_start = [ 6, 4 ]; 
s_end   = [ 1, 9 ]; 

MAX_N_STEPS=30; 
%MAX_N_STEPS=1e3;
MAX_N_STEPS=1e4;
MAX_N_STEPS=1e5;
%MAX_N_STEPS=1e6;
%MAX_N_STEPS=10e6;

% the number of steps to do in planning: 
%nPlanningSteps = 0; 
nPlanningSteps = 5; 
%nPlanningSteps = 50; 
nPSV = [ 0, 5, 50 ]; 

% a factor relating how important revisiting old states is, relative to 
% the past recieved reward coming from these states/action pairs ... 
%kappa = 0.02; 
kappa = 2/sqrt(MAX_N_STEPS); 

allCR = zeros(2*length(nPSV),MAX_N_STEPS); 
for npsi=1:length(nPSV),
  nPlanningSteps = nPSV(npsi);
  
  [Q,ets,cr] = dynaQplus_maze(alpha,epsilon,gamma,kappa,nPlanningSteps,@mk_ex_9_2_mz,s_start,s_end,MAX_N_STEPS);
  allCR(npsi,:) = cr(2:end); 
  fhl{npsi} = sprintf('dynaQplus: %d planning steps',nPlanningSteps); 
  
  [Q,ets,dum1,dum2,dum3,cr] = dynaQ_maze(alpha,epsilon,gamma,nPlanningSteps,@mk_ex_9_2_mz,s_start,s_end,MAX_N_STEPS);
  allCR(length(nPSV)+npsi,:) = cr(2:end); 
  fhl{length(nPSV)+npsi} = sprintf('dynaQ: %d planning steps',nPlanningSteps); 
end

figure; fhs=plot( (1:3000), allCR(:,2:3001), '-' ); 
title( 'cummulative reward' ); grid on;
xlabel('timestep index'); ylabel('cum. reward'); drawnow; 
legend( fhs, fhl, 'Location', 'NorthWest' );
fn = sprintf('blocking_dynaQplus_vs_dyanQ_cum_reward'); saveas( gcf, fn, 'png' ); 

clear functions;
%close all; 
return; 
