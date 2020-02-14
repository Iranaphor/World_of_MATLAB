function render()
%     disp("render")
    
    global Player_Data;
    
    %Update Player Location
    Player = findobj('Tag','PlayerScatter');
    Player.XData(1) = Player_Data.X;
    Player.YData(1) = Player_Data.Y;
    Player.ZData(1) = Player_Data.Z;
    
    %Update Camera Target
    cT=0.015;
    cD=10;
    cP=0.005;
    cV=80;
    
    CameraAxes = Player.Parent;
    CameraAxes.CameraTarget = [Player_Data.X,Player_Data.Y,Player_Data.Z+cT];
    
    %Update Camera Position
    CamDist=cD;
    CamX = Player_Data.X+(CamDist*sind(Player_Data.Angle));
    CamY = Player_Data.Y+(CamDist*cosd(Player_Data.Angle));
    CamPitch = Player_Data.Z+cP+cT;
    CameraAxes.CameraPosition  = [CamX, CamY, CamPitch];
    CameraAxes.CameraViewAngle = cV;
    
    %disp(toc)
    set(gcf,'KeyPressFcn',@KeyPress);
    %tic
    renderUI()
end