close, clc, clear
add_all_files()

% Setup Window Details
global Window_Settings;
Window_Settings.Docked = false;

generateWorld()

function generateWorld(varargin)
    supplot(1,1,1,1);
    f=findobj(gcf); set(f(2),'Tag','SuperPlot');
    disp(varargin)
    
    % Setup World Details
    global World_Data;
    World_Data = World(1000);

    % Setup Player Details
    global Player_Data;
    Player_Data = Player(World_Data.Map);
    
    % Setup Camera Details
    global Camera_Data;
    Camera_Data = Camera(200);
    
    renderOnce();
    
end

