%% Animate Graphics Object
% This example shows how to animate a triangle looping around the inside of 
% a circle by updating the data properties of the triangle.
% 
% Plot the circle and set the axis limits so that the data units are the 
% same in both directions.

clear;clc;close all;
theta = linspace(-pi,pi);
xc = cos(theta);
yc = -sin(theta);
plot(xc,yc);
axis equal
%% 
% Use the |area| function to draw a flat triangle. Then, change the value 
% of one of the triangle vertices using the (x,y) coordinates of the circle. Change 
% the value in a loop to create an animation. Use a <docid:matlab_ref.f56-719157 
% docid:matlab_ref.f56-719157> or |drawnow limitrate| command to display the updates 
% after each iteration. |drawnow limitrate| is fastest, but it might not draw 
% every frame on the screen.
%%
xt = [-1 0 1 -1];
yt = [0 0 0 0];
hold on
t = area(xt,yt); % initial flat triangle
hold off
for j = 1:length(theta)-10
    xt(2) = xc(j); % determine new vertex value
    yt(2) = yc(j); 
    t.XData = xt; % update data properties 
    t.YData = yt;
    drawnow % display updates
end
%% 
% The animation shows the triangle looping around the inside of the circle.
% 
% Copyright 2015 The MathWorks, Inc.



%% Transforming a Group of Objects
% This example shows how to create a 3-D star with a group of surface objects 
% parented to a single transform object. The transform object then rotates the 
% object about the z-axis while scaling its size.
% 
% Create an axes and adjust the view. Set the axes limits to prevent auto 
% limit selection during scaling.

newplot;
ax = axes('XLim',[-1.5 1.5],'YLim',[-1.5 1.5],'ZLim',[-1.5 1.5]);
view(3)
grid on
%% 
% Create the objects you want to parent to the transform object.
%%
[x,y,z] = cylinder([.2 0]);
h(1) = surface(x,y,z,'FaceColor','red');
h(2) = surface(x,y,-z,'FaceColor','green');
h(3) = surface(z,x,y,'FaceColor','blue');
h(4) = surface(-z,x,y,'FaceColor','cyan');
h(5) = surface(y,z,x,'FaceColor','magenta');
h(6) = surface(y,-z,x,'FaceColor','yellow');
%% 
% Create a transform object and parent the surface objects to it. Initialize 
% the rotation and scaling matrix to the identity matrix (eye).
%%
t = hgtransform('Parent',ax);
set(h,'Parent',t)

Rz = eye(4);
Sxy = Rz;
%% 
% Form the _z_-axis rotation matrix and the scaling matrix. Rotate group 
% and scale by using the increasing values of |r|.
%%
for r = 1:.1:2*pi
    % Z-axis rotation matrix
    Rz = makehgtform('zrotate',r);
    % Scaling matrix
    Sxy = makehgtform('scale',r/4);
    % Concatenate the transforms and
    % set the transform Matrix property
    set(t,'Matrix',Rz*Sxy)
    drawnow
end
pause(1)
%% 
% Reset to the original orientation and size using the identity matrix.
%%
set(t,'Matrix',eye(4))
%% 
% Copyright 2015 The MathWorks, Inc.



%% Transforming Objects Independently
% This example creates two transform objects to illustrate how to transform 
% each independently within the same axes. A translation transformation moves 
% one transform object away from the origin.
% 
% Create and set up the axes object that will be the parent of both transform 
% objects. Set the limits to accommodate the translated object.

newplot;
ax = axes('XLim',[-3 1],'YLim',[-3 1],'ZLim',[-1 1]);
view(3)
grid on
%% 
% Create the surface objects to group.
%%
[x,y,z] = cylinder([.3 0]);
h(1) = surface(x,y,z,'FaceColor','red');
h(2) = surface(x,y,-z,'FaceColor','green');
h(3) = surface(z,x,y,'FaceColor','blue');
h(4) = surface(-z,x,y,'FaceColor','cyan');
h(5) = surface(y,z,x,'FaceColor','magenta');
h(6) = surface(y,-z,x,'FaceColor','yellow');
%% 
% Create the transform objects and parent them to the same axes. Then, parent 
% the surfaces to transform t1. Copy the surface objects and parent the copies 
% to transform t2. This figure should not change.
%%
t1 = hgtransform('Parent',ax);
t2 = hgtransform('Parent',ax);

set(h,'Parent',t1)
h2 = copyobj(h,t2);
%% 
% Translate the second transform object away from the first transform object 
% and display the result.
%%
Txy = makehgtform('translate',[-1.5 -1.5 0]);
set(t2,'Matrix',Txy)
drawnow
%% 
% Rotate both transform objects in opposite directions. 
%%
% Rotate 10 times (2pi radians = 1 rotation)
for r = 1:.1:6*pi
    % Form z-axis rotation matrix
    Rz = makehgtform('zrotate',r);
    % Set transforms for both transform objects
    set(t1,'Matrix',Rz)
    set(t2,'Matrix',Txy*inv(Rz))
    drawnow
end
%% 
% Copyright 2015 The MathWorks, Inc.
