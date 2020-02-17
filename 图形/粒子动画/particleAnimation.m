%% 
% *���Ӷ���������ʾ��Щ��Ϣ*
% 
% �����Ӷ��������ڿ��ӻ���������������ٶȡ������ӡ������߱�Ǳ�ʾ�����ڸ������ض����ߵ�������������ÿ�����ӵ��ٶ����������κθ����㴦����������ģ�����ȡ�
% 
% *1.ָ�����ݷ�Χ�����*
% 
% ��ʾ��ͨ��ָ���ʵ��������ȷ��Ҫ���Ƶ��������ڱ����У�����ͼ�����Ϊ x = 100��y �����ϵķ�ΧΪ 20 �� 50����λ�� z = 5 ��ƽ���ϣ��Ⲣ�����������巶Χ��

clear;clc;close all;
load wind
[sx, sy, sz] = meshgrid(100,20:2:50,5);
%% 
% *2.����������ָʾ����·��*
% 
% ��ʾ��ʹ�����ߣ�<https://localhost:31515/static/help/matlab/ref/stream3.html |stream3|>��<https://localhost:31515/static/help/matlab/ref/streamline.html 
% |streamline|>�����ٶ������ӵ�·����Ϊ��������Ӿ�������

verts = stream3(x,y,z,u,v,w,sx,sy,sz);
sl = streamline(verts);
%% 
% *3.������ͼ*
% 
% ��Ȼ�������߶���ʼ�� z = 5 ��ƽ�棬��ĳЩ�����ߵ�ֵ���͡����������ṩ�������Ķ�����ͼ��
%% 
% * ѡ����ӵ� (<https://localhost:31515/static/help/matlab/ref/view.html |view|>) 
% ������ʾ�����󲿷����ߵ�ƽ�棬������ʾ�����ߡ�
% * �����ݵ��ݺ�� (<https://localhost:31515/static/help/matlab/ref/daspect.html |daspect|>) 
% ��Ϊ |[2 2 0.125]| ���� _z_ �����ṩ���ߵķֱ��ʣ�ʹ�������е������Ӹ����׿��塣
% * ����������Χ����Ϊ�����ݷ�Χƥ�� (<https://localhost:31515/static/help/matlab/ref/axis.html 
% |axis|>)��Ȼ�������� (<https://localhost:31515/static/help/matlab/ref/box.html |box|>)��

view(-10.5,18)
daspect([2 2 0.125])
axis tight;
set(gca,'BoxStyle','full','Box','on')
%% 
% 
% 
% *4.���������Ӷ���*
% 
% ȷ��������Ҫ�������ӵĶ��㡣<https://localhost:31515/static/help/matlab/ref/interpstreamspeed.html 
% |interpstreamspeed|> �����������߶�����������ݵ��ٶȷ��ش����ݡ���ʾ�����ٶ����� 0.05�������Ӳ�ֵ�����������
% 
% ���������� |SortMethod| ��������Ϊ |childorder|��ʹ���������ٶȸ��졣
% 
% |streamparticles| ���������������ԣ�
%% 
% * �� |Animate| ����Ϊ |10|��ʹ�������� 10 �Ρ�
% * �� |ParticleAlignment| ����Ϊ |on|���Ա�ͬʱ��ʼ�������Ӹ��١�
% * �� |MarkerEdgeColor| ����Ϊ |none|���Ա�ֻ����Բ�α�ǵ��档��������Ʊ�ǵıߣ�����ͨ�������еø��졣
% * �� |MarkerFaceColor| ����Ϊ |red|��
% * �� |Marker| ����Ϊ |o|���Ի���Բ�α�ǡ���Ҳ����ʹ�������߱�ǡ�

iverts = interpstreamspeed(x,y,z,u,v,w,verts,0.01);
set(gca,'SortMethod','childorder');
streamparticles(iverts,15,...
	'Animate',2,...
	'ParticleAlignment','on',...
	'MarkerEdgeColor','none',...
	'MarkerFaceColor','red',...
	'Marker','o');