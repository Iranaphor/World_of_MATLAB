classdef VisualsManager < handle
    %RENDERER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Docked
    end
    
    methods
        function obj = VisualsManager()
            obj.Docked = true;
            obj.renderOnce()
            obj.renderUIOnce()
            obj.UpdateRendering()
        end
        
        function UpdateRendering(obj)
            obj.render()
            obj.renderUI()
        end
        
    end
    
    methods (Static)
        
        function renderOnce()
            
            global World_Data;
            global Player_Data;
            
            %Display World
            surf(findobj('Tag','SuperPlot'),World_Data.Map,'Tag','MapSurf');
            f=findobj(gcf); set(f(2),'Tag','SuperPlot');
            hold on
            ax=gca;
            ax.Projection = 'perspective';
            set(ax,'Zlim',[0,2]);
            shading interp;
            c=colormap(summer); c(1,:)=[0.15,0.55,0.85]; colormap(c)
            
            scatter3(World_Data.Stars(1,:),World_Data.Stars(2,:),World_Data.Stars(3,:),1,'*','w','Tag','StarScatter');
            
            scatter3(Player_Data.X,Player_Data.Y,Player_Data.Z,200,'filled','MarkerFaceColor',[64, 50, 35]/255,'Tag','PlayerScatter');
            
            hold off
            
            set(gcf,'Color',[0.05,0.1,0.3])
            set(ax,'visible','off')
            
            
            %RENDER THE WATER WITH A SECOND SURF MAP
            
        end
        
        function render()
            
            global Player_Data;
            
            %Update Player Location
            Player = findobj('Tag','PlayerScatter');
            Player.XData(1) = Player_Data.X;
            Player.YData(1) = Player_Data.Y;
            Player.ZData(1) = Player_Data.Z;
            
            %Update Camera Target [0.015,10,0.005,80]
            cT=0.015;
            cD=10;
            cP=0.005;
            cV=80;
            
            CameraAxes = Player.Parent;
            CameraAxes.CameraTarget = [Player_Data.X,Player_Data.Y,Player_Data.Z+cT];
            
            %Update Camera Position
            CamDist=cD;
            CamX = Player_Data.X+(CamDist*sind(Player_Data.Angle));
            CamY = Player_Data.Y+(CamDist*cosd(Player_Data.Angle));
            CamPitch = Player_Data.Z+cP+cT;
            CameraAxes.CameraPosition  = [CamX, CamY, CamPitch];
            CameraAxes.CameraViewAngle = cV;
            
            
            %disp(toc)
            set(gcf,'KeyPressFcn',@KeyPress);
            
        end
        
        function renderUIOnce()
            %     disp("renderUIOnce")
            
            %Generate New World
            uicontrol('style','push',...
                'units','pix',...
                'position',[10 10 180 40],...
                'fontsize',14,...
                'string','Reload',...
                'callback',{@generateWorld},...
                'Tag','ReloadButton');
            
            
            %Minimap Panel
            f=gcf;
            Ip = f.InnerPosition(4)/4;
            IpW = f.InnerPosition(4)-Ip;
            IpH = f.InnerPosition(3)-Ip;
            minimap_panel = uipanel(gcf,'Units','pixels','Position',[IpH+5,IpW+5,Ip,Ip],'Tag','MinimapPanel');
            set(findobj('Tag','MinimapPanel'), 'BorderType', 'none', 'BackgroundColor', [64, 50, 35]/255);
            
            
            %Minimap Map
            axes(minimap_panel,'Tag','MinimapAxes');
            
            
            %Set Resize Callback
            set(f,'SizeChangedFcn',@VisualsManager.window_resize_callback_enbedded)
        end
        function window_resize_callback_enbedded(~,~)
            %     disp("window_resize_callback_inbedded")
            
            delete(findobj('Tag','MinimapPanel')); %TODO: Swap these from deleteobj to move/resizeobj
            delete(findobj('Tag','ReloadButton'));
            
            VisualsManager.renderUIOnce()
            VisualsManager.renderUI()
        end
        
        function renderUI()
            %     disp("renderUI")
            
            global World_Data;
            global Player_Data;
            
            %Identify Axes
            MinimapAxes = findobj('Tag','MinimapAxes');
            
            %Load Map
            Map = World_Data.Map';
            
            %Plot Player position on map
            psize=5;
            Map(floor(Player_Data.X)-psize:floor(Player_Data.X)+psize,...
                floor(Player_Data.Y)-psize:floor(Player_Data.Y)+psize) = 0.52;
            
            %Plot map on axes
            msize=100;
            
            try %TODO: Find a way to reduce the necceccity for reloading img each time
                imagesc(MinimapAxes,Map(floor(Player_Data.X)-msize:floor(Player_Data.X)+msize,...
                    floor(Player_Data.Y)-msize:floor(Player_Data.Y)+msize),...
                    'Tag','MinimapImage');
            catch
                imagesc(MinimapAxes,Map,'Tag','MinimapImage');
            end
            
            f=findobj('Tag','MinimapImage'); set(f.Parent,'Tag','MinimapAxes');
            %     axis(f.Parent,'equal');   %Causes too much lag
            set(MinimapAxes,'visible','off');
            
            set(gcf,'CurrentAxes',findobj('Tag','SuperPlot'))
            
        end
        
    end
end

