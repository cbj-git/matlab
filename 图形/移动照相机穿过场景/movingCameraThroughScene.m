%% 移动照相机穿过场景
% 方法简介
% 
% 漫游是指移动照相机穿过三维空间而产生的一种效果，就好像把照相机放在飞机上，而您跟着照相机一起飞一样。您可以漫游场景中可能被其他对象挡住的区域，也可以通过将照相机定焦在特定点上从场景旁边漫游。
% 
% 要实现这些效果，可按照一系列步骤沿特定路线（例如沿 _x_ 轴）移动照相机。要生成漫游效果，请同时移动照相机位置和照相机目标。
% 
% 以下示例利用漫游效果查看在由风速向量场定义的三维体内绘制的等值面的内部。这些数据代表北美地区的气流。
% 
% 本示例使用了好几种可视化方法。它使用的方法有：
%% 
% * 使用等值面和圆锥图来说明通过三维体的气流
% * 使用光照照亮三维体内的等值面和圆锥体
% * 使用流线定义照相机穿过三维体的路线
% * 协调移动照相机位置、照相机目标和光源
%% 
% *绘制体数据*
% 
% 第一步是绘制等值面并使用圆锥图绘制气流。
% 
% 请参阅 <https://localhost:31515/static/help/matlab/ref/isosurface.html |isosurface|>、<https://localhost:31515/static/help/matlab/ref/isonormals.html 
% |isonormals|>、<https://localhost:31515/static/help/matlab/ref/reducepatch.html 
% |reducepatch|> 和 <https://localhost:31515/static/help/matlab/ref/coneplot.html 
% |coneplot|> 以了解如何使用这些命令的信息。
% 
% 在绘制圆锥图之前，将数据纵横比 (<https://localhost:31515/static/help/matlab/ref/daspect.html 
% |daspect|>) 设置为 |[1,1,1]| 可确保 MATLAB? 软件正确计算最终视图的圆锥体大小。

clear;clc;close all;
load wind
wind_speed = sqrt(u.^2 + v.^2 + w.^2);
figure
p = patch(isosurface(x,y,z,wind_speed,35));
isonormals(x,y,z,wind_speed,p)
p.FaceColor = [0.75,0.25,0.25];
p.EdgeColor = [0.6,0.4,0.4];

[f,vt] = reducepatch(isosurface(x,y,z,wind_speed,45),0.05); 
daspect([1,1,1]);
hcone = coneplot(x,y,z,u,v,w,vt(:,1),vt(:,2),vt(:,3),2);
hcone.FaceColor = 'blue';
hcone.EdgeColor = 'none';
%% 
% *设置视图*
% 
% 您需要定义查看参数，以确保正确显示场景：
%% 
% * 选择透视投影可提供照相机穿过等值面内部时的深度感 (<https://localhost:31515/static/help/matlab/ref/camproj.html 
% |camproj|>)。
% * 将照相机视角设置为固定值可防止 MATLAB 自动调整视角以包含整个场景以及放大所需量 (<https://localhost:31515/static/help/matlab/ref/camva.html 
% |camva|>)。

camproj perspective
camva(25)
%% 
% *指定光源*
% 
% 将光源定位在照相机位置并修改等值面和圆锥体的反射特性可增强场景的真实感：
%% 
% * 在照相机位置创建光源可提供“前灯”效果，与照相机一起在等值面内部移动 (<https://localhost:31515/static/help/matlab/ref/camlight.html 
% |camlight|>)。
% * 设置等值面的反射属性可产生高反射材料（<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-SpecularStrength 
% |SpecularStrength|> 和 <https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-DiffuseStrength 
% |DiffuseStrength|> 设置为 1）的黑暗内景效果（<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-AmbientStrength 
% |AmbientStrength|> 设置为 0.1）。
% * 将圆锥体的 |SpecularStrength| 设置为 1 可使它们具有高反射性。

hlight = camlight('headlight'); 
p.AmbientStrength = 1;
p.SpecularStrength = 1;
p.DiffuseStrength = 1;
hcone.SpecularStrength = 1;
set(gcf,'Color','k')
set(gca,'Color',[0,0,0.25])
%% 
% *选择光照方法*
% 
% 使用 |gouraud| 光照可获得更平滑的光照效果：

lighting gouraud
%% 
% 
% 
% *将照相机路径定义为流线*
% 
% 流线表示向量场中的流向。此示例使用单个流线的 _x_、_y_ 和 _z_ 坐标数据映射穿过三维体的路径。之后照相机将沿着这条路径移动。任务包括
%% 
% * 从点 |x = 80|、|y = 30|、|z = 11| 开始创建一条流线。
% * 获取流线的 _x_、_y_ 和 _z_ 坐标数据。
% * 删除流线（您也可以使用 <https://localhost:31515/static/help/matlab/ref/stream3.html 
% |stream3|> 计算流线数据，而不用实际绘制流线）。

hsline = streamline(x,y,z,u,v,w,80,30,11);
xd = hsline.XData;
yd = hsline.YData;
zd = hsline.ZData; 
delete(hsline)
%% 
% 
% 
% *实现漫游*
% 
% 要产生漫游效果，请沿相同路径移动照相机位置和照相机目标。在此示例中，照相机目标放置在 _x_ 轴上远离照相机五个元素的位置。在照相机目标 x 位置数据上加上一个较小的数值，以防在出现 
% |xd(n) = xd(n+5)| 的情况时照相机和目标的位置在同一点：
%% 
% * 更新照相机位置和照相机目标，使它们都沿着流线的坐标移动。
% * 与照相机一起移动光源。
% * 调用 <https://localhost:31515/static/help/matlab/ref/drawnow.html |drawnow|> 
% 以显示每次移动的结果。

for i=1:length(xd)-5
   campos([xd(i),yd(i),zd(i)])
   camtarget([xd(i+5)+min(xd)/500,yd(i),zd(i)])
   camlight(hlight,'headlight')
   drawnow
end 
%% 
% 要创建相同数据的固定可视化绘图，请参阅 <https://localhost:31515/static/help/matlab/ref/coneplot.html 
% |coneplot|>。