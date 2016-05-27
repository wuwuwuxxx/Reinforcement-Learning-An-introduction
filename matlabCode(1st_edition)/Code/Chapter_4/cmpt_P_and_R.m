function [R,P] = cmpt_P_and_R(lambdaRequests,lambdaReturns,max_n_cars,max_num_cars_can_transfer)
%
% Notes: checked 2007-12-10 (no mistakes found)
% 
% Written by:
% -- 
% John L. Weatherwax                2007-12-03
% 
% email: wax@alum.mit.edu
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----

if( nargin==0 )
  lambdaRequests=4; 
  lambdaReturns=2; 
  max_n_cars=20; 
  max_n_cars_can_transfer=5; 
end

PLOT_FIGS=0; 

% the number of possible cars at any site first thing in the morning: 
nCM = 0:(max_n_cars+max_num_cars_can_transfer);

% return the average rewards: 
if false, 
  % OLD CODE: 
  R = zeros(1,length(nCM)); 
  for n = nCM,
    tmp = 0.0; 
    for nr = 0:(10*lambdaRequests), % <- a value where the probability of request is very small. 
      tmp = tmp + 10*min(n,nr)*poisspdf( nr, lambdaRequests );
    end
    R(n+1) = tmp; 
  end
else
  % NEW CODE (old code above did not have any dependence on car rental returns; bug found by Valentina Vadori)
  R = zeros(1,length(nCM));
  for n = nCM,
    tmp = 0.0;
    for nreq = 0:(10*lambdaRequests), % <- a value where the probability of request is very small.
      for nret = 0:(10*lambdaReturns), % <- a value where the probability of returns is very small.
        tmp = tmp + 10*min(n+nret,nreq)*poisspdf( nreq, lambdaRequests )*poisspdf( nret, lambdaReturns );
      end
    end
    R(n+1) = tmp;
  end
end

if( PLOT_FIGS ) 
  figure; plot( nCM, R, 'x-' ); grid on; axis tight; 
  xlabel(''); ylabel(''); drawnow; 
end

% return the probabilities: 
P = zeros(length(nCM),max_n_cars+1); 
for nreq = 0:(10*lambdaRequests), % <- a value where the probability of request is very small. 
  reqP = poisspdf( nreq, lambdaRequests ); 
  % for all possible returns:
  for nret = 0:(10*lambdaReturns), % <- a value where the probability of returns is very small. 
    retP = poisspdf( nret, lambdaReturns ); 
    % for all possible morning states: 
    for n = nCM,
      sat_requests = min(n,nreq); 
      new_n = max( 0, min(max_n_cars,n+nret-sat_requests) );
      P(n+1,new_n+1) = P(n+1,new_n+1) + reqP*retP;
    end
  end
end
if( PLOT_FIGS ) 
  figure; imagesc( 0:max_n_cars, nCM, P ); colorbar; 
  xlabel('num at the end of the day'); ylabel('num in morning'); axis xy; drawnow; 
end






