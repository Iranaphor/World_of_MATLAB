clear,clc,clf
% Create some polar data to work with.
theta = linspace(0,2*pi,40);
rho = [5:.5:10]';
[rho,theta] = meshgrid(rho,theta);

% Map the polar coordinates to Cartesian coordinates.
[X,Y] = pol2cart(theta,rho);
Z = (sin(X)./X) + .05*sin(3*Y);

% Generate a black wire mesh plot.
hm = mesh(X,Y,Z);
set(hm,'FaceColor','none','EdgeColor','none')
hold on
ax = axis;
axis(ax)

% Project Data to the different planes.
h(1) = surf(X,Y,Z); % X-Y Plane Projection
h(2) = surf(X,Y,Z-0.5);   % X-Z Plane Projection
set(h,'FaceColor','interp','EdgeColor','interp')




% Build a colormap that consists of three separate
% colormaps.
cmapX = bone(32);
cmapY = cool(32);
cmap = [cmapX;cmapY];
colormap(cmap)

% Map the CData of each surface plot to a contiguous, 
% nonoverlapping set of data.  Each CData must have
% the same range.
zmin = min(Z(:));
zmax = max(Z(:));

% CDX ranges from 1 to 32.
cdx = min(32,round(31*(Z-zmin)/(zmax-zmin))+1);
% CDY ranges from 33 to 64.
cdy = cdx+32;

% Update the CDatas.
set(h(1),'CData',cdx)
set(h(2),'CData',cdy)

% Change CLim (Color Limits) so that it spans all the CDatas
caxis([min(cdx(:)) max(cdy(:))])