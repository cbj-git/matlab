%% 录制动画用于播放
% 这些示例演示如何录制可播放的动画。
%% 录制和播放影片
% 在循环中创建绘图系列并将每个绘图捕获为一帧。通过每次在循环中进行设置确保坐标轴范围为常量。将帧存储到 M 中。

clear;clc;close all;
M = repmat(getframe,16,1);
for k = 1:16
	plot(fft(eye(k+16)))
	axis([-1 1 -1 1])
	M(k) = getframe;
end
%% 
% 使用 movie 函数播放影片。

figure
movie(M,2)
%% 
% 为影片捕获整个图窗
% 
% 在图窗左侧包含一个滑块。通过将图窗指定为 getframe 函数的输入参数捕获整个图窗窗口。

figure
u = uicontrol('Style','slider','Position',[10 50 20 340],...
    'Min',1,'Max',16,'Value',1);
for k = 1:16
    plot(fft(eye(k+16)))
    axis([-1 1 -1 1])
    u.Value = k;
    M(k) = getframe(gcf);
end
%% 
% 播放影片五次。在当前坐标区中播放影片。创建一个新的图窗和坐标区来填充图窗窗口，从而让影片看上去像原始动画。

figure
axes('Position',[0 0 1 1])
movie(M,3)



%% Animating a Surface
% This example shows how to animate a surface. Specifically, this example animates 
% a spherical harmonic. Spherical harmonics are spherical versions of Fourier 
% series and can be used to model the free oscillations of the Earth.
%% Define the Spherical Grid
% Define a set of points on a spherical grid to calculate the harmonic.
%%
clear;clc;close all;
theta = 0:pi/40:pi;                   % polar angle
phi = 0:pi/20:2*pi;                   % azimuth angle

[phi,theta] = meshgrid(phi,theta);    % define the grid
%% Calculate the Spherical Harmonic
% Calculate the spherical harmonic with a degree of six, an order of one, and 
% an amplitude of 0.5 on the surface of a sphere with a radius equal to five. 
% Then, convert the values to Cartesian coordinates.
%%
degree = 6;
order = 1;
amplitude = 0.5;
radius = 5;

Ymn = legendre(degree,cos(theta(:,1)));
Ymn = Ymn(order+1,:)';
yy = Ymn;

for kk = 2: size(theta,1)
    yy = [yy Ymn];
end

yy = yy.*cos(order*phi);  

order = max(max(abs(yy)));
rho = radius + amplitude*yy/order;

r = rho.*sin(theta);    % convert to Cartesian coordinates
x = r.*cos(phi);
y = r.*sin(phi);
z = rho.*cos(theta);
%% Plot the Spherical Harmonic on the Surface of a Sphere
% Using the |surf| function, plot the spherical harmonic on the surface of the 
% sphere.
%%
figure
s = surf(x,y,z);

light               % add a light
lighting gouraud    % preferred lighting for a curved surface
axis equal off      % set axis equal and remove axis
view(40,30)         % set viewpoint
camzoom(1.5)        % zoom into scene
%% Animate the Surface
% To animate the surface, use a for loop to change the data in your plot. To 
% replace the surface data, set the |XData|, |YData|, and |ZData| properties of 
% the surface to new values. To control the speed of the animation, use |pause| 
% after updating the surface data.
%%
scale = [linspace(0,1,20) linspace(1,-1,40)];    % surface scaling (0 to 1 to -1)

for ii = 1:length(scale)
    
    rho = radius + scale(ii)*amplitude*yy/order;   
   
    r = rho.*sin(theta);
    x = r.*cos(phi);       
    y = r.*sin(phi);
    z = rho.*cos(theta);
    
    s.XData = x;    % replace surface x values
    s.YData = y;    % replace surface y values
    s.ZData = z;    % replace surface z values
    
    pause(0.05)     % pause to control animation speed
end
%% 
% Copyright 2014 The MathWorks, Inc.
