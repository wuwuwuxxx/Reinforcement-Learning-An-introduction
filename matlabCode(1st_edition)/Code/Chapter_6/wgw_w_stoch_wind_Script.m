% WGW_W_STOCH_WIND_Script - Performs on-policy sarsa iterative action value funtion estimation for the 
% windy grid world example alowing kings (diagonal) moves and a stochastic wind.
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

% sample_discrete.m
addpath( genpath( '../../../FullBNT-1.0.4/KPMstats/' ) );

close all; 

alpha = 1e-1; 

sideII  = 7; sideJJ = 10; 

% the wind in each column: 
wind = [ 0 0 0 1 1 1 2 2 1 0 ]; 

% the beginning and terminal states (in matrix notation): 
s_start = [ 4, 1 ]; 
s_end   = [ 4, 8 ]; 

MAX_N_EPISODES=20; 
MAX_N_EPISODES=1e4;
%MAX_N_EPISODES=1e5;
%MAX_N_EPISODES=1e6;
MAX_N_EPISODES=10e6;

[Q,ets] = wgw_w_stoch_wind(alpha,sideII,sideJJ,s_start,s_end,wind,MAX_N_EPISODES);

pol_pi = zeros(sideII,sideJJ); V = zeros(sideII,sideJJ); 
for ii=1:sideII,
  for jj=1:sideJJ,
    sti = sub2ind( [sideII,sideJJ], ii, jj ); 
    [V(ii,jj),pol_pi(ii,jj)] = max( Q(sti,:) ); 
  end
end

plot_gw_policy(pol_pi,s_start,s_end,wind);
title( 'policy (1=>up,2=>down,3=>right,4=>left,5=>NW,6=>NE,7=>SE,8=>SW)' ); 
fn = sprintf('wgw_w_stoch_wind_policy_nE_%d',MAX_N_EPISODES); saveas( gcf, fn, 'png' ); 

figure; imagesc( V ); colorbar; 
title( 'state value function' ); 
fn = sprintf('wgw_w_stoch_wind_state_value_fn_nE_%d',MAX_N_EPISODES); saveas( gcf, fn, 'png' ); 

figure; plot( 1:length(ets), ets, '-x' ); wgw_w_stoch_wind_ets = ets; 
%fn = sprintf('wgw_w_stoch_wind_learning_rate_nE_%d',MAX_N_EPISODES); saveas( gcf, fn, 'fig' ); 
