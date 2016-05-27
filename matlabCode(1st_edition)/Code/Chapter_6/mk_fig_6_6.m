function [] = mk_fig_6_6()
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

% number of nonterminal states: 
nStates=5; 

res = zeros(4,nStates); 

res(1,:) = eg_6_2_learn(0);
res(2,:) = eg_6_2_learn(1); 
res(3,:) = eg_6_2_learn(10); 
res(4,:) = eg_6_2_learn(100); 

truth = (1:5)/6; 

figure; 
fh = [ plot( 1:5, truth, '*g-' ) ];
hold on; 
ii=1; fh = [ plot( 1:5, res(ii,:), 'rx-' ), fh ];
ii=2; fh = [ plot( 1:5, res(ii,:), 'b.-' ), fh ];
ii=3; fh = [ plot( 1:5, res(ii,:), 'bs-' ), fh ];
ii=4; fh = [ plot( 1:5, res(ii,:), 'bd-' ), fh ]; 

legend( fliplr(fh), { 'truth', '0', '1', '10', '100' }, 'location', 'northwest' ); 

