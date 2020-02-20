function KeyPress(~,event)
%     disp("KeyPress")
    
    tic
    global Player_Data;
    global World_Data;
    global Visuals_Manager;
    KEY = string(event.Key);
    
    
    %Reposition Window
    window_modifiers=["escape","f11"];
    if any(contains(window_modifiers,KEY))
        Visuals_Manager.AdjustWindow(KEY);
    end

    %Move Player
    a=["w","a","s","d"];
    if any(contains(a,KEY))
        %Move Player based on Input Key
        Player_Data.Move(KEY, World_Data);
    end
    
    if KEY=="f5"
        generateWorld();
        return;
    end
    
    Visuals_Manager.UpdateRendering();
    disp(toc)
end