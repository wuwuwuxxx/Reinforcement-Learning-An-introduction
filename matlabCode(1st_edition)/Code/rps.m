function Q = rps(N_EPISODES)
% RPS - Solve for the optimal rock/paper/scissors policy using Q-learning.
% 
% We have one state with three possible actions (enoumerated above)
% 
% The rewards are +1 if we win, 0 if we draw, and -1 if we loose.
% 
% The expected policy is [1,1,1]/3 or a random draw (from the possible choices) 
% during each play 
% 
% We assume that the opponent plays randomly
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

% the probability we take an exploratory step: 
epsilon = 0.1; 

% our learning rate: 
alpha = 0.2; 

% the discount factor: 
gamma = 1.0; 
%gamma = 0.9; 

% the number of actions: 
nActions = 3; 

% Our action-value function: 
Q = zeros(1,nActions); 

% play this many games: 
%N_EPISODES=1e5; 

for ei=1:N_EPISODES,
  % pick the max action to play
  [dum,ai]=max(Q); 
  if( rand<epsilon )
    tmp=randperm(nActions); ai=tmp(1); 
  end
  % if opponent plays randomly then the o(pponents) a(ction) is:
  tmp=randperm(nActions); oa=tmp(1); 
  % determine our reward (only one "if" statement will be executed):
                                       % ( OUR PLAY, THEIR PLAY )
  if( ai==1 && oa==1 ) rew =  0; end   % (   rock  ,    rock    )
  if( ai==1 && oa==2 ) rew = -1; end   % (   rock  ,    paper   )
  if( ai==1 && oa==3 ) rew = +1; end   % (   rock  ,   scissors )
  if( ai==2 && oa==1 ) rew = +1; end   % (   paper ,    rock    )
  if( ai==2 && oa==2 ) rew =  0; end   % (   paper ,    paper   )
  if( ai==2 && oa==3 ) rew = -1; end   % (   paper ,   scissors )
  if( ai==3 && oa==1 ) rew = -1; end   % (  scissors,    rock   )
  if( ai==3 && oa==2 ) rew = +1; end   % (  scissors,   paper   )
  if( ai==3 && oa==3 ) rew =  0; end   % (  scissors,  scissors )

  % implement Q-learning:
  Q(ai) = Q(ai) + alpha*( rew + gamma*max(Q) - Q(ai) ); 
  
end

%Q
%Q/sum(Q)


