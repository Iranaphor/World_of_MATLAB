classdef VisualsManager < handle
    
    properties
        Docked
        MinimapPanel
        MinimapAxes
        MinimapImage
        
        tf
        avg_spf
    end
    
    methods
        function obj = VisualsManager()
            obj.Docked = true;
            obj.renderOnce()
            obj.renderUIOnce()
            obj.UpdateRendering()
            
            obj.tf=1;
            obj.avg_spf=0.005;
        end
        
        function [rSPF,ruiSPF]=UpdateRendering(VisualsManager)
            r=tic;
            VisualsManager.render()
            rSPF=toc(r);
            rui=tic;
            VisualsManager.renderUI()
            ruiSPF=toc(rui);
            
        end
        
    end
    
    methods (Static)
        
        function renderOnce()
            
            global World_Data;
            global Player_Data;
            
            World_Data.SpawnIslands();
            hold on
            World_Data.SpawnWater();
%             World_Data.SpawnStars();
%             World_Data.SpawnHouses();
            
            Player_Data.SpawnPlayer();
            
            set(gcf,'Color',[0.05,0.1,0.3])
            set(findobj('Tag','SuperPlot'),'visible','off')
            
        end
        
        function render()
            
            global Player_Data;
            global Camera_Data;
            
            %Update Player Location
            Player = findobj('Tag','PlayerScatter');
            Player.XData(1) = Player_Data.X;
            Player.YData(1) = Player_Data.Y;
            Player.ZData(1) = Player_Data.Z;
            
            %Update Camera Target
            cT = Camera_Data.cT;
            CameraAxes = Player.Parent;
            CameraAxes.CameraTarget = [Player_Data.X,Player_Data.Y,Player_Data.Z+cT];
            
            %Update Camera Position
            cD = Camera_Data.cD;
            CamDist=cD;
            CamX = Player_Data.X+(CamDist*sind(Player_Data.Angle));
            CamY = Player_Data.Y+(CamDist*cosd(Player_Data.Angle));
            %TODO: Add camea animation for rotational movement
            
            %Update Camera Orientation
            cP = Camera_Data.cP;
            CamPitch = Player_Data.Z+cP+cT;
            CameraAxes.CameraPosition  = [CamX, CamY, CamPitch];
            
            %Update Camera View Angle
            cV = Camera_Data.cV;
            CameraAxes.CameraViewAngle = cV;
            
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
            MinimapPanel = uipanel(gcf,'Units','pixels','Position',[IpH+5,IpW+5,Ip,Ip],'Tag','MinimapPanel');
            set(MinimapPanel, 'BorderType', 'none', 'BackgroundColor', [64, 50, 35]/255);
            
            %Minimap Map
            MinimapAxes = axes(MinimapPanel, 'Tag','MinimapAxes','visible','off');
                       
            %Populate World_Data.Map, & remove the axis generated on parent
            global World_Data
            MinimapImage = imagesc(MinimapAxes, World_Data.Map','Tag','MinimapImage');
            World_Data.ColorIslandsBasic(MinimapAxes)
            set(MinimapImage.Parent, 'Tag', 'MinimapAxes')
            set(MinimapAxes, 'visible','off')
            
            %Set base focus to the SuperPlot
            set(gcf, 'CurrentAxes', findobj('Tag','SuperPlot'))
            
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
            global Player_Data;
            
            %% Identify Axes
            MinimapAxes = findobj('Tag','MinimapAxes'); 
            %Why dont we store this in an obj variable? 
            %means changing from static function
            
            %% Plot Player position on map
            %psize=5;
            %Map(floor(Player_Data.X)-psize:floor(Player_Data.X)+psize,...
            %    floor(Player_Data.Y)-psize:floor(Player_Data.Y)+psize)=520; 
            %We should be setting this value as a an overlay rather then modifying the Map?
            
            %% Plot map on axes
            msize=100;
            ylim(MinimapAxes,[floor(Player_Data.X)-msize,floor(Player_Data.X)+msize])
            xlim(MinimapAxes,[floor(Player_Data.Y)-msize,floor(Player_Data.Y)+msize])

        end
        
    end
end

