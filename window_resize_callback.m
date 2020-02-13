function window_resize_callback(~,~)
    disp("window_resize_callback")
    global UI_Components;
    delete(UI_Components.MinimapAxes)
    delete(UI_Components.pb)
    delete(UI_Components.MinimapPanel)
    renderUIOnce()
    renderUI()
end