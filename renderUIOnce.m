function renderUIOnce()
    global UI_Components;
    
    %Generate New World
    uicontrol('style','push',...
              'units','pix',...
              'position',[10 10 180 40],...
              'fontsize',14,...
              'string','Reload',...
              'callback',{@generateWorld},...
              'Tag','ReloadButton');
    UI_Components.all(end+1)="ReloadButton";
    
    
    %Minimap Panel
    f=gcf;
    Ip = f.InnerPosition(4)/4;
    IpW = f.InnerPosition(4)-Ip;
    IpH = f.InnerPosition(3)-Ip;
    uipanel(gcf,'Units','pixels','Position',[IpH+5,IpW+5,Ip,Ip],'Tag','MinimapPanel');
    set(findobj('Tag','MinimapPanel'), 'BorderType', 'none','BackgroundColor',[64, 50, 35]/255)
    UI_Components.all(end+1)="MinimapPanel";
    
    %Minimap Map
    axes(findobj('Tag','MinimapPanel'),'Tag','MinimapAxes');
    UI_Components.all(end+1)="MinimapAxes";
    subplot(findobj('Tag','MinimapAxes'));
    
    %
    UI_Components.Rendered = true;
    
    set(f,'SizeChangedFcn',@window_resize_callback_inbedded)
end
function window_resize_callback_inbedded(~,~)
    disp("window_resize_callback_inbedded")
    global UI_Components;
    for i = length(UI_Components.all)
        delete(findobj('Tag',UI_Components.all(i)))
    end
    renderUIOnce()
    renderUI()
end