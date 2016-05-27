function pol_pi = init_unif_policy(MZ, maxNStates,maxNActions,maxNPii,maxNPjj,maxNVii,maxNVjj,maxNAii,maxNAjj)
% INIT_UNIF_POLICY - Initializes a uniformly random policy
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

pol_pi = zeros(maxNStates,maxNActions); 
for si=1:maxNStates,
  [pii,pjj,vii,vjj] = ind2sub([maxNPii,maxNPjj,maxNVii,maxNVjj],si); vii=vii-1; vjj=vjj-1; % vii/vjj \in [0,5] ... checked 2008-01-09
  % if this is not a valid position state return
  if( MZ(pii,pjj)~=1 ) continue; end 
  % if this is not a valid velocity state return
  if( vii==0 && vjj==0 ) continue; end 
  possActs     = velState2PosActions( [vii,vjj],maxNVii,maxNVjj,maxNAii,maxNAjj ); 
  uniprob      = possActs/sum(possActs); 
  pol_pi(si,:) = uniprob; 
end

if( 0 ) 
  figure; imagesc( pol_pi ); colorbar; 
end








