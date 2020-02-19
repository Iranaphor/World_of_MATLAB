function spawnPlane(c,tag,varargin)
    %% SPAWNPLANE spawns a 2d plain in world
    %
    % SPAWNPLANE(c, tag, varargin) sets the colour (c) and the
    %   identification tag of the plane. varargin is a series of
    %   3 dimensional co-ordinates, one of which should be constant
    %   between all points
    %
    %   Example
    %     SPAWNPLANE('r', "Example", [0,0,0],[0,1,0],[1,1,0],[1,0,0])
    %       spawns a red unit square at the origin on the XY plane.
    %
    %   @author Iranaphor
    %   @version 0.0.1
    %   @since 0.0.1

    %
    % @param c: Colour of the plane
    % @param tag: Identification tag of the plane
    % @param varargin: List of points

    %P1: [x1, y1, z1]
    X=zeros(length(varargin),1);
    Y=zeros(length(varargin),1);
    Z=zeros(length(varargin),1);
    for i=1:length(varargin)
        X(i) = varargin{i}(1);
        Y(i) = varargin{i}(2);
        Z(i) = varargin{i}(3);
    end
    
    fill3(X,Y,Z,c,'Tag',tag)
end
