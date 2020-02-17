%% 向量数据的流线图
% 风的映射数据
% 
% MATLAB? 向量数据集 |wind| 代表北美地区的气流。本示例结合使用了几种方法：
%% 
% * 利用流线跟踪风速
% * 利用切片平面显示数据的横截面视图
% * 利用切片平面上的等高线提高切片平面着色的可见性
%% 
% *1.确定坐标的范围*
% 
% 加载数据并确定用来定位切片平面和等高线图的最小值和最大值（<https://localhost:31515/static/help/matlab/ref/load.html 
% |load|>、<https://localhost:31515/static/help/matlab/ref/min.html |min|>、<https://localhost:31515/static/help/matlab/ref/max.html 
% |max|>）。

clear;clc;close all;
load wind
xmin = min(x(:));
xmax = max(x(:));
ymax = max(y(:));
zmin = min(z(:));
%% 
% *2.添加切片平面以提供视觉环境*
% 
% 计算向量场的模（代表风速），以生成用于 <https://localhost:31515/static/help/matlab/ref/slice.html 
% |slice|> 命令的标量数据。沿 _x_ 轴在 |xmin|、|100| 和 |xmax| 处、沿 _y_ 轴在 |ymax| 处以及沿 _z_ 轴在 
% |zmin| 处创建切片平面。指定插值面着色以使切片着色指示风速，但不绘制边（<https://localhost:31515/static/help/matlab/ref/sqrt.html 
% |sqrt|>、<https://localhost:31515/static/help/matlab/ref/slice.html |slice|>、<https://localhost:31515/static/help/matlab/ref/matlab.graphics.chart.primitive.surface-properties.html#buch_5e_sep_shared-FaceColor 
% |FaceColor|>、<https://localhost:31515/static/help/matlab/ref/matlab.graphics.chart.primitive.surface-properties.html#buch_5e_sep_shared-EdgeColor 
% |EdgeColor|>）。

wind_speed = sqrt(u.^2 + v.^2 + w.^2);
hsurfaces = slice(x,y,z,wind_speed,[xmin,100,xmax],ymax,zmin);
set(hsurfaces,'FaceColor','interp','EdgeColor','none')
colormap jet
%% 
% *3.在切片平面上添加等高线*
% 
% 在切片平面上绘制浅灰色等高线以帮助量化颜色映射（<https://localhost:31515/static/help/matlab/ref/contourslice.html 
% |contourslice|>、<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-EdgeColor 
% |EdgeColor|>、<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-LineWidth 
% |LineWidth|>）。

hcont = ...
contourslice(x,y,z,wind_speed,[xmin,100,xmax],ymax,zmin);
set(hcont,'EdgeColor',[0.7 0.7 0.7],'LineWidth',0.5)
%% 
% *4.定义流线的起点*
% 
% 在本示例中，所有流线都从 _x_ 轴上的值 80 处开始，在 _y_ 方向上的范围为 20 到 50，在 _z_ 方向上的范围为 0 到 15。保存流线的句柄并设置线宽和颜色（<https://localhost:31515/static/help/matlab/ref/meshgrid.html 
% |meshgrid|>、<https://localhost:31515/static/help/matlab/ref/streamline.html 
% |streamline|>、<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.line-properties.html#bubwptp-1_sep_shared-LineWidth 
% |LineWidth|>、<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.line-properties.html#bubwptp-1_sep_shared-Color 
% |Color|>）。

[sx,sy,sz] = meshgrid(80,20:10:50,0:5:15);
hlines = streamline(x,y,z,u,v,w,sx,sy,sz);
set(hlines,'LineWidth',2,'Color','r')
%% 
% *5.定义视图*
% 
% 设置视图，扩展 _z_ 轴以便于观察图形（<https://localhost:31515/static/help/matlab/ref/view.html 
% |view|>、<https://localhost:31515/static/help/matlab/ref/daspect.html |daspect|>、<https://localhost:31515/static/help/matlab/ref/axis.html 
% |axis|>）。

view(3)
daspect([2,2,1])
axis tight
%% 
% 有关使用圆锥体绘制相同数据的示例，请参阅 <https://localhost:31515/static/help/matlab/ref/coneplot.html 
% |coneplot|>。