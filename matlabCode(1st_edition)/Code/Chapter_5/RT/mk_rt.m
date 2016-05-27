function A = mk_rt(choice)
% MK_RT - Makes the RT for the RT example
%   
% Ones correspond to locations we can be.
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

switch choice,
 case 1
  A = zeros(16,16); 
  A(16,4:12) = 1; 
  A(15,4:12) = 1; 
  A(10:14,5:12) = 1; 
  A(8:9,7:12) = 1; 
  A(7,7:13) = 1; 
  A(6,8:13) = 1; 
  A(5,8:16) = 1; 
  A(4,8:16) = 1; 
  A(3,9:16) = 1; 
  A(2,11:16) = 1; 
 otherwise
end

