clear;clc;close all;
ax = axes;
a = peaks;
surf(ax,a,"EdgeColor","none");
axis vis3d off;
box off;
set(ax,'CameraViewAngleMode','manual');
camva(ax,10);

cpos = get(ax,'CameraPosition');
ctarg  = get(ax,'CameraTarget');
for ii = [.1:1e-4:1 1:-1e-4:.1]
    movecamera(ax,cpos,ctarg,ii);
end
orbit(ax,360);
%%
function movecamera(ax,cpos,ctarg,dist) %dist in the range [-1 1]
set(ax,'CameraViewAngleMode','manual');
newcp = cpos - dist * (cpos - ctarg);
set(ax,'CameraPosition',newcp);
drawnow limitrate;
end

function orbit(ax,deg)
[az, el] = view(ax);
rotvec = 0:deg/1e4:deg;
for i = 1:length(rotvec)
    view(ax,[az+rotvec(i) el]);
    drawnow limitrate;
end
end