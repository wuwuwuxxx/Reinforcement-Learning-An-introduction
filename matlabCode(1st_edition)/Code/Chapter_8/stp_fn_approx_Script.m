% STP_FN_APPROX_Script - Demonstates linear approximation for a one dimensional step function.
% 
% Note: the approximation is done by learning the coefficients of a "patches" representation of 
% the function.  Specifically, we assume that we have patch functions \phi_s(i) where
% 
% \phi_s(i) = \left\{ 
%                       1 if s is in the ith patch
%                       0 otherwise
%             \right.
% 
% And f(x) \appax f_n(x) = \sum_{n=1}^n w_i \phi_s(i) 
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

close all; 

alpha = 0.2; % our learning rate 
n     = 100; % the number of patches 

% the number of training samples/examples to generate/use: 
nTrainingAll = [ 10, 40, 160, 640, 2560, 10240 ]; 
% the number of patches considered to be a unit: 
widthAll     = [ 3, 9, 27 ];

rand('seed',0); 

figure; hold on; 
for nti=1:length(nTrainingAll),
  nTraining = nTrainingAll(nti); 
  for wi=1:length(widthAll),
    width = widthAll(wi); 
    
    %--
    % run this parameter variation: 
    %--
    w = zeros(n,1); 
    for ti=1:nTraining,
      x = rand; % <- get a random draw in [0,1]
      target     = targetF(x); 
      f          = linAppFn(x,w,width); 
      alphaError = (alpha/width)*(target - f); 
      % update all patches that have this x as a member: 
      for pti=1:n,
        if( abs( x - pti/n ) <= width/(2*n) )
          w(pti) = w(pti) + alphaError; 
        end
      end
    end

    % plot our approximation along with the exact solution: 
    nS = 100; x = linspace(0,1,nS); yA = zeros(nS,1); yE = zeros(nS,1); 
    for xi=1:nS,
      yA(xi) = linAppFn(x(xi),w,width);
      yE(xi) = targetF(x(xi));
    end
    [sij] = sub2ind( [length(widthAll), length(nTrainingAll)], wi, nti ); 
    subplot( length(nTrainingAll), length(widthAll), sij );
    plot( x, yA, '-r' ); hold on; plot( x, yE, '-g', 'LineWidth', 1 ); axis( [ 0, 1, 0, 1.5 ] ); 
    
  end
end

saveas(gcf,'stp_fn_approx','jpg'); 



