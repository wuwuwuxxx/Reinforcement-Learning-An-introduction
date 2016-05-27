%function [] = mk_batch_arms_error_plt()
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

% do this experiment 100 times
%N_MC_REPITIONS=5; 
N_MC_REPITIONS=100; 

% for each experiment generate up to this many episodes:
N_EPSODES=100; 

%alpha=0.01; 
alpha=0.001; 

allRuns = zeros(N_MC_REPITIONS,N_EPSODES,2); 
for mci=1:N_MC_REPITIONS,
  [allRuns(mci,:,1),allRuns(mci,:,2)]=eg_rw_batch_learn(N_EPSODES,alpha); 
  clc; 
end

allRuns2 = squeeze(mean(allRuns,1))

figure; 

%
% TD/MC plots: 
h = plot( allRuns2(:,1), 'b-x' ); ah = [h]; 
hold on; 
h = plot( allRuns2(:,2), 'g-o' ); ah = [ah; h]; 

xlabel('walks/trials'); ylabel('average RMS error (batch algo.)'); 
legend( ah, { 'MC', 'TD' } ); grid on; 

fn='batch_constant_mc_vs_td.eps'; saveas( gcf, fn, 'eps2' ); 







