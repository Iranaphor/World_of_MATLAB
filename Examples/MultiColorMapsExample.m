% Create some polar data to work with.
theta = linspace(0,2*pi,40);
rho = [5:.5:10]';
[rho,theta] = meshgrid(rho,theta);

% Map the polar coordinates to Cartesian coordinates.
[X,Y] = pol2cart(theta,rho);
Z = (sin(X)./X) + .05*sin(3*Y);

% Generate a black wire mesh plot.
hm = mesh(X,Y,Z);
set(hm,'FaceColor','none','EdgeColor','k')
hold on
ax = axis;
axis(ax)

% Project Data to the different planes.
h(1) = surf(X,Y,ax(5)+0*Z,Z); % X-Y Plane Projection
h(2) = surf(X,ax(4)+0*Y,Z);   % X-Z Plane Projection
h(3) = surf(ax(2)+0*X,Y,Z);   % Y-Z Plane Projection
set(h,'FaceColor','interp','EdgeColor','interp')

% Build a colormap that consists of three separate
% colormaps.
cmapX = bone(32);
cmapY = cool(32);
cmapZ = jet(32);
cmap = [cmapX;cmapY;cmapZ];
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
% CDZ ranges from 65 to 96.
cdz = cdy+32;

% Update the CDatas.
set(h(1),'CData',cdx)
set(h(3),'CData',cdy)
set(h(2),'CData',cdz)

% Change CLim (Color Limits) so that it spans all the CDatas
caxis([min(cdx(:)) max(cdz(:))])