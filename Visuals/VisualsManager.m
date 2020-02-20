classdef VisualsManager < handle
    
    properties
        OldPosition
        window_state
    end
    
    methods
        function obj = VisualsManager()
            %obj.Docked = true;
            obj.renderOnce()
            obj.renderUIOnce()
            obj.UpdateRendering()
            obj.window_state = "floating";
            obj.OldPosition = get(gcf,'Position');
        end
        
        function UpdateRendering(obj)
            obj.render()
            obj.renderUI()
        end
        
        function AdjustWindow(obj, KEY)
            disp("Issues with this.")
            switch obj.window_state
                
                %When the window is docked
                case "docked"
                    switch(KEY)
                        case "f11"
                            obj.makeFullscreen()
                        case "escape"
                            obj.makeFloating()
                    end
                
                    
                %When the window is fullscreen
                case "fullscreen"
                    switch(KEY)
                        case "f11"
                            obj.makeFloating()
                        case "escape"
                            obj.makeDocked()
                    end
                %When the window is floating
                case "floating"
                    switch(KEY)
                        case "f11"
                            obj.makeFullscreen()
                        case "escape"
                            obj.makeDocked()
                    end
            end
        end
        function makeFloating(obj)
            obj.window_state = "floating";
            
            %Undock the window
            set(gcf, 'WindowStyle', 'Normal');

            %Set the posision to match the old position
            set(gcf, 'Units', 'pixels')
            set(gcf, 'Position', obj.OldPosition)
        end
        function makeFullscreen(obj)
            obj.window_state = "fullscreen";
            
            %Disable docked state
            set(gcf, 'WindowStyle', 'Normal');
            
            %Save Position
            obj.OldPosition = get(gcf,'Position');
            
            %Make fullscreen
            set(gcf, 'Units', 'normalized');
            set(gcf, 'Position', [0,0,0.5,1]);
            disp(obj)
        end
        function makeDocked(obj)
            obj.window_state = "docked";
            
            %Save the prior position
            obj.OldPosition = get(gcf,'Position');
            
            %Dock the window
            set(gcf, 'WindowStyle', 'Docked');
            disp(obj)
        end

    end
    
    methods (Static)
        
        function renderOnce()
            
            global World_Data;
            global Player_Data;
            
            World_Data.SpawnIslands();
            hold on
            World_Data.SpawnWater();
            World_Data.SpawnStars();
            World_Data.SpawnHouses();
            
            Player_Data.SpawnPlayer();
            
            set(gcf,'Color',[0.05,0.1,0.3])
            set(findobj('Tag','SuperPlot'),'visible','off')
            
        end
        
        function render()
            
            global Player_Data;
            
            %Update Player Location
            Player = findobj('Tag','PlayerScatter');
            Player.XData(1) = Player_Data.X;
            Player.YData(1) = Player_Data.Y;
            Player.ZData(1) = Player_Data.Z;
            
            %Update Camera Target [0.015,10,0.005,80]
            cT=15;
            cD=10;
            cP=5;
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
            
            set(gcf,'KeyPressFcn',@KeyPress);
            
        end
        
        function renderUIOnce()
            %     disp("renderUIOnce")
            set(gcf,'Units','pixels');
            
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
                floor(Player_Data.Y)-psize:floor(Player_Data.Y)+psize)=520;
            
            %Plot map on axes
            msize=100;
            
            try %TODO: Find a way to reduce the necceccity for reloading img each time
                imagesc(MinimapAxes,Map(floor(Player_Data.X)-msize:floor(Player_Data.X)+msize,...
                    floor(Player_Data.Y)-msize:floor(Player_Data.Y)+msize),...
                    'Tag','MinimapImage');
            catch
                imagesc(MinimapAxes,Map,'Tag','MinimapImage');
            end
            
            
            %% FIX THIS!
            %%%%% caxis([min(cdx(:)) max(cdy(:))])
            
            
            
            
            
            
            %%
            
            
            f=findobj('Tag','MinimapImage'); set(f.Parent,'Tag','MinimapAxes');
            %     axis(f.Parent,'equal');   %Causes too much lag
            set(MinimapAxes,'visible','off');
            
            set(gcf,'CurrentAxes',findobj('Tag','SuperPlot'))
            
        end
        
    end
end

