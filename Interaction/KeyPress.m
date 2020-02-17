function KeyPress(~,event)
%     disp("KeyPress")
    
    tic
    global Player_Data;
    global World_Data;
    global Visuals_Manager;
    KEY = string(event.Key);
    
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
    
    %Move Player
    a=["w","a","s","d"];
    if any(contains(a,KEY))
        %Move Player based on Input Key
        Player_Data.Move(KEY, World_Data);
    end
    
    Visuals_Manager.UpdateRendering();
    disp(toc)
end