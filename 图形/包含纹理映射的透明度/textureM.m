%% 
% 包含纹理映射的透明度
% 
% 纹理映射将二维图像映射到三维曲面上。通过将 |CData| 属性设置为图像数据并将 |FaceColor| 属性设置为 |'texturemap'|，可将图像映射到曲面上。
% 
% 此示例创建地球和云的三维视图。它创建球形表面，并使用纹理映射将地球和云的图像映射到曲面上。

clear;clc;close all;
earth = imread('landOcean.jpg');
clouds = imread('cloudCombined.jpg');
[px,py,pz] = sphere(50);                % generate coordinates for a 50 x 50 sphere

cla
sEarth = surface(py, px ,flip(pz));   
sEarth.FaceColor = 'texturemap';        % set color to texture mapping
sEarth.EdgeColor = 'none';              % remove surface edge color
sEarth.CData = earth;                   % set color data 

hold on
sCloud = surface(px*1.02,py*1.02,flip(pz)*1.02); 

sCloud.FaceColor = 'texturemap';        % set color to texture mapping
sCloud.EdgeColor = 'none';              % remove surface edge color
sCloud.CData = clouds;                  % set color data 

sCloud.FaceAlpha = 'texturemap';        % set transparency to texture mapping
sCloud.AlphaData = max(clouds,[],3);    % set transparency data 
hold off

view([80 2])                            % specify viewpoint 
daspect([1 1 1])                        % set aspect ratio
axis off tight                          % remove axis and set limits to data range