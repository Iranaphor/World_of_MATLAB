function spawnHome(X,Y,Z)

    w=[147 127 108]/255;
    r=[182 101 73]/255;
    
    %Front and Back Panel
    spawnPlane(w,[1+X,-1+Y,2+Z],[1+X,Y,3+Z],[1+X,1+Y,2+Z],[1+X,1+Y,Z],[1+X,-1+Y,Z])
    spawnPlane(w,[-1+X,-1+Y,2+Z],[-1+X,Y,3+Z],[-1+X,1+Y,2+Z],[-1+X,1+Y,Z],[-1+X,-1+Y,Z])
    
    %Create Roof Slate
    for i=-0.8:0.2:0.8
        spawnPlane(w,[i+X,-1+Y,2+Z],[i+X,Y,3+Z],[i+X,1+Y,2+Z],[i+X,Y,2+Z],[i+X,Y,2+Z])
    end
    
    %Walls + Floor
    spawnPlane(w,[-1+X,-1+Y,Z],[-1+X,1+Y,Z],[1+X,1+Y,Z],[1+X,-1+Y,Z])
    spawnPlane(w,[-1+X,-1+Y,Z],[-1+X,-1+Y,2+Z],[1+X,-1+Y,2+Z],[1+X,-1+Y,Z])
    spawnPlane(w,[-1+X,1+Y,Z],[-1+X,1+Y,2+Z],[1+X,1+Y,2+Z],[1+X,1+Y,Z])
    
    %Roofs
    spawnPlane(r,[-1.1+X,-1+Y,2+Z],[-1.1+X,Y,3+Z],[1.1+X,Y,3+Z],[1.1+X,-1+Y,2+Z])
    spawnPlane(r,[-1.1+X,1+Y,2+Z],[-1.1+X,Y,3+Z],[1.1+X,Y,3+Z],[1.1+X,1+Y,2+Z])

    view(3)
end


