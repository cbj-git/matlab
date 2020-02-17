%% 
% *粒子动画可以显示哪些信息*
% 
% 流粒子动画可用于可视化向量场的流向和速度。“粒子”（由线标记表示）用于跟踪沿特定流线的流动。动画中每个粒子的速度与流线上任何给定点处的向量场的模成正比。
% 
% *1.指定数据范围的起点*
% 
% 本示例通过指定适当的起点来确定要绘制的体区域。在本例中，流线图的起点为 x = 100，y 方向上的范围为 20 到 50，并位于 z = 5 的平面上，这并不是完整的体范围。

clear;clc;close all;
load wind
[sx, sy, sz] = meshgrid(100,20:2:50,5);
%% 
% *2.创建流线以指示粒子路径*
% 
% 本示例使用流线（<https://localhost:31515/static/help/matlab/ref/stream3.html |stream3|>、<https://localhost:31515/static/help/matlab/ref/streamline.html 
% |streamline|>）跟踪动画粒子的路径，为动画添加视觉环境。

verts = stream3(x,y,z,u,v,w,sx,sy,sz);
sl = streamline(verts);
%% 
% *3.定义视图*
% 
% 虽然所有流线都开始于 z = 5 的平面，但某些螺旋线的值更低。以下设置提供了清晰的动画视图：
%% 
% * 选择的视点 (<https://localhost:31515/static/help/matlab/ref/view.html |view|>) 
% 既能显示包含大部分流线的平面，又能显示螺旋线。
% * 将数据的纵横比 (<https://localhost:31515/static/help/matlab/ref/daspect.html |daspect|>) 
% 设为 |[2 2 0.125]| 可在 _z_ 方向提供更高的分辨率，使螺旋线中的流粒子更容易看清。
% * 将坐标区范围设置为与数据范围匹配 (<https://localhost:31515/static/help/matlab/ref/axis.html 
% |axis|>)，然后绘制轴框 (<https://localhost:31515/static/help/matlab/ref/box.html |box|>)。

view(-10.5,18)
daspect([2 2 0.125])
axis tight;
set(gca,'BoxStyle','full','Box','on')
%% 
% 
% 
% *4.计算流粒子顶点*
% 
% 确定流线上要绘制粒子的顶点。<https://localhost:31515/static/help/matlab/ref/interpstreamspeed.html 
% |interpstreamspeed|> 函数基于流线顶点和向量数据的速度返回此数据。本示例将速度缩放 0.05，以增加插值顶点的数量。
% 
% 将坐标区的 |SortMethod| 属性设置为 |childorder|，使动画运行速度更快。
% 
% |streamparticles| 函数设置以下属性：
%% 
% * 将 |Animate| 设置为 |10|，使动画运行 10 次。
% * 将 |ParticleAlignment| 设置为 |on|，以便同时开始所有粒子跟踪。
% * 将 |MarkerEdgeColor| 设置为 |none|，以便只绘制圆形标记的面。如果不绘制标记的边，动画通常会运行得更快。
% * 将 |MarkerFaceColor| 设置为 |red|。
% * 将 |Marker| 设置为 |o|，以绘制圆形标记。您也可以使用其他线标记。

iverts = interpstreamspeed(x,y,z,u,v,w,verts,0.01);
set(gca,'SortMethod','childorder');
streamparticles(iverts,15,...
	'Animate',2,...
	'ParticleAlignment','on',...
	'MarkerEdgeColor','none',...
	'MarkerFaceColor','red',...
	'Marker','o');