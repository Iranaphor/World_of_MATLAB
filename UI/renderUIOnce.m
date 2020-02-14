function renderUIOnce()
%     disp("renderUIOnce")
    
    %Generate New World
    uicontrol('style','push',...
              'units','pix',...
              'position',[10 10 180 40],...
              'fontsize',14,...
              'string','Reload',...
              'callback',{@generateWorld},...
              'Tag','ReloadButton');
    
    
    %Minimap Panel
    f=gcf;
    Ip = f.InnerPosition(4)/4;
    IpW = f.InnerPosition(4)-Ip;
    IpH = f.InnerPosition(3)-Ip;
    minimap_panel = uipanel(gcf,'Units','pixels','Position',[IpH+5,IpW+5,Ip,Ip],'Tag','MinimapPanel');
    set(findobj('Tag','MinimapPanel'), 'BorderType', 'none', 'BackgroundColor', [64, 50, 35]/255);
    
    
    %Minimap Map
    axes(minimap_panel,'Tag','MinimapAxes');
    
    
    %Set Resize Callback
    set(f,'SizeChangedFcn',@window_resize_callback_enbedded)
end
function window_resize_callback_enbedded(~,~)
%     disp("window_resize_callback_inbedded")
        
    delete(findobj('Tag','MinimapPanel')); %TODO: Swap these from deleteobj to move/resizeobj
    delete(findobj('Tag','ReloadButton'));
    
    renderUIOnce()
    renderUI()
end