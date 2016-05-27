function [v_tmp] = ex_4_5_rhs_state_value_bellman(na,nb,ntrans,useEmp,V,gamma,Ra,Pa,Rb,Pb,max_num_cars_can_transfer,max_cars_can_store)
% RHS_STATE_VALUE_BELLMAN - computes the right hand side of the bellman equation
%
% We have to consider the possible number of rentals at sites A/B
%                 and the possible number of returns at sites A/B
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

% the maximum number of cars at each site (assume equal): 
max_n_cars = size(V,1)-1; 

% restrict this action: 
ntrans_total = ntrans+useEmp; 
ntrans_total = max(-nb,min(ntrans_total,na)); 
ntrans_total = max(-max_num_cars_can_transfer,min(+max_num_cars_can_transfer,ntrans_total));

% the number of cars at each site due to transport: 
na_morn = na-ntrans_total;
nb_morn = nb+ntrans_total;

% assemble all costs:
% --fixed transport cost: 
v_tmp   = -2*abs(ntrans);
% --overnight storage cost: 
if( na_morn > max_cars_can_store ) v_tmp = v_tmp - 4; end     % if n?_morn > 10 we had to store extra cars that night
if( nb_morn > max_cars_can_store ) v_tmp = v_tmp - 4; end

for nna=0:max_n_cars, 
  for nnb=0:max_n_cars,
    pa = Pa(na_morn+1,nna+1); 
    pb = Pb(nb_morn+1,nnb+1); 
    v_tmp = v_tmp + pa*pb* ( Ra(na_morn+1) + Rb(nb_morn+1) + gamma*V(nna+1,nnb+1) ); 
  end
end
