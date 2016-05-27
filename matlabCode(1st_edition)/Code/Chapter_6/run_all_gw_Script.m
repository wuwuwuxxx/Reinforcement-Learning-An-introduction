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

windy_gw_Script; drawnow; clc; 
wgw_w_kings_Script; drawnow; clc; 
wgw_w_kings_n_wind_Script; drawnow; clc; 
wgw_w_stoch_wind_Script; drawnow; clc; 

figure; 
ph1=plot( 1:length(ets), windy_gw_ets, '-' ); hold on; 
ph2=plot( 1:length(ets), wgw_w_kings_ets, ':r' ); 
ph3=plot( 1:length(ets), wgw_w_kings_n_wind_ets, '-.g' ); 
ph4=plot( 1:length(ets), wgw_w_stoch_wind_ets, '--m' ); 
legend( [ph1,ph2,ph3,ph4], { 'four actions', 'with king', 'king n wind', 'stochastic' } ); 
xlabel( 'number of episodes' ); ylabel( '' ); 

% compute the average number of iterations needed to find the target denstination for each of the four methods:
% 
t1 = diff(windy_gw_ets); 
t2 = diff(wgw_w_kings_ets);
t3 = diff(wgw_w_kings_n_wind_ets); 
t4 = diff(wgw_w_stoch_wind_ets); 
fprintf('the mean number of timestep per episodes with the four methods is\n'); 
fprintf('windy gw=%f; w_kings=%f, w_k_n_wind=%f; stoc=%f\n',mean(t1(1000:end)),mean(t2(1000:end)),mean(t3(1000:end)),mean(t4(1000:end)))
