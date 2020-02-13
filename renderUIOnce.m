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
    subplot(UI_Components.MinimapAxes);
    
    UI_Components.Rendered = true;
    
    set(f,'SizeChangedFcn',@window_resize_callback)
end
function window_resize_callback(~,~)
    global UI_Components;
    delete(UI_Components.MinimapAxes)
    delete(UI_Components.pb)
    delete(UI_Components.MinimapPanel)
    renderUIOnce()
    renderUI()
end