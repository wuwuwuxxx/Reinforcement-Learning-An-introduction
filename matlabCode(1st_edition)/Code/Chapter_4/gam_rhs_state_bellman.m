function [v_tmp] = gam_rhs_state_bellman(s,a,V,gamma,p_head)
% GAM_RHS_STATE_BELLMAN - computes the right hand side of the bellman equation for the gambler example
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

s_head = s+a; % we win an additional amount "a"
s_tail = s-a; % we loose our bet "a"

v_tmp = p_head*V(s_head+1) + (1-p_head)*V(s_tail+1);

return; 

if( s_head >= 100 ) % we win "1" if we get a head and enter a terminal state "100"
  v_tmp = p_head*( 1 ); s_head = 100; 
else                % otherwise our reward is zero and our new state is s_head 
  v_tmp = p_head*( 0 + gamma*V(s_head+1) ); 
end

if( s_tail <= 0 )  % we loose all our money on a tail and enter a terminal state "0"
  s_tail = 0; v_tmp = v_tmp + (1-p_head)*0;
else               % otherwise our reward is zero and our new state is s_tail
  v_tmp = v_tmp + (1-p_head)*( 0 + gamma*V(s_tail+1) ); 
end





