function res = targetF(x)
% TARGETF - The target step function we are approximating 
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

if( (x>=0.4) && (x<=0.6) ), 
  res=1.0; 
else 
  res=0.0; 
end;

  
