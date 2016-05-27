function [Q_st,ai,F] = ret_q_in_st(st,theta,nActions,dp,dv,nTilings,memory_size, epsilon)
% RET_Q_IN_ST - Returns the value of Q as a function of the actions in the state st
%             - also returns an epsilon greedy action selection based on Q(:) 
%             - also the feature lists "F" for all possible actions ai
%   
% Note that this is specialized somewhat for the mountain car example from Sutton's book
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

Q_st = zeros(1,nActions); 
F    = zeros(nActions,nTilings); 
for ai=1:nActions,
  sts(1)   = st(1)/dp; sts(2) = st(2)/dv; % scale our state so that it is within unit intervals: 
  F(ai,:)  = GetTiles_Mex(nTilings,sts,memory_size,ai);
  Q_st(ai) = sum( theta(F(ai,:)) ); 
end
% pick an action according to and epsilon greedy policy Q: 
[Q_max,ai] = max(Q_st); 
if( rand < epsilon )
  tmp=randperm(nActions); ai=tmp(1); 
end
