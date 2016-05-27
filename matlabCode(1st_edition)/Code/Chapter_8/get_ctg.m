function [the_pos,the_vel,CTG] = get_ctg(theta,nActions,pos_bnds,dp,vel_bnds,dv,nTilings,memory_size)
% GET_CTG - Extracts the the C(ost) T(o) G(o) function defined as 
% 
% CTG = -max_a Q(s,a) 
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

% break each dimension (position and velocity) into this many cells: 
N_DISC = 100; 
the_pos = linspace( pos_bnds(1), pos_bnds(2), N_DISC ); 
the_vel = linspace( vel_bnds(1), vel_bnds(2), N_DISC ); 
CTG = zeros(N_DISC,N_DISC); Q = zeros(1,nActions); 
for pi=1:N_DISC,
  for vi=1:N_DISC,
    % scale the position and velocity: 
    sts = [ the_pos(pi)/dp, the_vel(vi)/dv ]; 
    for ai=1:nActions,
      fl = GetTiles_Mex(nTilings,sts,memory_size,ai);  
      Q(ai) = sum( theta(fl) ); 
    end
    Qmx = max(Q); 

    CTG(pi,vi) = -Qmx; 
  end
end

