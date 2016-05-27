function [rewseen,stateseen] = eg_7_5_episode(n_rw_states)
% EG_7_5_EPISODE - simulate the states and rewards for a markov chain 
% where with a fixed probability p we cycle back to our current state and 
% with a fixed probability 1-p we transition to the state to the right of 
% the current state.
%
% The reward is +1 on entering the rightmost terminal state.
% 
% n_rw_states: the number of non-terminal states 
% 
% we return states in the range [1,n_rw_states+1].
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

% the probabiilty of a transition=p (q=probablity we stay in the same state):
p = 0.5; q = 1-p; 
%p = 0.25; q = 1-p; 
%p = 0.05; q = 1-p; 

% start at the left most state: 
st = 1; stateseen = [st]; rewseen = []; 

while( st < (n_rw_states+1) )
  % go forward sometimes; stay at the same location otherwise:
  if( rand<p )
    stp1=st+1; 
  else
    stp1=st;
  end
  
  % assign a reward for this step ... do the most common case first: 
  if( (stp1~=(n_rw_states+1)) )
    rew = 0; 
  else
    rew = +1; 
  end
  
  % save everything: 
  rewseen   = [rewseen, rew]; 
  stateseen = [stateseen, stp1]; 
  st = stp1; 
end

