function spawnPlane(c,varargin)

    %P1: [x1, y1, z1]
    X=zeros(length(varargin),1);
    Y=zeros(length(varargin),1);
    Z=zeros(length(varargin),1);
    for i=1:length(varargin)
        X(i) = varargin{i}(1);
        Y(i) = varargin{i}(2);
        Z(i) = varargin{i}(3);
    end
    
    fill3(X,Y,Z,c)
end