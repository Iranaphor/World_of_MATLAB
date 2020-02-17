function spawnHouse(X,Y,Z,id)
    
    SCALE = 1;
    W=1;
    H=1;

    %Walls
    [x, y] = meshgrid(-1:1,-1:1);
    o=y.*0;

    %Define colours
    map = [147 127 108]/255;
    roof_map = [182 101 73]/255;
    hold on
    
    %Flat
    fz=   o; surf(x+X,     y+Y, fz+Z,'FaceColor', map,'Tag',id+"-flr_a");
    f2= o+2; surf(x+X,     y+Y, f2+Z,'FaceColor', map,'Tag',id+"-flr_b");
    Az= y+1; surf(x+X, (o+1)+Y, Az+Z,'FaceColor', map,'Tag',id+"-wall_a");
    Bz= y+1; surf(x+X, (o-1)+Y, Bz+Z,'FaceColor', map,'Tag',id+"-wall_b");
    Cz= y+1; surf((o+1)+X, x+Y, Cz+Z,'FaceColor', map,'Tag',id+"-wall_c");
    Dz= y+1; surf((o-1)+X, x+Y, Dz+Z,'FaceColor', map,'Tag',id+"-wall_d");

    %Roofs
    [x2, y2] = meshgrid(-1:1,-0.5:0.5);
    R1 = ( y2)+2.5; surf(x2+X,(y2+Y)-0.5,R1+Z, 'FaceColor', roof_map,'Tag',id+"-roof_a");
    R2 = (-y2)+2.5; surf(x2+X,(y2+Y)+0.5,R2+Z, 'FaceColor', roof_map,'Tag',id+"-roof_b");

    hold off
end