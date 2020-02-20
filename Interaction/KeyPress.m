function KeyPress(~,event)
%     disp("KeyPress")
    
    tic
    global Player_Data;
    global World_Data;
    global Visuals_Manager;
    KEY = string(event.Key);
    disp(KEY)
    %Dock Window
    if (KEY == "escape")
        if (Visuals_Manager.Docked == true)
            set(gcf, 'WindowStyle', 'Normal');
        else
            set(gcf, 'WindowStyle', 'Docked'); 
        end
        Visuals_Manager.Docked = ~Visuals_Manager.Docked;
        return;
    end
    if (KEY=="f11")
        disp("F11")
        if (Visuals_Manager.Fullscreen == true)
            set(gcf, 'Position', Visuals_Manager.OldPosition, 'Units', 'pixels')
        else
            Visuals_Manager.OldPosition = get(gcf,'Position');
            set(gcf, 'Position', [0,0,1,1], 'Units', 'normalized')
        end
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