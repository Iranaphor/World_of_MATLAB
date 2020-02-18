classdef House < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tag
        X
        Y
        Z
        object
    end
    
    methods
        function obj = House(X,Y,Z,tag)
            obj.tag = tag;
            obj.X = X;
            obj.Y = Y;
            obj.Z = Z;
            obj.SpawnHouse(X,Y,Z,tag);
        end
        
        function SpawnHouse(~,X,Y,Z,tag)
            
            w=[147 127 108]/255;
            r=[182 101 73]/255;
            
            %Front and Back Panel
            spawnPlane(w,tag+"_panel_1",[1+X,-1+Y,2+Z],[1+X,Y,3+Z],[1+X,1+Y,2+Z],[1+X,1+Y,Z],[1+X,-1+Y,Z])
            spawnPlane(w,tag+"_panel_2",[-1+X,-1+Y,2+Z],[-1+X,Y,3+Z],[-1+X,1+Y,2+Z],[-1+X,1+Y,Z],[-1+X,-1+Y,Z])
            
            %Create Roof Slate
            for i=-0.8:0.2:0.8
                spawnPlane(w,tag+"_roof_slat_"+i,[i+X,-1+Y,2+Z],[i+X,Y,3+Z],[i+X,1+Y,2+Z],[i+X,Y,2+Z],[i+X,Y,2+Z])
            end
            
            %Walls + Floor
            spawnPlane(w,tag+"_wall_1",[-1+X,-1+Y,Z],[-1+X,1+Y,Z],[1+X,1+Y,Z],[1+X,-1+Y,Z])
            spawnPlane(w,tag+"_wall_2",[-1+X,-1+Y,Z],[-1+X,-1+Y,2+Z],[1+X,-1+Y,2+Z],[1+X,-1+Y,Z])
            spawnPlane(w,tag+"_floor",[-1+X,1+Y,Z],[-1+X,1+Y,2+Z],[1+X,1+Y,2+Z],[1+X,1+Y,Z])
            
            %Roofs
            spawnPlane(r,tag+"_roof_1",[-1.1+X,-1+Y,2+Z],[-1.1+X,Y,3+Z],[1.1+X,Y,3+Z],[1.1+X,-1+Y,2+Z])
            spawnPlane(r,tag+"_roof_2",[-1.1+X,1+Y,2+Z],[-1.1+X,Y,3+Z],[1.1+X,Y,3+Z],[1.1+X,1+Y,2+Z])
            
        end
        
    end
end

