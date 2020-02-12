close, clc, clear
% tic
% Setup Window Details
global Window_Settings;
global UI_Components;
Window_Settings.Docked = false;
UI_Components.Rendered = false;
generateWorld()

function generateWorld(varargin)
    supplot(1,1,1,1);
    disp(varargin)
    % Setup World Details
    global World_Data;
    World_Data.Size=1000; W=World_Data.Size;
    World_Data.PlayerBoundary=[W,W]*0.95;

    World_Data.SeaLevel=0.5;%0.4859;a

    World_Data.Stars=(rand(3,0.005*(W*W)).*[2000,2000,0.2]')+[-1000,-1000,0.7]';
    
    World_Data.Map=rand(W,W);
    World_Data.Map(45:55,45:55)=World_Data.Map(45:55,45:55)+0.2;
    for i=1:19; World_Data.Map=smoothdata(World_Data.Map'); end
    World_Data.Map(World_Data.Map<(0.002+World_Data.SeaLevel))=World_Data.SeaLevel;


    % Setup Player Details
    global Player_Data;
    X=W/2;
    Y=W/2;
    Player_Data.X = X;
    Player_Data.Y = Y;
    Player_Data.Z = World_Data.Map(X,Y);
    Player_Data.Angle = 0;
    Player_Data.ScatterPlot=NaN;
    Player_Data.OffsetZ = 0.0;

    % Setup Camera Details
    global Camera_Data;
    Camera_Data.Render_Distance = 200; 
    Camera_Data.CameraPosition = [-50 50 1];
    Camera_Data.Yaw = 0;
    Camera_Data.Pitch = 0;

    renderOnce();
    
end

function KeyPress(~,event)
    global Window_Settings;
    global Player_Data;
    global World_Data;
    KEY = string(event.Key);
    
    
    %Dock Window
    if (KEY == "escape")
        if (Window_Settings.Docked == true)
            set(gcf, 'WindowStyle', 'Normal');
        else
            set(gcf, 'WindowStyle', 'Docked'); 
        end
        Window_Settings.Docked = ~Window_Settings.Docked;
        return;
    end
    
    clc
    %Move Player
    A=Player_Data.Angle;
    Xn = Player_Data.X;
    Yn = Player_Data.Y;
    
    if (KEY == "w")
        Xn = Xn - sind(A);
        Yn = Yn - cosd(A);
    elseif (KEY == "s")
        Xn = Xn + sind(A);
        Yn = Yn + cosd(A);
    elseif (KEY == "a")
        A = A - 10;
    elseif (KEY == "d")
        A = A + 10;
    end
    
    
    %Boundary Management
    S=World_Data.PlayerBoundary;
    if Xn > S(1); Xn = S(1); end
    if Yn > S(2); Yn = S(2); end
    if Xn < 1; Xn = 1; end
    if Yn < 1; Yn = 1; end
    
    
    %Set specific Z value
    X1 = floor(Xn);
    Y1 = floor(Yn);
    X2 = ceil(Xn)+(floor(Xn)==Xn);
    Y2 = ceil(Yn)+(floor(Yn)==Yn);
    R = World_Data.Map(Y1:Y2,X1:X2);
    
    Px=floor(10*(Xn-floor(Xn)))+1;
    Rx1 = linspace(R(1,1),R(1,2),10);
    Rx2 = linspace(R(2,1),R(2,2),10);
    Y3=Rx1(Px);
    Y4=Rx2(Px);
    
    Py=floor(10*(Yn-floor(Yn)))+1;
    Ry=linspace(Y3,Y4,10);
    Zn=Ry(Py);
    
    
    %Check for Cliff Movement
%     disp(Zn+" <= "+Player_Data.Z + " ?")
    if (Zn<=Player_Data.Z)
        disp("Zn>Z")
        Player_Data.X = Xn; %Only save new positions if movement is valid.
        Player_Data.Y = Yn;
        Player_Data.Z=Zn;
        Player_Data.Angle = A;
    end
    
    render();
end

function renderOnce()
    
    global World_Data;
    global Player_Data;

    %Display World
    World_Data.MapSurf=surf(World_Data.Map); hold on
    ax=gca; ax.Projection = 'perspective';
    set(ax,'Zlim',[0,2]);
    shading interp;
    c=colormap(summer); c(1,:)=[0.15,0.55,0.85]; colormap(c)
    
    World_Data.StarScatter = scatter3(World_Data.Stars(1,:),World_Data.Stars(2,:),World_Data.Stars(3,:),1,'*','w');
    
    Player_Data.ScatterPlot = scatter3(Player_Data.X,Player_Data.Y,Player_Data.Z,200,'filled','r');
    
    hold off
    
    set(gcf,'Color',[0.05,0.1,0.3])
    set(ax,'visible','off')
    
    
    %RENDER THE WATER WITH A SECOND SURF MAP
    
    render()
end

function render()
    global Player_Data;
    
    %Update Player Location
    AXIS = gca;
    ScatterPlot = AXIS.Children(1);
    ScatterPlot.XData(1) = Player_Data.X;
    ScatterPlot.YData(1) = Player_Data.Y;
    ScatterPlot.ZData(1) = Player_Data.Z;
    
    %Update Camera Target
    cT=0.015;
    cD=10;
    cP=0.005;
    cV=80;
    
    AXIS.CameraTarget = [Player_Data.X,Player_Data.Y,Player_Data.Z+cT];
    
    %Update Camera Position
    CamDist=cD;
    CamX = Player_Data.X+(CamDist*sind(Player_Data.Angle));
    CamY = Player_Data.Y+(CamDist*cosd(Player_Data.Angle));
    CamPitch = Player_Data.Z+cP+cT;
    AXIS.CameraPosition  = [CamX, CamY, CamPitch];
    AXIS.CameraViewAngle = cV;
    
%     global Camera_Data;
%     AXIS.XLim =[Player_Data.X-Camera_Data.Render_Distance,Player_Data.X+Camera_Data.Render_Distance];
%     AXIS.YLim =[Player_Data.Y-Camera_Data.Render_Distance,Player_Data.Y+Camera_Data.Render_Distance];
    
    %disp(toc)
    set(gcf,'KeyPressFcn',@KeyPress);
    %tic
    renderUI()
end

function renderUIOnce()
    global UI_Components;
    disp("hi")
    
    %Generate New World
    UI_Components.pb = uicontrol('style','push',...
                 'units','pix',...
                 'position',[10 10 180 40],...
                 'fontsize',14,...
                 'string','Generate New World',...
                 'callback',{@generateWorld});
             
    %Minimap
    f=gcf;
    Ip = f.InnerPosition(4)/4;
    IpW = f.InnerPosition(4)-Ip;
    IpH = f.InnerPosition(3)-Ip;
    UI_Components.MinimapPanel = uipanel(gcf,'Units','pixels','Position',[IpH+5,IpW+5,Ip,Ip]);
    
    
    
    %UI_Components.MinimapPanel.Title
    
    
    set(UI_Components.MinimapPanel, 'BorderType', 'none','BackgroundColor',[64, 50, 35]/255)
    
    UI_Components.MinimapAxes = axes(UI_Components.MinimapPanel);
    subplot(UI_Components.MinimapAxes,'Position',[0,0,1,1]);
    
    UI_Components.Rendered = true;
    
    set(f,'SizeChangedFcn',@sbar)
end
function sbar(~,~)
    global UI_Components;
    delete(UI_Components.MinimapAxes)
    delete(UI_Components.pb)
    delete(UI_Components.MinimapPanel)
    renderUIOnce()
    renderUI()
end

function renderUI()
    global UI_Components;
    global World_Data;
    global Player_Data;
    ax = gca;
    if ~UI_Components.Rendered
        renderUIOnce();
    end

    axes(UI_Components.MinimapAxes);
    
    Map = World_Data.Map';
    
    psize=5;
    Map(floor(Player_Data.X)-psize:floor(Player_Data.X)+psize,...
        floor(Player_Data.Y)-psize:floor(Player_Data.Y)+psize) = 0.52;
    
    msize=100;
    try
        imagesc(UI_Components.MinimapAxes,Map(floor(Player_Data.X)-msize:floor(Player_Data.X)+msize,...
                                              floor(Player_Data.Y)-msize:floor(Player_Data.Y)+msieze));
    catch
        imagesc(UI_Components.MinimapAxes,Map);
    end
    pos=[Player_Data.Y-(0.5*msize),Player_Data.X-(0.5*msize),msize,msize]; 
    rectangle('Position',pos,'Curvature',[1 1],'FaceColor',[1,1,1],'LineWidth',0.001);
    axis image
    set(UI_Components.MinimapAxes,'visible','off');
    set(gcf,'CurrentAxes',ax)
    
end





