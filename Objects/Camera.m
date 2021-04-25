classdef Camera < handle
    
    properties
        Render_Distance
        CameraPosition
        Yaw
        Pitch
        cT
        cD
        cP
        cV
    end
    
    methods
        function Camera_Data = Camera(R)
            
            Camera_Data.Render_Distance = R; 
            Camera_Data.CameraPosition = [-50 50 1];
            Camera_Data.Yaw = 0;
            Camera_Data.Pitch = 0;

            %Camera Target [0.015,10,0.005,80] [15 10 5 80] [300 10 600 100]
            Camera_Data.cT = 15; %vertical target displacement (focus on space above boat)
            Camera_Data.cD = 10; %hypotenusean distance from focal point
            Camera_Data.cP = 5;  %pitch (steepness of angle looking down at ship)
            Camera_Data.cV = 80; %view angle (width of view)
        end
        
    end
end

