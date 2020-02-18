classdef Player < handle
    
    properties
        X
        Y
        Z
        Angle %Change to Yaw
        OffsetZ
        boatX
        boatY
        boatZ
    end
    
    methods
        function Player_Data = Player(World_Data)
            X=size(World_Data.Map,1)/2;
            Y=size(World_Data.Map,2)/2;
            Player_Data.X = X;
            Player_Data.Y = Y;
            Player_Data.Z = World_Data.Map(floor(X),floor(Y));
            Player_Data.Z = max(World_Data.Map(X,Y),World_Data.WaterMap(X,Y));
            Player_Data.Angle = 0;
            Player_Data.OffsetZ = 0.0;
        end
        
        
        function Move(Player_Data, KEY, World_Data)
            
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
            R = max(World_Data.Map(Y1:Y2,X1:X2),World_Data.WaterMap(Y1:Y2,X1:X2));
            
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
                Player_Data.Z = Zn;
                Player_Data.Angle = A;
            end
            
        end
        
        function SpawnPlayer(P)
            C=[64, 50, 35]/255;
            scatter3(P.X,P.Y,P.Z,200,'filled',...
                    'MarkerFaceColor',C,...
                    'Tag','PlayerScatter');
        end
        
    end
end

