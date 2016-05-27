function plot_cw_policy(pol_pi,CF,s_start,s_end)
% PLOT_CW_POLICY - Plots a cliff walker policy
% 
% Written by:
% -- 
% John L. Weatherwax                2008-01-14
% 
% email: wax@alum.mit.edu
% 
% Please send comments and especially bug reports to the
% above email address.
% 
%-----
  
% compute_delim_mdpts.m
%JWilliamson; 

[sideII,sideJJ]=size(pol_pi); 
IIdelims = 0:sideII; IIcents = 1:sideII;
JJdelims = 0:sideJJ; JJcents = 1:sideJJ;

% plot the policy in colors beneath: 
%figure; imagesc( JJcents, IIcents, pol_pi ); colorbar; hold on; 

% plot the cliff beneath: 
figure; imagesc( JJcents, IIcents, CF ); colorbar; hold on; 

% plot the start/end positions:
plot( s_start(2), s_start(1), 'x', 'MarkerSize', 10, 'MarkerFaceColor', 'k' ); 
plot( s_end(2), s_end(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'k' ); 

% fill the vectors:
px = zeros(size(pol_pi)); py = zeros(size(pol_pi)); 
for ii=1:sideII,
  for jj=1:sideJJ,
    switch pol_pi(ii,jj)
     case 1
      %
      % action = UP 
      %
      px(ii,jj) = 0;
      py(ii,jj) = 0.5; 
     case 2
      %
      % action = DOWN
      %
      px(ii,jj) = 0;
      py(ii,jj) = -0.5; 
     case 3
      %
      % action = RIGHT
      %
      px(ii,jj) = 0.5;
      py(ii,jj) = 0; 
     case 4
      %
      % action = LEFT 
      %
      px(ii,jj) = -0.5; 
      py(ii,jj) = 0; 
     case 5
      px(ii,jj) = -0.5; 
      py(ii,jj) = +0.5; 
     case 6
      px(ii,jj) = +0.5; 
      py(ii,jj) = +0.5; 
     case 7
      px(ii,jj) = +0.5; 
      py(ii,jj) = -0.5; 
     case 8
      px(ii,jj) = -0.5; 
      py(ii,jj) = -0.5; 
     otherwise
      error('unknown value of pol_pi(ii,jj)'); 
    end
  end
end

ind0 = find(CF(:)==0); px(ind0)=0; py(ind0)=0; px(sideII,sideJJ)=0; py(sideII,sideJJ)=0; 

%[jjM,iiM]=meshgrid(1:sideJJ,1:sideII);
[jjM,iiM]=meshgrid(JJcents,IIcents);

%quiver(iiM,jjM,px,py,0); 
quiver(jjM,iiM,px,-py,0); 
