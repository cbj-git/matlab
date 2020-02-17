% “∆∂Ø’’œ‡ª˙
clear;clc;close all;
load cape;
image(X);
colormap(map);
axis image;
camva(camva/2.5);
while 1
  [x,y] = ginput(1);
  if ~strcmp(get(gcf,'SelectionType'),'normal')
    break
  end
  ct = camtarget;
  dx = x - ct(1);
  dy = y - ct(2);
  camdolly(dx,dy,ct(3),'movetarget','data')
  drawnow;
end