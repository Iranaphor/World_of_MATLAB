function A = cmap(colour1, colour2, N)
    %% CMAP creates a custom colourmap between two end points
    %
    %   CMAP(c1, c2, N) generates N points between c1 and c2.
    %
    %  @param colour1 a vector size 3 containing RGB values scaled between
    %      0 and 1
    %  @param colour2 a vector size 3 containing RGB values scaled between
    %      0 and 1
    %  @param N An integer defining the number of unique colours between the
    %      endpoints
    %  @return A the list of colours to use.
    %
    %
    %   Examples
    %     CMAP([1. 0. 0.], [0. 1. 1.], 10) creates a colourmap between red
    %       and cyan in 10 equal steps
    %
    %   @author Iranaphor
    %   @version 0.0.1
    %   @since 0.0.1


    A=[linspace(colour1(1),colour2(1),N);...
       linspace(colour1(2),colour2(2),N);...
       linspace(colour1(3),colour2(3),N)]'; 
    A=flip(A);
end

