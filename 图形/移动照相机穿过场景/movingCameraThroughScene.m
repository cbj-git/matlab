%% �ƶ��������������
% �������
% 
% ������ָ�ƶ������������ά�ռ��������һ��Ч�����ͺ������������ڷɻ��ϣ��������������һ���һ�������������γ����п��ܱ���������ס������Ҳ����ͨ����������������ض����ϴӳ����Ա����Ρ�
% 
% Ҫʵ����ЩЧ�����ɰ���һϵ�в������ض�·�ߣ������� _x_ �ᣩ�ƶ��������Ҫ��������Ч������ͬʱ�ƶ������λ�ú������Ŀ�ꡣ
% 
% ����ʾ����������Ч���鿴���ɷ����������������ά���ڻ��Ƶĵ�ֵ����ڲ�����Щ���ݴ�����������������
% 
% ��ʾ��ʹ���˺ü��ֿ��ӻ���������ʹ�õķ����У�
%% 
% * ʹ�õ�ֵ���Բ׶ͼ��˵��ͨ����ά�������
% * ʹ�ù���������ά���ڵĵ�ֵ���Բ׶��
% * ʹ�����߶��������������ά���·��
% * Э���ƶ������λ�á������Ŀ��͹�Դ
%% 
% *����������*
% 
% ��һ���ǻ��Ƶ�ֵ�沢ʹ��Բ׶ͼ����������
% 
% ����� <https://localhost:31515/static/help/matlab/ref/isosurface.html |isosurface|>��<https://localhost:31515/static/help/matlab/ref/isonormals.html 
% |isonormals|>��<https://localhost:31515/static/help/matlab/ref/reducepatch.html 
% |reducepatch|> �� <https://localhost:31515/static/help/matlab/ref/coneplot.html 
% |coneplot|> ���˽����ʹ����Щ�������Ϣ��
% 
% �ڻ���Բ׶ͼ֮ǰ���������ݺ�� (<https://localhost:31515/static/help/matlab/ref/daspect.html 
% |daspect|>) ����Ϊ |[1,1,1]| ��ȷ�� MATLAB? �����ȷ����������ͼ��Բ׶���С��

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
% *������ͼ*
% 
% ����Ҫ����鿴��������ȷ����ȷ��ʾ������
%% 
% * ѡ��͸��ͶӰ���ṩ�����������ֵ���ڲ�ʱ����ȸ� (<https://localhost:31515/static/help/matlab/ref/camproj.html 
% |camproj|>)��
% * ��������ӽ�����Ϊ�̶�ֵ�ɷ�ֹ MATLAB �Զ������ӽ��԰������������Լ��Ŵ������� (<https://localhost:31515/static/help/matlab/ref/camva.html 
% |camva|>)��

camproj perspective
camva(25)
%% 
% *ָ����Դ*
% 
% ����Դ��λ�������λ�ò��޸ĵ�ֵ���Բ׶��ķ������Կ���ǿ��������ʵ�У�
%% 
% * �������λ�ô�����Դ���ṩ��ǰ�ơ�Ч�����������һ���ڵ�ֵ���ڲ��ƶ� (<https://localhost:31515/static/help/matlab/ref/camlight.html 
% |camlight|>)��
% * ���õ�ֵ��ķ������Կɲ����߷�����ϣ�<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-SpecularStrength 
% |SpecularStrength|> �� <https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-DiffuseStrength 
% |DiffuseStrength|> ����Ϊ 1���ĺڰ��ھ�Ч����<https://localhost:31515/static/help/matlab/ref/matlab.graphics.primitive.patch-properties.html#buduav0-1_sep_shared-AmbientStrength 
% |AmbientStrength|> ����Ϊ 0.1����
% * ��Բ׶��� |SpecularStrength| ����Ϊ 1 ��ʹ���Ǿ��и߷����ԡ�

hlight = camlight('headlight'); 
p.AmbientStrength = 1;
p.SpecularStrength = 1;
p.DiffuseStrength = 1;
hcone.SpecularStrength = 1;
set(gcf,'Color','k')
set(gca,'Color',[0,0,0.25])
%% 
% *ѡ����շ���*
% 
% ʹ�� |gouraud| ���տɻ�ø�ƽ���Ĺ���Ч����

lighting gouraud
%% 
% 
% 
% *�������·������Ϊ����*
% 
% ���߱�ʾ�������е����򡣴�ʾ��ʹ�õ������ߵ� _x_��_y_ �� _z_ ��������ӳ�䴩����ά���·����֮�����������������·���ƶ����������
%% 
% * �ӵ� |x = 80|��|y = 30|��|z = 11| ��ʼ����һ�����ߡ�
% * ��ȡ���ߵ� _x_��_y_ �� _z_ �������ݡ�
% * ɾ�����ߣ���Ҳ����ʹ�� <https://localhost:31515/static/help/matlab/ref/stream3.html 
% |stream3|> �����������ݣ�������ʵ�ʻ������ߣ���

hsline = streamline(x,y,z,u,v,w,80,30,11);
xd = hsline.XData;
yd = hsline.YData;
zd = hsline.ZData; 
delete(hsline)
%% 
% 
% 
% *ʵ������*
% 
% Ҫ��������Ч����������ͬ·���ƶ������λ�ú������Ŀ�ꡣ�ڴ�ʾ���У������Ŀ������� _x_ ����Զ����������Ԫ�ص�λ�á��������Ŀ�� x λ�������ϼ���һ����С����ֵ���Է��ڳ��� 
% |xd(n) = xd(n+5)| �����ʱ�������Ŀ���λ����ͬһ�㣺
%% 
% * ���������λ�ú������Ŀ�꣬ʹ���Ƕ��������ߵ������ƶ���
% * �������һ���ƶ���Դ��
% * ���� <https://localhost:31515/static/help/matlab/ref/drawnow.html |drawnow|> 
% ����ʾÿ���ƶ��Ľ����

for i=1:length(xd)-5
   campos([xd(i),yd(i),zd(i)])
   camtarget([xd(i+5)+min(xd)/500,yd(i),zd(i)])
   camlight(hlight,'headlight')
   drawnow
end 
%% 
% Ҫ������ͬ���ݵĹ̶����ӻ���ͼ������� <https://localhost:31515/static/help/matlab/ref/coneplot.html 
% |coneplot|>��