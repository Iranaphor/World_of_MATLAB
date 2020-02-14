function ax = supplot(W,H,X,Y,~)
    
    i = (X-1)/W;
    j = (Y-1)/H;
    
    ax = subplot('Position',[i,j,1/W,1/H]);
    
    if ~(nargin == 5)
        set(gcf,'menubar','none','NumberTitle','off');
    else
        set(gcf,'menubar','figure','NumberTitle','on');
    end
    
end