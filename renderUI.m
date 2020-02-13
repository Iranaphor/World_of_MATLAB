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