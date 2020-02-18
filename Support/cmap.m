function A = cmap(colour1, colour2, N)
    A=[linspace(colour1(1),colour2(1),N);...
       linspace(colour1(2),colour2(2),N);...
       linspace(colour1(3),colour2(3),N)]'; 
    A=flip(A);
end

