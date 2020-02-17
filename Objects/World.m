classdef World < handle
   
    properties
        Size
        PlayerBoundary
        SeaLevel
        Stars
        Map
    end
    
    methods
        function World_Data = World(W)
            
            World_Data.Size=W;
            World_Data.PlayerBoundary=[W,W]*0.95;

            World_Data.SeaLevel=500;

            World_Data.Stars=(rand(3,0.005*(W*W)).*[2000,2000,0.2]')+[-W/2,-W/2,750]';

            World_Data.Map=rand(W,W).*1000;
%             World_Data.Map(45:55,45:55)=World_Data.Map(45:55,45:55)+20;
            
            for i=1:19
                World_Data.Map=smoothdata(World_Data.Map'); 
            end
            World_Data.Map(World_Data.Map<(2+World_Data.SeaLevel))=World_Data.SeaLevel;
            
        end
        
    end
end

