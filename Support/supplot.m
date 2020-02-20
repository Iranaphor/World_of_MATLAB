function ax = supplot(W,H,X,Y,~)
    %% SUPPLOT creates an axes handle which fills the screen
    %
    %  SUPPLOT(Width, Height, X, Y, ~) creates an axes with no
    %    whitespace between the axes and figure border at position
    %    X, Y
    %
    %  SUPPLOT(Width, Height, X, Y, 1) creates an axes with no
    %    whitespace between the axes and figure border at position
    %    X, Y with a menu.
    %
    %  @param W Width of the axes
    %  @param H Height of the axes
    %  @param X The X index of the axes
    %  @param Y The Y index of the axes
    %  @param ~ A blank value used to check if the axes should show
    %    the menubar or not.
    %  @return The axes handle.
    %
    %  Examples
    %    SUPPLOT(1, 1, 1, 1, '') fills the entire figure with the
    %      the axes object
    %
    %  @author Iranaphor
    %  @version 0.0.1
    %  @since 0.0.1

    i = (X-1)/W;
    j = (Y-1)/H;

    ax = subplot('Position',[i,j,1/W,1/H]);
    if ~(nargin == 5)
        set(gcf,'menubar','none','NumberTitle','off');
    else
        set(gcf,'menubar','figure','NumberTitle','on');
    end
end
