function KeyPress(~,event)
    
    total_spf=tic;
    global Player_Data;
    global World_Data;
    global Visuals_Manager;
    KEY = string(event.Key);
    
    %Reload All
    if (KEY == "r")
        TimeWasting()
        return;
    end
    
    
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
    
    %Update rendering for World and UI
    render_spf=tic;
    [rSPF,ruiSPF]=Visuals_Manager.UpdateRendering();
    disp("avgSPF:"+Visuals_Manager.avg_spf+" | tSPF:"+sprintf('%.5f',toc(total_spf))+"  | rSPF:"+sprintf('%.5f',toc(render_spf))+" (r:"+sprintf('%.5f',rSPF)+",rGUI:"+sprintf('%.5f',ruiSPF)+")")
    
    if Visuals_Manager.avg_spf == -1; Visuals_Manager.avg_spf = toc(total_spf); end
    Visuals_Manager.avg_spf = ((Visuals_Manager.avg_spf*Visuals_Manager.tf)+toc(total_spf))/(Visuals_Manager.tf+1);
    Visuals_Manager.tf = Visuals_Manager.tf+1;
end






