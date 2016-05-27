function [rewseen,stateseen] = rw_episode(n_rw_states)
% RW_EPISODE - simulate the states and rewards for a random walk 
% 
% n_rw_states: the number of non-terminal states 
% 
% Note: in the inner loop the terminal states are 
% "0" for the left end and 
% "n_rw_states+1" for the right end, 
% 
% we then add one to put the return states in the range [1,n_rw_states+2].
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

% start in the middle state:
st = round(0.5*(n_rw_states+1)); stateseen = [st]; rewseen = []; 

while( (0 < st) && (st < (n_rw_states+1)) )
  % go left half of the time; right half of the time: 
  if( rand<0.5 )
    stp1=st+1; 
  else
    stp1=st-1;
  end
  
  % assign a reward for this step ... do the most common case first: 
  if( (stp1~=0) && (stp1~=(n_rw_states+1)) )
    rew = 0; 
  else
    if( stp1==0 ) 
      rew = -1; 
      %rew = 0; 
    else
      rew = +1; 
    end
  end
  
  % save everything: 
  rewseen   = [rewseen, rew]; 
  stateseen = [stateseen, stp1]; 
  st = stp1; 
end

% return "one" based states: 
stateseen=stateseen+1; 


