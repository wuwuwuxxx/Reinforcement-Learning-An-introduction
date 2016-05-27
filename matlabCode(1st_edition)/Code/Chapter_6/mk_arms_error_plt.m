function [] = mk_arms_error_plt()
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

figure; 

%
% TD plots: 
armsErr_TD = cmpt_arms_err(100,0.15);
h = plot( armsErr_TD, 'g-x' ); ah = [h]; 
hold on; 
armsErr_TD = cmpt_arms_err(100,0.1);
h = plot( armsErr_TD, 'g-o' ); ah = [ah; h]; 
armsErr_TD = cmpt_arms_err(100,0.05);
h = plot( armsErr_TD, 'g-d' ); ah = [ah; h]; 

%
% MC plots: 
[armsErr_TD,armsErr_MC] = cmpt_arms_err(100,0.01);
h = plot( armsErr_MC, '-o' ); ah = [ah; h];
[armsErr_TD,armsErr_MC] = cmpt_arms_err(100,0.02);
h = plot( armsErr_MC, '-' ); ah = [ah; h];
[armsErr_TD,armsErr_MC] = cmpt_arms_err(100,0.03);
h = plot( armsErr_MC, '--' ); ah = [ah;h];
[armsErr_TD,armsErr_MC] = cmpt_arms_err(100,0.04);
h = plot( armsErr_MC, '-.' ); ah = [ah;h];

xlabel('walks/trials'); ylabel('average RMS error'); 
legend( ah, { 'TD \alpha=0.15', 'TD \alpha=0.1', 'TD \alpha=0.05', ...
              'MC \alpha=0.01', 'MC \alpha=0.02', 'MC \alpha=0.03', 'MC \alpha=0.04' } ); 












