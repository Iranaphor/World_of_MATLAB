function generateWorld(~,~)
    close, clc, clear
    add_all_files()
    
    % Create and Label Window
    supplot(1,1,1,1,'');
    f=findobj(gcf); set(f(2),'Tag','SuperPlot');
    
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