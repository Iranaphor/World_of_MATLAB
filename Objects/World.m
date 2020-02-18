classdef World < handle
   
    properties
        Size
        PlayerBoundary
        SeaLevel
        Stars
        Map
        HouseList
        MapSurf
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
        
        function SpawnIslands(World_Data)
            
            %Display World
            ax=findobj('Tag','SuperPlot');
            S=surf(ax,World_Data.Map,'Tag','MapSurf');
            f=findobj(gcf); set(f(2),'Tag','SuperPlot');
            ax=gca;
            ax.Projection = 'perspective';
            set(ax,'Zlim',[0,2000]);
            shading interp;
            c=colormap(summer); c(1,:)=[0.15,0.55,0.85]; colormap(c)
            
        end
        
        function SpawnWater(World_Data)
            %RENDER THE WATER WITH A SECOND SURF MAP
            S=surfl((World_Data.Map.*0)+500.5);
            set(S,'EdgeColor','none','FaceColor',[0,.2,1],'Tag','WaterSurf');

            c=colormap(summer); c(1,:)=[0.15,0.55,0.85]; colormap(c)
            
            
            
            %{
            
            
            islands
            water
            
            I = islandcolours(32)
            W = watercolours(32)
            clrs = [I;W]
            
            
            %}
            
            
            
            
        end
        
        function SpawnStars(World_Data)
            X=World_Data.Stars(1,:);
            Y=World_Data.Stars(2,:);
            Z=World_Data.Stars(3,:);
            scatter3(X,Y,Z,1,'*','w','Tag','StarScatter');
        end
        
        function SpawnHouses(World_Data)
            
            %Spawn Houses
            islands = World_Data.Map>510;
            ero = imerode(islands,strel('disk',10));
            rec=imreconstruct(ero,islands);
            houseplots = bwmorph(rec,'shrink','Inf');
            
            plots = regionprops(houseplots);
            houses = zeros(3,length(plots));
            for i=1:2%length(plots)
                houses(1:2,i) = plots(i).Centroid';
                houses(3,i) = World_Data.Map(houses(2,i),houses(1,i));
            end
            
            for i = 1:length(plots)
                World_Data.HouseList{end+1} = ...
                    House(houses(1,i),houses(2,i),houses(3,i),"house_"+i);
            end
            
        end 
        
    end
end

