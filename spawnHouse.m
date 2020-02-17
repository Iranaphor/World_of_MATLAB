function spawnHouse(X,Y,Z,id)
    [x, y] = meshgrid(-1:1,-1:1);
    [x2, y2] = meshgrid(-1:1,-0.5:0.5);

    %Define colours
    map = [147 127 108]/255;
    roof_map = [182 101 73]/255;
    hold on
    %Flat
    fz = (0.*x + 0.*y) - 1; surf(x+X,y+Y,(fz+Z)+1, 'FaceColor', map,'Tag',id+"-floor");
    fz2 = (0.*x + 0.*y) - 1; surf(x+X,y+Y,(fz2+Z)+3, 'FaceColor', map,'Tag',id+"-roof");

    %Wall A
    Az = (0.*x + 1.*y); surf(x+X,((y.*0)+1)+Y,(Az+Z)+1, 'FaceColor', map,'Tag',id+"-wall_a");
    %Wall 
    Bz = (0.*x + 1.*y); surf(x+X,((y.*0)-1)+Y,(Bz+Z)+1, 'FaceColor', map,'Tag',id+"-wall_b");
    %Wall C
    Cz = (0.*x + 1.*y); surf(((y.*0)+1)+X,x+Y,(Cz+Z)+1, 'FaceColor', map,'Tag',id+"-wall_c");
    %Wall D
    Dz = (0.*x + 1.*y); surf(((y.*0)-1)+X,x+Y,(Dz+Z)+1, 'FaceColor', map,'Tag',id+"-wall_d");


    %Roof RA
    Rz = (0.*x2 + 1.*y2)+1; surf((x2+X),(y2+Y)-0.5,(Rz+Z)+1.5, 'FaceColor', roof_map,'Tag',id+"-roof_a");
    %Roof RA
    Rz = (0.*x2 + -1.*y2)+1; surf((x2+X),(y2+Y)+0.5,(Rz+Z)+1.5, 'FaceColor', roof_map,'Tag',id+"-roof_b");

    

    hold off
%     L=5; xlim([-L,L]), ylim([-L,L]), zlim([-L,L])
end