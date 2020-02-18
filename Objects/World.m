classdef World < handle
    
    properties
        Size
        PlayerBoundary
        SeaLevel
        Stars
        Map
        MapSurf
        WaterMap
        HouseList
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
            %             World_Data.Map(World_Data.Map<(2+World_Data.SeaLevel))=World_Data.SeaLevel;
            World_Data.WaterMap = (World_Data.Map.*0)+500.5;
            
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
            
            c1=cmap([.6,.8,.8],[ 0,.5, 0],40);
            c2=cmap([ 0,.5, 0],[ 1, 1, 0], 5);
            c3=cmap([ 1, 1, 0],[ 0,.4,.8],10);
            c4=cmap([ 0,.4,.8],[ 0, 0, 1],40);
            colormap([c4;c3;c2;c1])
            
        end
        
        function SpawnWater(World_Data)
            %RENDER THE WATER WITH A SECOND SURF MAP
            S(1) = findobj('Tag','MapSurf');
            S(2) = surfl(World_Data.WaterMap);
            set(S(2),'EdgeColor','none','FaceAlpha',0.5,'Tag','WaterSurf');
            
            c1=cmap([ 0, 1, 0],[ 0,.5, 0],12);
            c2=cmap([ 0,.5, 0],[ 1, 1, 0],3);
            c3=cmap([ 1, 1, 0],[ 0,.4,.8],3);
            c4=cmap([ 0,.4,.8],[ 0, 0, 1],12);
            
            cmapX = [c4;c3;c2;c1];
            cmapY = (cmapX.*0)+[0,0.3,1];
            cmapL = [cmapX;cmapY];
            colormap(cmapL)
            
            Z = World_Data.Map(:,:);
            zmin = min(Z(:));
            zmax = max(Z(:));
            
            cdx = min(64,round(63*(Z-zmin)/(zmax-zmin))+1);
            cdy = cdx+64;
            
            set(S(1),'CData',cdx)
            set(S(2),'CData',cdy)
            
            caxis([min(cdx(:)) max(cdy(:))])
            
            
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

