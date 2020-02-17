%% ����Բ׶ͼ��ʾ������
% Բ׶ͼ������ʾ��Щ��Ϣ
% 
% ��ʾ������ |wind| ���ݵ��ٶ�����Բ׶ͼ�����ɵ�Բ׶ͼ�����˺ü��ֿ��ӻ�������
%% 
% * ͨ����ֵ��ΪԲ׶ͼ�ṩ�Ӿ����������ṩΪһ��Բ׶��ѡ���ض�����ֵ�ķ�����
% * ͨ������ʹ��ֵ�����״�����ɼ���
% * ͨ��͸��ͶӰ���������λ���ӽǵ����ϳ�������ͼ��
%% 
% *1.������ֵ��*
% 
% �ھ������ݿռ���ʾ��ֵ���ΪԲ׶ͼ�ṩ�Ӿ�������������ֵ����Ҫ������裺
%% 
% # ���������ٵ���������ģ��
% # ʹ�� <https://localhost:31515/static/help/matlab/ref/isosurface.html |isosurface|> 
% �� <https://localhost:31515/static/help/matlab/ref/patch.html |patch|> ���Ƶ�ֵ�棬��˵�����οռ�����Щλ�õķ��ٵ����ض�ֵ����ֵ���ڵ�������ٽϸߣ���ֵ�����������ٽϵ͡�
% # ʹ�� <https://localhost:31515/static/help/matlab/ref/isonormals.html |isonormals|> 
% ���������ݼ����ֵ��Ķ��㷨�ߣ������Ǹ���������Ⱦ��ֵ��������������㶥�㷨�ߡ������ķ���ͨ���������ɸ�׼ȷ�Ľ����
% # ���õ�ֵ����Ӿ����ԣ�ʹ��Ϊ��ɫ���Ҳ����Ʊߣ�|FaceColor|��|EdgeColor|����

clear;clc;close all;
load wind
wind_speed = sqrt(u.^2 + v.^2 + w.^2);
hiso = patch(isosurface(x,y,z,wind_speed,40));
isonormals(x,y,z,wind_speed,hiso)
hiso.FaceColor = 'red';
hiso.EdgeColor = 'none';
%% 
% *2.Ϊ��ֵ����ӵ�ֵ��*
% 
% ��ֵ������Ƭƽ�������֮���������Ƕ���ʾ��ĺ���档���Ǳ���Ƴɵ�ֵ��Ķ˶����ڵ�ֵ����ʹ�ò�ֵ����ɫ����������ֵӳ�䵽��ǰ��ɫͼ�е���ɫ��ҪΪ��ֵ�洴����ֵ�����밴��ͬ�ĵ�ֵ�������ǣ�<https://localhost:31515/static/help/matlab/ref/isocaps.html 
% |isocaps|>��<https://localhost:31515/static/help/matlab/ref/patch.html |patch|>��<https://localhost:31515/static/help/matlab/ref/colormap.html 
% |colormap|>����

hcap = patch(isocaps(x,y,z,wind_speed,40),...
   'FaceColor','interp',...
   'EdgeColor','none');
colormap hsv
%% 
% *3.������һ��Բ׶��*
%% 
% * �ڵ��� |coneplot| ֮ǰ����ʹ�� <https://localhost:31515/static/help/matlab/ref/daspect.html 
% |daspect|> �����������������ݺ�ȣ��Ա㺯��ȷ��Բ׶�����ȷ��С��
% * ͨ��������н�С��ֵ����һ����ֵ����ȷ������Բ׶��ĵ㣨ʹԲ׶����ʾ�ڵ�һ����ֵ��֮�⣩����ʹ�� <https://localhost:31515/static/help/matlab/ref/reducepatch.html 
% |reducepatch|> ������Ͷ����������ʹͼ�е�Բ׶�岻����ࣩ��
% * ����Բ׶�壬��������ɫ����Ϊ |blue|��������ɫ����Ϊ |none|��

daspect([1 1 1]);
[f,verts] = reducepatch(isosurface(x,y,z,wind_speed,30),0.07);
h1 = coneplot(x,y,z,u,v,w,verts(:,1),verts(:,2),verts(:,3),3);
h1.FaceColor = 'blue';
h1.EdgeColor = 'none';
%% 
% *4.�����ڶ���Բ׶��*
%% 
% # ʹ�����ݷ�Χ�ڵ�ֵ�����ڶ���㣨<https://localhost:31515/static/help/matlab/ref/linspace.html 
% |linspace|>��<https://localhost:31515/static/help/matlab/ref/meshgrid.html |meshgrid|>����
% # ���Ƶڶ���Բ׶�壬��������ɫ����Ϊ green��������ɫ����Ϊ none��

xrange = linspace(min(x(:)),max(x(:)),10);
yrange = linspace(min(y(:)),max(y(:)),10);
zrange = 3:4:15;
[cx,cy,cz] = meshgrid(xrange,yrange,zrange);
h2 = coneplot(x,y,z,u,v,w,cx,cy,cz,2);
h2.FaceColor = 'green';
h2.EdgeColor = 'none';
%% 
% *5.������ͼ*
%% 
% # ʹ�� <https://localhost:31515/static/help/matlab/ref/axis.html |axis|> ��������᷶Χ����Ϊ�������ݵ���Сֵ�����ֵ������ͼ�����ڿ�������ǿ����� 
% (<https://localhost:31515/static/help/matlab/ref/box.html |box|>)��
% # ��ͶӰ��������Ϊ͸�ӣ������ɸ���Ȼ������ͼ�������ӵ㲢�Ŵ���ʹ�������<https://localhost:31515/static/help/matlab/ref/camproj.html 
% |camproj|>��<https://localhost:31515/static/help/matlab/ref/camzoom.html |camzoom|>��<https://localhost:31515/static/help/matlab/ref/view.html 
% |view|>����

axis tight
set(gca,'BoxStyle','full','Box','on')
camproj perspective
camzoom(1.25)
view(65,45)
%% 
% *6.��ӹ���*
% 
% ��ӹ�Դ��ʹ�� Gouraud ���գ�ʹ��ֵ�������ƽ���Ĺ���Ч������ߵ�ֵ���ϵı�����ǿ�ȣ�ʹ��ֵ��������<https://localhost:31515/static/help/matlab/ref/camlight.html 
% |camlight|>��<https://localhost:31515/static/help/matlab/ref/lighting.html |lighting|>��|AmbientStrength|����

camlight(-45,45)
hcap.AmbientStrength = 0.6;
lighting gouraud