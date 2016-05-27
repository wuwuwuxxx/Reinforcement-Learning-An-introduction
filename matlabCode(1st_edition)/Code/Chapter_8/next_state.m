function [rew,stp1] = next_state(st,ai,pos_bnds,mcar_goal_position,vel_bnds)
% NEXT_STATE - Returns the next state stating in state st and taking action ai
%   
% Note that this is specialized somewhat for the mountain example from Sutton's book
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

stp1 = st; 
stp1(2) = stp1(2) + (ai-2)*0.001 + cos(3*st(1))*(-0.0025); 
if( stp1(2) > vel_bnds(2) ) stp1(2) = vel_bnds(2); end; 
if( stp1(2) < vel_bnds(1) ) stp1(2) = vel_bnds(1); end; 

stp1(1) = stp1(1) + stp1(2); 
if( stp1(1) > pos_bnds(2) ) stp1(1) = pos_bnds(2); end; 
if( stp1(1) < pos_bnds(1) ) stp1(1) = pos_bnds(1); end; 
if( (stp1(1)==pos_bnds(1)) && (stp1(2)<0) ) stp1(2) = 0.0; end

if( stp1(1) >= mcar_goal_position )
  rew =  0.0;
else
  rew = -1.0; 
end

