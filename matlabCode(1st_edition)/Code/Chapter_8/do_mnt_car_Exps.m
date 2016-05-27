% DO_MNT_CAR_EXPS - Performs the experiments presented in the book on the mountain valley problem
% which is linear, gradient-decent SARSA(\lambda) with binary features and an \epsilon-greedy policy
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

clc; close all; 

% the probabiity of an exploratory move: 
epsilon = 0.0; 

% discount factor: 
gamma = 1.0; 
%gamma = 0.9; 

% the number of episodes to perform: 
%nEpisodes = 3; 
nEpisodes = 20; 
%nEpisodes = 2000; 

% the type of elagability trace (replacing=0 or accumulating=1):
ACC_ET = 1; 

% the number of monte carlo trials to perform ... for good statistics: 
%N_MC = 2; 
N_MC = 30; 

nAlphaV = 5;

GetTiles_Mex_Script; % <- used to just to make sure that the C code has been "mexed"

%--
% ACCUMULATING/REPLACING TRACES:
%--

lambdaV = [ 0.4, 0.7, 0.8, 0.9, 0.95, 0.99, 1.0 ]; 
alphaV  = linspace( 0, 1.2, nAlphaV ); 

allResults = zeros(length(lambdaV),length(alphaV)); imc_results = zeros(1,N_MC); plt_lbls=cell(1,length(lambdaV)); 
for li=1:length(lambdaV),
  lambda = lambdaV(li); 
  fprintf('working on lambda=%10.5f...\n',lambda); 
  for ai=1:length(alphaV),
    alpha = alphaV(ai); 
    fprintf('  working on alpha=%10.5f...\n',alpha); 
    for mci=1:N_MC,
      if( mod(mci,10)==0 ) fprintf('    working on monte carlo=%10d...\n',mci); end 
      [theta,atspe]    = mnt_car_learn(nEpisodes, epsilon,gamma,alpha,lambda,ACC_ET, 0);
      imc_results(mci) = atspe;
    end
    allResults(li,ai)  = mean(imc_results); 
  end
  plt_lbls{li} = sprintf('lambda = %.2f',lambda);
end

figure; ph=plot( alphaV, allResults.', '-' ); axis tight; 
legend(ph,plt_lbls); 
xlabel('alpha'); ylabel('steps per episode'); title('replacing traces various lambdas'); 
if( ACC_ET==0 )
  saveas( gcf, sprintf('mc_learning_curves_replacing_et_mxts_ne_%d_nmc_%d', nEpisodes, N_MC), 'png' ); 
else
  saveas( gcf, sprintf('mc_learning_curves_accumulating_et_mxts_ne_%d_nmc_%d', nEpisodes, N_MC), 'png' ); 
end

