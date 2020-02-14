function KeyPress(~,event)
%     disp("KeyPress")
    
    tic
    global Window_Settings;
    global Player_Data;
    global World_Data;
    KEY = string(event.Key);
    
    
    %Dock Window
    if (KEY == "escape")
        if (Window_Settings.Docked == true)
            set(gcf, 'WindowStyle', 'Normal');
        else
            set(gcf, 'WindowStyle', 'Docked'); 
        end
        Window_Settings.Docked = ~Window_Settings.Docked;
        return;
    end
    
    
    %Move Player
    A=Player_Data.Angle;
    Xn = Player_Data.X;
    Yn = Player_Data.Y;
    
    if (KEY == "w")
        Xn = Xn - sind(A);
        Yn = Yn - cosd(A);
    elseif (KEY == "s")
        Xn = Xn + sind(A);
        Yn = Yn + cosd(A);
    elseif (KEY == "a")
        A = A - 10;
    elseif (KEY == "d")
        A = A + 10;
    end
    
    
    %Boundary Management
    S=World_Data.PlayerBoundary;
    if Xn > S(1); Xn = S(1); end
    if Yn > S(2); Yn = S(2); end
    if Xn < 1; Xn = 1; end
    if Yn < 1; Yn = 1; end
    
    
    %Set specific Z value
    X1 = floor(Xn);
    Y1 = floor(Yn);
    X2 = ceil(Xn)+(floor(Xn)==Xn);
    Y2 = ceil(Yn)+(floor(Yn)==Yn);
    R = World_Data.Map(Y1:Y2,X1:X2);
    
    Px=floor(10*(Xn-floor(Xn)))+1;
    Rx1 = linspace(R(1,1),R(1,2),10);
    Rx2 = linspace(R(2,1),R(2,2),10);
    Y3=Rx1(Px);
    Y4=Rx2(Px);
    
    Py=floor(10*(Yn-floor(Yn)))+1;
    Ry=linspace(Y3,Y4,10);
    Zn=Ry(Py);
    
    
    %Check for Cliff Movement
    if (Zn<=Player_Data.Z)
        Player_Data.X = Xn; %Only save new positions if movement is valid.
        Player_Data.Y = Yn;
        Player_Data.Z=Zn;
        Player_Data.Angle = A;
    end
    
    render();
    disp(toc)
end