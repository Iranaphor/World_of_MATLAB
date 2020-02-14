classdef Player
   
    properties
        X
        Y
        Z
        Angle %Change to Yaw
        OffsetZ
    end
    
    methods
        function Player_Data = Player(Map)
            X=size(Map,1)/2;
            Y=size(Map,2)/2;
            Player_Data.X = X;
            Player_Data.Y = Y;
            Player_Data.Z = Map(floor(X),floor(Y));
            Player_Data.Angle = 0;
            Player_Data.OffsetZ = 0.0;
        end
        
        
        
    end
end

