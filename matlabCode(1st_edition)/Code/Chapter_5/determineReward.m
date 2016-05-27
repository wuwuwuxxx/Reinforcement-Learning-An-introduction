function [rew] = determineReward(phv,dhv)
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

if( phv>21 ) % player went bust
  rew = -1; 
  return; 
end
if( dhv>21 ) % dealer went bust
  rew = +1; 
  return; 
end
if( phv==dhv ) % a tie
  rew = 0; 
  return;
end
if( phv>dhv ) % the larger hand wins
  rew = +1; 
else
  rew = -1; 
end

