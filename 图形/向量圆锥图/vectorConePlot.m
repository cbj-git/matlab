%% 利用圆锥图显示向量场
% 圆锥图可以显示哪些信息
% 
% 本示例绘制 |wind| 数据的速度向量圆锥图。生成的圆锥图利用了好几种可视化方法：
%% 
% * 通过等值面为圆锥图提供视觉环境，并提供为一组圆锥体选择特定数据值的方法。
% * 通过光照使等值面的形状清晰可见。
% * 通过透视投影、照相机定位和视角调整合成最终视图。
%% 
% *1.创建等值面*
% 
% 在矩形数据空间显示等值面可为圆锥图提供视觉环境。创建等值面需要多个步骤：
%% 
% # 计算代表风速的向量场的模。
% # 使用 <https://localhost:31515/static/help/matlab/ref/isosurface.html |isosurface|> 
% 和 <https://localhost:31515/static/help/matlab/ref/patch.html |patch|> 绘制等值面，以说明矩形空间中哪些位置的风速等于特定值。等值面内的区域风速较高，等值面外的区域风速较低。
% # 使用 <https://localhost:31515/static/help/matlab/ref/isonormals.html |isonormals|> 
% 根据体数据计算等值面的顶点法线，而不是根据用来渲染等值面的三角形来计算顶点法线。这样的法线通常可以生成更准确的结果。
% # 设置等值面的视觉属性，使其为红色并且不绘制边（|FaceColor|、|EdgeColor|）。

clear;clc;close all;
load wind
wind_speed = sqrt(u.^2 + v.^2 + w.^2);
hiso = patch(isosurface(x,y,z,wind_speed,40));
isonormals(x,y,z,wind_speed,hiso)
hiso.FaceColor = 'red';
hiso.EdgeColor = 'none';
%% 
% *2.为等值面添加等值顶*
% 
% 等值顶与切片平面的相似之处在于它们都显示体的横截面。它们被设计成等值面的端顶。在等值顶上使用插值面颜色将导致数据值映射到当前颜色图中的颜色。要为等值面创建等值顶，请按相同的等值定义它们（<https://localhost:31515/static/help/matlab/ref/isocaps.html 
% |isocaps|>、<https://localhost:31515/static/help/matlab/ref/patch.html |patch|>、<https://localhost:31515/static/help/matlab/ref/colormap.html 
% |colormap|>）。

hcap = patch(isocaps(x,y,z,wind_speed,40),...
   'FaceColor','interp',...
   'EdgeColor','none');
colormap hsv
%% 
% *3.创建第一组圆锥体*
%% 
% * 在调用 |coneplot| 之前，请使用 <https://localhost:31515/static/help/matlab/ref/daspect.html 
% |daspect|> 设置坐标区的数据纵横比，以便函数确定圆锥体的正确大小。
% * 通过计算具有较小等值的另一个等值面来确定放置圆锥体的点（使圆锥体显示在第一个等值面之外），并使用 <https://localhost:31515/static/help/matlab/ref/reducepatch.html 
% |reducepatch|> 减少面和顶点的数量（使图中的圆锥体不会过多）。
% * 绘制圆锥体，并将面颜色设置为 |blue|，将边颜色设置为 |none|。

daspect([1 1 1]);
[f,verts] = reducepatch(isosurface(x,y,z,wind_speed,30),0.07);
h1 = coneplot(x,y,z,u,v,w,verts(:,1),verts(:,2),verts(:,3),3);
h1.FaceColor = 'blue';
h1.EdgeColor = 'none';
%% 
% *4.创建第二组圆锥体*
%% 
% # 使用数据范围内的值创建第二组点（<https://localhost:31515/static/help/matlab/ref/linspace.html 
% |linspace|>、<https://localhost:31515/static/help/matlab/ref/meshgrid.html |meshgrid|>）。
% # 绘制第二组圆锥体，并将面颜色设置为 green，将边颜色设置为 none。

xrange = linspace(min(x(:)),max(x(:)),10);
yrange = linspace(min(y(:)),max(y(:)),10);
zrange = 3:4:15;
[cx,cy,cz] = meshgrid(xrange,yrange,zrange);
h2 = coneplot(x,y,z,u,v,w,cx,cy,cz,2);
h2.FaceColor = 'green';
h2.EdgeColor = 'none';
%% 
% *5.定义视图*
%% 
% # 使用 <https://localhost:31515/static/help/matlab/ref/axis.html |axis|> 命令将坐标轴范围设置为等于数据的最小值和最大值，并将图包含在框中以增强立体感 
% (<https://localhost:31515/static/help/matlab/ref/box.html |box|>)。
% # 将投影类型设置为透视，以生成更自然的体视图。设置视点并放大，以使场景变大（<https://localhost:31515/static/help/matlab/ref/camproj.html 
% |camproj|>、<https://localhost:31515/static/help/matlab/ref/camzoom.html |camzoom|>、<https://localhost:31515/static/help/matlab/ref/view.html 
% |view|>）。

axis tight
set(gca,'BoxStyle','full','Box','on')
camproj perspective
camzoom(1.25)
view(65,45)
%% 
% *6.添加光照*
% 
% 添加光源并使用 Gouraud 光照，使等值面具有最平滑的光照效果。提高等值顶上的背景光强度，使等值顶更亮（<https://localhost:31515/static/help/matlab/ref/camlight.html 
% |camlight|>、<https://localhost:31515/static/help/matlab/ref/lighting.html |lighting|>、|AmbientStrength|）。

camlight(-45,45)
hcap.AmbientStrength = 0.6;
lighting gouraud