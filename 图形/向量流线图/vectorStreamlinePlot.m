%% �������ݵ�����ͼ
% ���ӳ������
% 
% MATLAB? �������ݼ� |wind| ��������������������ʾ�����ʹ���˼��ַ�����
%% 
% * �������߸��ٷ���
% * ������Ƭƽ����ʾ���ݵĺ������ͼ
% * ������Ƭƽ���ϵĵȸ��������Ƭƽ����ɫ�Ŀɼ���
%% 
% *1.ȷ������ķ�Χ*
% 
% �������ݲ�ȷ��������λ��Ƭƽ��͵ȸ���ͼ����Сֵ�����ֵ��<https://localhost:31515/static/help/matlab/ref/load.html 
% |load|>��<https://localhost:31515/static/help/matlab/ref/min.html |min|>��<https://localhost:31515/static/help/matlab/ref/max.html 
% |max|>����

clear;clc;close all;
load wind
xmin = min(x(:));
xmax = max(x(:));
ymax = max(y(:));
zmin = min(z(:));
%% 
% *2.�����Ƭƽ�����ṩ�Ӿ�����*
% 
% ������������ģ��������٣������������� <https://localhost:31515/static/help/matlab/ref/slice.html 
% |slice|> ����ı������ݡ��� _x_ ���� |xmin|��|100| �� |xmax| ������ _y_ ���� |ymax| ���Լ��� _z_ ���� 
% |zmin| ��������Ƭƽ�档ָ����ֵ����ɫ��ʹ��Ƭ��ɫָʾ���٣��������Ʊߣ�<https://localhost:31515/static/help/matlab/ref/sqrt.html 
% |sqrt|>��<https://localhost:31515/static/help/matlab/ref/slice.html |slice|>��<https://localhost:31515/static/help/matlab/ref/matlab.graphics.chart.primitive.surface-properties.html#buch_5e_sep_shared-FaceColor 
% |FaceColor|>��<https://localhost:31515/static/help/matlab/ref/matlab.graphics.chart.primitive.surface-properties.html#buch_5e_sep_shared-EdgeColor 
% |EdgeColor|>����

wind_speed = sqrt(u.^2 + v.^2 + w.^2);
hsurfaces = slice(x,y,z,wind_speed,[xmin,100,xmax],ymax,zmin);
set(hsurfaces,'FaceColor','interp','EdgeColor','none')
colormap jet
%% 
% *3.����Ƭƽ������ӵȸ���*
% 
% ����Ƭƽ���ϻ���ǳ��ɫ�ȸ����԰���������ɫӳ�䣨<https://localhost:31515/static/help/matlab/ref/contourslice.html 
% |contourslice|>��<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-EdgeColor 
% |EdgeColor|>��<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-LineWidth 
% |LineWidth|>����

hcont = ...
contourslice(x,y,z,wind_speed,[xmin,100,xmax],ymax,zmin);
set(hcont,'EdgeColor',[0.7 0.7 0.7],'LineWidth',0.5)
%% 
% *4.�������ߵ����*
% 
% �ڱ�ʾ���У��������߶��� _x_ ���ϵ�ֵ 80 ����ʼ���� _y_ �����ϵķ�ΧΪ 20 �� 50���� _z_ �����ϵķ�ΧΪ 0 �� 15���������ߵľ���������߿����ɫ��<https://localhost:31515/static/help/matlab/ref/meshgrid.html 
% |meshgrid|>��<https://localhost:31515/static/help/matlab/ref/streamline.html 
% |streamline|>��<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.line-properties.html#bubwptp-1_sep_shared-LineWidth 
% |LineWidth|>��<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.line-properties.html#bubwptp-1_sep_shared-Color 
% |Color|>����

[sx,sy,sz] = meshgrid(80,20:10:50,0:5:15);
hlines = streamline(x,y,z,u,v,w,sx,sy,sz);
set(hlines,'LineWidth',2,'Color','r')
%% 
% *5.������ͼ*
% 
% ������ͼ����չ _z_ ���Ա��ڹ۲�ͼ�Σ�<https://localhost:31515/static/help/matlab/ref/view.html 
% |view|>��<https://localhost:31515/static/help/matlab/ref/daspect.html |daspect|>��<https://localhost:31515/static/help/matlab/ref/axis.html 
% |axis|>����

view(3)
daspect([2,2,1])
axis tight
%% 
% �й�ʹ��Բ׶�������ͬ���ݵ�ʾ��������� <https://localhost:31515/static/help/matlab/ref/coneplot.html 
% |coneplot|>��