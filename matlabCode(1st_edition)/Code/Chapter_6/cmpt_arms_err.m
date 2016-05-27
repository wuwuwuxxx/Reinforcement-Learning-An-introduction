function [armsErr_TD,armsErr_MC] = cmpt_arms_err(nTrials,alpha)
% 
% Written by:
% -- 
% John L. Weatherwax                2008-01-10
% 
% email: wax@alum.mit.edu
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----

% for statistical significance have this many samples for each walk trial: 
N_MC_TRAILS = 100; 

% the true state value function: 
truth = (1:5)/6;

armsErr_TD = zeros(1,nTrials); samps_TD = zeros(1,N_MC_TRAILS); 
armsErr_MC = zeros(1,nTrials); samps_MC = zeros(1,N_MC_TRAILS); 
for nw=1:nTrials,
  for mi=1:N_MC_TRAILS,
    [Vtd,Vmc] = eg_6_2_learn(nw,alpha);
    samps_TD(mi) = sqrt(mean((Vtd-truth).^2)); 
    samps_MC(mi) = sqrt(mean((Vmc-truth).^2)); 
  end  
  armsErr_TD(nw) = mean(samps_TD); 
  armsErr_MC(nw) = mean(samps_MC); 
end

