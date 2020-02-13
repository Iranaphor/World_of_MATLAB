function render()
    global Player_Data;
    
    %Update Player Location
    AXIS = gca;
    ScatterPlot = AXIS.Children(1);
    ScatterPlot.XData(1) = Player_Data.X;
    ScatterPlot.YData(1) = Player_Data.Y;
    ScatterPlot.ZData(1) = Player_Data.Z;
    
    %Update Camera Target
    cT=0.015;
    cD=10;
    cP=0.005;
    cV=80;
    
    AXIS.CameraTarget = [Player_Data.X,Player_Data.Y,Player_Data.Z+cT];
    
    %Update Camera Position
    CamDist=cD;
    CamX = Player_Data.X+(CamDist*sind(Player_Data.Angle));
    CamY = Player_Data.Y+(CamDist*cosd(Player_Data.Angle));
    CamPitch = Player_Data.Z+cP+cT;
    AXIS.CameraPosition  = [CamX, CamY, CamPitch];
    AXIS.CameraViewAngle = cV;
    
%     global Camera_Data;
%     AXIS.XLim =[Player_Data.X-Camera_Data.Render_Distance,Player_Data.X+Camera_Data.Render_Distance];
%     AXIS.YLim =[Player_Data.Y-Camera_Data.Render_Distance,Player_Data.Y+Camera_Data.Render_Distance];
    
    %disp(toc)
    set(gcf,'KeyPressFcn',@KeyPress);
    %tic
    renderUI()
end