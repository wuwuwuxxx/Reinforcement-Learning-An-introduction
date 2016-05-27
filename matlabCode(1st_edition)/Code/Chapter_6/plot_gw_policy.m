function plot_gw_policy(pol_pi,s_start,s_end,wind)
% PLOT_GW_POLICY - Plots a grid world policy
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

% plot the wind beneath: 
W = repmat( wind, [sideII,1] ); 
figure; imagesc( JJcents, IIcents, W ); colormap(jet(length(unique(wind)))); colorbar; hold on; 

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
      % action = UP/NORTH
      %
      px(ii,jj) = 0;
      py(ii,jj) = 0.5; 
     case 2
      %
      % action = DOWN/SOUTH
      %
      px(ii,jj) = 0;
      py(ii,jj) = -0.5; 
     case 3
      %
      % action = RIGHT/EAST
      %
      px(ii,jj) = 0.5;
      py(ii,jj) = 0; 
     case 4
      %
      % action = LEFT/WEST
      %
      px(ii,jj) = -0.5; 
      py(ii,jj) = 0; 
     case 5
      %
      % action = NorthWest/NW
      %
      px(ii,jj) = -0.5; 
      py(ii,jj) = +0.5; 
     case 6
      %
      % action = NorthEast/NE
      %
      px(ii,jj) = +0.5; 
      py(ii,jj) = +0.5; 
     case 7
      %
      % action = SouthEast/SE
      %
      px(ii,jj) = +0.5; 
      py(ii,jj) = -0.5; 
     case 8
      %
      % action = SouthWest
      %
      px(ii,jj) = -0.5; 
      py(ii,jj) = -0.5; 
     case 9
      %
      % action = "wind"
      %
      px(ii,jj) = 0.0; 
      py(ii,jj) = 0.0; 
     otherwise
      error('unknown value of pol_pi(ii,jj)'); 
    end
  end
end

%[jjM,iiM]=meshgrid(1:sideJJ,1:sideII);
[jjM,iiM]=meshgrid(JJcents,IIcents);

quiver(jjM,iiM,px,-py,0); 
