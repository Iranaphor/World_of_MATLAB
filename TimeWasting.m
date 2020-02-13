close, clc, clear

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

    World_Data.SeaLevel=0.5;

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

