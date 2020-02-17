clear; clc; close all;
ax = axes;
axis(ax,"equal");
ax.XAxis.Visible = "off";
ax.YAxis.Visible = "off";
patch(ax, [0 8 8 0],[0 0 5 5],"g", "LineWidth",1);
text(ax, [2.5 8.5],[-0.3 2.1],"a", "FontSize",20);
d = 0.03;
w1L = [1.8:-d:0 0:d:4];
w2L = [5:d:7 7:-d:0];
L1 = numel(w1L);
L2 = numel(w2L);
h1 = patch(ax);
h2 = patch(ax);
for ii = 1:2*L1+L2
    delete([h1;h2]);
    if ii <= L1; w1 = w1L(ii); w2 = 5;
    elseif ii <= L1+L2; w1 = 1.8; w2 = w2L(ii-L1);
    else; w1 = w1L(ii-L1-L2); w2 = w2L(ii-L1-L2);
    end
    a = [-(1.8-w1)/8 1; 1 -(w2-2)/5]\[w1; 2];
    b = [-(1.8-w1)/8 1; 1 -(w2-2)/5]\[w1; 3];
    c = [-(1.8-w1)/8 1; 1 -(w2-2)/5]\[w1+1; 3];
    d = a + (c - b);
    x1 = [0  a(1) d(1) 0;    2 3 b(1) a(1); b(1) 8 8 c(1);     d(1) c(1) w2+1 w2]';
    y1 = [w1 a(2) d(2) w1+1; 0 0 b(2) a(2); b(2) 1.8 2.8 c(2); d(2) c(2) 5    5]';
    h1 = patch(ax, x1,y1,"m");
    
    S = det([a(1) a(2) 1; b(1) b(2) 1; c(1) c(2) 1]);
    txt = sprintf("S = %.3fÀåÃ×^2 (a = 1ÀåÃ×)", S);
    h2 = text(ax, [1 (a(1)+c(1))/2], [6 (a(2)+c(2))/2], [txt "S"], "FontSize",20);
    drawnow;   
end