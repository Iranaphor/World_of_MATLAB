function renderUI()
    global World_Data;
    global Player_Data;
    
    %Save World Axes
    WorldAxes = gca; %TODO: Swap out with findobj
    
    %Identify Axes
    MinimapAxes = axes(findobj('Tag','MinimapAxes'));
    
    %Load Map
    Map = World_Data.Map';
    
    %Plot Player position on map
    psize=5;
    Map(floor(Player_Data.X)-psize:floor(Player_Data.X)+psize,...
        floor(Player_Data.Y)-psize:floor(Player_Data.Y)+psize) = 0.52;
    
    %Plot map on axes
    msize=100;
    try
        imagesc(MinimapAxes,Map(floor(Player_Data.X)-msize:floor(Player_Data.X)+msize,...
                                              floor(Player_Data.Y)-msize:floor(Player_Data.Y)+msieze));
    catch
        imagesc(MinimapAxes,Map);
    end
%     pos=[Player_Data.Y-(0.5*msize),Player_Data.X-(0.5*msize),msize,msize]; 
%     rectangle('Position',pos,'Curvature',[1 1],'FaceColor',[1,1,1],'LineWidth',0.001);
    axis image
    set(MinimapAxes,'visible','off');
    set(gcf,'CurrentAxes',WorldAxes)
    
end