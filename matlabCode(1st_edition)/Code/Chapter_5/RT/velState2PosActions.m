function possActs = velState2PosActions(vstate,maxNVii,maxNVjj,maxNAii,maxNAjj)
% VELSTATE2POSACTIONS - Returns the possible velocity states (from 1-9) that we could select from given a velocity state
%   
% this function prevents movement to a velocity state of (0,0)
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

maxNActions = prod([maxNAii,maxNAjj]); 

vii=vstate(1); vjj=vstate(2); 
% default to all possible actions 
possActs = ones(1,maxNActions); 
if( vii==0 && vjj==0 )
  error( 'invalid velocity state...' ); 
end
%
%can't have any states (<-1,*) or (*,<-1): 
%
if( vii==0 )
  % can't have any action with avii=-1 ... this would give a negative velocity
  inds = sub2ind([maxNAii,maxNAjj],ones(1,maxNAjj),[1:maxNAjj]); 
  possActs(inds) = 0; 
end
if( vjj==0 )
  % can't have the action with avjj=-1 ... this would give a negative velocity
  inds = sub2ind([maxNAii,maxNAjj],[1:maxNAii],ones(1,maxNAii)); 
  possActs(inds) = 0; 
end
%
%can't have the (0,0) velocity state: 
%
if( vii==1 && vjj==0 )
  % can't have the single action (-1,0) ... this would take us to a velocity state (0,0) 
  inds = sub2ind([maxNAii,maxNAjj],1,2); 
  possActs(inds) = 0; 
end
if( vii==0 && vjj==1 )
  % can't have the single action (0,-1) ... this would take us to a velocity state (0,0) 
  inds = sub2ind([maxNAii,maxNAjj],2,1); 
  possActs(inds) = 0; 
end
if( vii==1 && vjj==1 )
  % can't have the single action (-1,-1) ... this would take us to a velocity state (0,0) 
  inds = sub2ind([maxNAii,maxNAjj],1,1); 
  possActs(inds) = 0; 
end
%
%can't have any states (>5,*) or (*,>5): 
%
if( vii==(maxNVii-1) )
  % can't have the single action (+1,*) ... this would take us to a velocity state (6,*)
  inds = sub2ind([maxNAii,maxNAjj],3*ones(1,maxNAii),[1:maxNAjj]); 
  possActs(inds) = 0; 
end
if( vjj==(maxNVjj-1) )
  % can't have the single action (*,+1) ... this would take us to a velocity state (6,*)
  inds = sub2ind([maxNAii,maxNAjj],[1:maxNAii],3*ones(1,maxNAjj));
  possActs(inds) = 0; 
end



