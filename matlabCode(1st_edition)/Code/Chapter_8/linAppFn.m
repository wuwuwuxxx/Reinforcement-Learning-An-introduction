function res = linAppFn(x,w,width)
% LINAPPFN - Linearly approximate the target function at x when it is divided up into "n" patches 
% and "width" is an integer specifying HOW MANY patches should be placed over the center of each 
% node center 
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

n = length(w); 

res = 0.0; 
for pti=1:n,
  if( abs( x - pti/n ) <= width/(2*n) )   % are we in the patch pti?
    res = res+w(pti)*1.0;                 % add the weight at this point to our current result ... otherwise do nothing 
  end
end
