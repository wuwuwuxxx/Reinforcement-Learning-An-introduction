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
N_EXPS = 100;
%N_EXPS = 1000;

% the number of learning episodes (for complete learning this would need to be much larger): 
nEpisodes = 20; 

% the number of non-terminal states in this Markov chain:
n_rw_states = 5; 

% the true solution:
Vtruth = 0.5 + (0.1:0.1:0.5); 

% a vector of learning parameters with 0.0 and 1.0
%alphaV = linspace( 0, 0.6, 10 ); 
alphaV = linspace( 0, 0.6, 100 );

lambda = 0.9;

results_acc=zeros(length(alphaV),N_EXPS);
results_rep=zeros(length(alphaV),N_EXPS);
fprintf('working on experiment number (of %d): ',N_EXPS); 
for ei=1:N_EXPS,
  if( mod(ei,10)==0 ) fprintf('%d, ',ei); end 
  for ai=1:length(alphaV), 
    a = alphaV(ai); 
    %fprintf('working on alpha=%f...\n',a); 
    V_w_at             = eg_7_5_learn_at( lam, a, n_rw_states, nEpisodes );
    results_acc(ai,ei) = sqrt( mean( (V_w_at-Vtruth).^2 ) ); 
    V_w_rp             = eg_7_5_learn_rt( lam, a, n_rw_states, nEpisodes ); 
    results_rep(ai,ei) = sqrt( mean( (V_w_rp-Vtruth).^2 ) ); 
  end 
end
fprintf('\n');
results_acc = mean( results_acc, 2 ); 
results_rep = mean( results_rep, 2 ); 

figure; hold on; 
ph1=plot( alphaV, results_acc, '-xr' ); hold on; 
ph2=plot( alphaV, results_rep, '-og' ); grid on; 
xlabel( 'alpha' ); ylabel( ['average rms error from ',num2str(nEpisodes), ' episodes'] ); 
legend( [ph1,ph2], {'Accumulating Traces','Replacing Traces'}, 'Location', 'Best' ); 
axis( [ 0.0, alphaV(end), 0.0, 1 ] ); 

saveas(gcf,['./eg_7_5_results_',num2str(N_EXPS)],'png'); 

return; 
