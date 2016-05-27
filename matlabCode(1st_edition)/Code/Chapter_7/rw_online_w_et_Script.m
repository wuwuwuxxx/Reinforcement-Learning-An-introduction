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

% the number of experiments: 
N_EXPS = 1000;

% the number of learning episodes (for complete learning this would need to be much larger): 
nEpisodes = 10; 

% the number of random walk states (not including the two terminal states): 
%n_rw_states = 17; 
n_rw_states = 19; 
%n_rw_states = 7; 

% the true solution:
%  (when zero is the reward for going off the left end): 
%Vtruth = (0:(n_rw_states+1))/(n_rw_states+1); Vtruth(1)=[]; Vtruth(end)=[]; 
%  (when -1 is the reward for going off the left end): 
Vtruth = -1 + 2*(0:(n_rw_states+1))/(n_rw_states+1); Vtruth(1)=[]; Vtruth(end)=[]; 

% a vector of learning parameters with 0.0 and 1.0
%alphaV = linspace( 0, 1, 10 ); 
%alphaV = linspace( 0, 1, 20 );
alphaV = linspace( 0, 1, 100 );

% a vector of TD(lambda) lambdas:
lamVect = [ 0, 0.2, 0.4, 0.6, 0.8, 0.9, 0.95, 0.975, 0.99, 1.0 ]; 

results=zeros(length(alphaV),length(lamVect)); 
for ni=1:length(lamVect),
  lam=lamVect(ni); 
  fprintf('working on lambda=%f...\n',lam); 
  tra = zeros(1,length(alphaV)); 
  for ai=1:length(alphaV), 
    a  = alphaV(ai); 
    fprintf('working on alpha=%f...\n',a); 
    tr = zeros(1,N_EXPS); 
    fprintf('working on experiment number (of %d): ',N_EXPS); 
    for ei=1:N_EXPS,
      if( mod(ei,10)==0 ) fprintf('%d, ',ei); end 
      V      = rw_online_w_et( lam, a, n_rw_states, nEpisodes );
      tr(ei) = sqrt( mean( (V-Vtruth).^2 ) ); 
    end
    fprintf('\n'); 
    tra(ai) = mean( tr ); 
  end
  results(:,ni) = tra(:); 
end

figure; hold on; 
phs=plot( alphaV, results ); 
xlabel( 'alpha' ); ylabel( ['average rms error from ',num2str(nEpisodes), ' episodes'] ); 
lamVectCL={}; 
for ti=1:length(lamVect),
  lamVectCL{end+1} = ['TD(\lambda=',num2str(lamVect(ti)),')'];
end
%legend(phs,lamVectCL,'Location','Best');
legend(phs,lamVectCL,'Location','North');
axis( [ 0.0, alphaV(end), 0.1, 0.6 ] ); 

saveas(gcf,['./rw_online_w_et_',num2str(N_EXPS)],'png'); 

return; 
