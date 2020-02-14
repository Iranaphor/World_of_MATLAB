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
    try %TODO: Find a way to reduce the necceccity for reloadingh img each time
        imagesc(MinimapAxes,Map(floor(Player_Data.X)-msize:floor(Player_Data.X)+msize,...
                                floor(Player_Data.Y)-msize:floor(Player_Data.Y)+msize),...
                                'Tag','MinimapImage');
    catch
        imagesc(MinimapAxes,Map,'Tag','MinimapImage');
    end
    f=findobj('Tag','MinimapImage'); set(f.Parent,'Tag','MinimapAxes');
    axis(f.Parent,'equal');
    set(MinimapAxes,'visible','off');
    
    set(gcf,'CurrentAxes',findobj('Tag','SuperPlot'))
    
end