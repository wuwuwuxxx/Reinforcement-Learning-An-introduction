%
% Implements Monte Carlo ES (exploring starts) with first visit estimation to
% compute the action-value function for the black jack example.
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

close all;
clc; 

N_HANDS_TO_PLAY=10;     % a numerical approximation of +Inf
N_HANDS_TO_PLAY=2*1e4;
N_HANDS_TO_PLAY=5e5;
N_HANDS_TO_PLAY=5e6;
%N_HANDS_TO_PLAY=1e7;

rand('seed',0); randn('seed',0); 

%--
% implement hands of bj
%--

nStates       = prod([21-12+1,13,2]);
posHandSums   = 12:21; 
nActions      = 2; % 0=>stick; 1=>hit 
Q             = zeros(nStates,nActions);  % the initial action-value function
%pol_pi        = zeros(1,nStates);         % our initial policy is to always stick "0"
pol_pi        = ones(1,nStates);         % our initial policy is to always hit "1"
%pol_pi        = unidrnd(2,1,nStates)-1;   % our initial policy is random 
firstSARewSum = zeros(nStates,nActions); 
firstSARewCnt = zeros(nStates,nActions); 

tic
for hi=1:N_HANDS_TO_PLAY,
  
  stateseen = []; 
  deck = shufflecards(); 

  % the player gets the first two cards: 
  p = deck(1:2); deck = deck(3:end); phv = handValue(p);
  % the dealer gets the next two cards (and shows his first card): 
  d = deck(1:2); deck = deck(3:end); dhv = handValue(d); cardShowing = d(1); 
  
  % disgard states who's initial sum is less than 12 (the decision is always to hit): 
  while( phv < 12 ) 
    p = [ p, deck(1) ]; deck = deck(2:end); phv = handValue(p); % HIT
  end
  
  % accumulate/store the first state seen: 
  stateseen(1,:) = stateFromHand( p, cardShowing );
    
  % implement the policy specified by pol_pi (keep hitting till we should "stick"):
  si = 1; 
  polInd         = sub2ind( [21-12+1,13,2], stateseen(si,1)-12+1, stateseen(si,2), stateseen(si,3)+1 );
  pol_pi(polInd) = unidrnd(2)-1;      % FOR EXPLORING STARTS TAKE AN INITIAL RANDOM POLICY!!! 
  pol_to_take    = pol_pi(polInd);
  while( pol_to_take && (phv < 22) )
    p = [ p, deck(1) ]; deck = deck(2:end); phv = handValue(p); % HIT
    stateseen(end+1,:) = stateFromHand( p, cardShowing ); 

    if( phv <= 21 ) % only then do we need to querry the next policy action when we have not gone bust
      si = si+1; 
      %[ stateseen(si,1), stateseen(si,2), stateseen(si,3) ] 
      polInd      = sub2ind( [21-12+1,13,2], stateseen(si,1)-12+1, stateseen(si,2), stateseen(si,3)+1 ); 
      pol_to_take = pol_pi(polInd);
    end
  end
  % implement the fixed deterministic policy of the dealer (hit until we have a hand value of 17): 
  while( dhv < 17 )
    d = [ d, deck(1) ]; deck = deck(2:end); dhv = handValue(d); % HIT
  end
  % determine the reward for playing this game:
  rew = determineReward(phv,dhv);
  %fprintf( '[phv, dhv, rew] = \n' ); [ phv, dhv, rew ]  
  
  % accumulate these values used in computing statistics on this action value function Q^{\pi}: 
  for si=1:size(stateseen,1),
    if( (stateseen(si,1)>=12) && (stateseen(si,1)<=21) ) % we don't count "initial" and terminal states
      %[stateseen(si,1)]
      %[stateseen(si,1)-12+1, stateseen(si,2), stateseen(si,3)+1]
      staInd = sub2ind( [21-12+1,13,2], stateseen(si,1)-12+1, stateseen(si,2), stateseen(si,3)+1 ); 
      actInd = pol_pi(staInd)+1; 
      firstSARewCnt(staInd,actInd) = firstSARewCnt(staInd,actInd)+1; 
      firstSARewSum(staInd,actInd) = firstSARewSum(staInd,actInd)+rew; 
      Q(staInd,actInd)             = firstSARewSum(staInd,actInd)/firstSARewCnt(staInd,actInd); % <-take the average 
      [dum,greedyChoice]           = max( Q(staInd,:) );
      pol_pi(staInd)               = greedyChoice-1;
    end
  end  
end % end number of hands loop 
toc

% plot the optimal state-value function V^{*}: 
%
mc_value_fn = max( Q, [], 2 );
mc_value_fn = reshape( mc_value_fn, [21-12+1,13,2]); 
if( 1 ) 
  figure; mesh( 1:13, 12:21, mc_value_fn(:,:,1) ); 
  xlabel( 'dealer shows' ); ylabel( 'sum of cards in hand' ); axis xy; %view([67,5]);
  title( 'no usable ace' ); drawnow; 
  fn=sprintf('state_value_fn_nua_%d_mesh.eps',N_HANDS_TO_PLAY); saveas( gcf, fn, 'eps2' ); 
  figure; mesh( 1:13, 12:21,  mc_value_fn(:,:,2) ); 
  xlabel( 'dealer shows' ); ylabel( 'sum of cards in hand' ); axis xy; %view([67,5]);
  title( 'a usable ace' ); drawnow; 
  fn=sprintf('state_value_fn_ua_%d_mesh.eps',N_HANDS_TO_PLAY); saveas( gcf, fn, 'eps2' ); 
  
  figure;imagesc( 1:13, 12:21, mc_value_fn(:,:,1) ); caxis( [-1,+1] ); colorbar; 
  xlabel( 'dealer shows' ); ylabel( 'sum of cards in hand' ); axis xy; 
  title( 'no usable ace' ); drawnow; 
  fn=sprintf('state_value_fn_nua_%d_img.eps',N_HANDS_TO_PLAY); saveas( gcf, fn, 'eps2' ); 
  figure;imagesc( 1:13, 12:21, mc_value_fn(:,:,2) ); caxis( [-1,+1] ); colorbar; 
  xlabel( 'dealer shows' ); ylabel( 'sum of cards in hand' ); axis xy; 
  title( 'a usable ace' ); drawnow; 
  fn=sprintf('state_value_fn_ua_%d_img.eps',N_HANDS_TO_PLAY); saveas( gcf, fn, 'eps2' ); 
end

% plot the optimal policy: 
%
pol_pi = reshape( pol_pi, [21-12+1,13,2] ); 
if( 1 ) 
  figure; imagesc( 1:13, 12:21, pol_pi(:,:,1) ); colorbar; 
  xlabel( 'dealer shows' ); ylabel( 'sum of cards in hand' ); axis xy; %view([67,5]);
  title( 'no usable ace' ); drawnow; 
  fn=sprintf('bj_opt_pol_nua_%d_image.eps',N_HANDS_TO_PLAY); saveas( gcf, fn, 'eps2' ); 
  figure; imagesc( 1:13, 12:21,  pol_pi(:,:,2) ); colorbar; 
  xlabel( 'dealer shows' ); ylabel( 'sum of cards in hand' ); axis xy; %view([67,5]);
  title( 'a usable ace' ); drawnow; 
  fn=sprintf('bj_opt_pol_ua_%d_mesh.eps',N_HANDS_TO_PLAY); saveas( gcf, fn, 'eps2' ); 
end

return; 
