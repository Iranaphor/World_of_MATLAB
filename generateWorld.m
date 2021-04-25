function generateWorld()
    
%     % As of R2021a
%     arguments
%        debug (1,1) Bool {fcn1,fcn2} = true;
%     end
    
    close, clc, clear
    add_all_files()
    debug = true;
    
    % Create and Label Window
    supplot(1,1,1,1,'');
    f=findobj(gcf); 
    set(f(1),'MenuBar', 'none');
    set(f(2),'Tag', 'SuperPlot');
    
    if debug
        set(gcf,'WindowStyle','docked')
    end
    
    % Setup World Details
    global World_Data;
    World_Data = World(500);

    % Setup Player Details
    global Player_Data;
    Player_Data = Player(World_Data);
    
    % Setup Camera Details
    global Camera_Data;
    Camera_Data = Camera(200);
    
    % Render The View
    global Visuals_Manager;
    Visuals_Manager = VisualsManager();
end