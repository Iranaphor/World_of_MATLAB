function renderOnce()
%     disp("renderOnce")
    
    global World_Data;
    global Player_Data;

    
    
    %Display World
    surf(findobj('Tag','SuperPlot'),World_Data.Map,'Tag','MapSurf');
    f=findobj(gcf); set(f(2),'Tag','SuperPlot');
    hold on
    ax=gca;
    ax.Projection = 'perspective';
    set(ax,'Zlim',[0,2]);
    shading interp;
    c=colormap(summer); c(1,:)=[0.15,0.55,0.85]; colormap(c)
    
    scatter3(World_Data.Stars(1,:),World_Data.Stars(2,:),World_Data.Stars(3,:),1,'*','w','Tag','StarScatter');
    
    scatter3(Player_Data.X,Player_Data.Y,Player_Data.Z,200,'filled','MarkerFaceColor',[64, 50, 35]/255,'Tag','PlayerScatter');
    
    hold off
    
    set(gcf,'Color',[0.05,0.1,0.3])
    set(ax,'visible','off')
    
    
    %RENDER THE WATER WITH A SECOND SURF MAP
    
    renderUIOnce()
    render()
end