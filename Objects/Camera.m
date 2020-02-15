classdef Camera < handle
    
    properties
        Render_Distance
        CameraPosition
        Yaw
        Pitch
    end
    
    methods
        function Camera_Data = Camera(R)
            
            Camera_Data.Render_Distance = R; 
            Camera_Data.CameraPosition = [-50 50 1];
            Camera_Data.Yaw = 0;
            Camera_Data.Pitch = 0;

        end
        
    end
end

