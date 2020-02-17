%% ���ж���������ͼ
%% ��1��������

clear;clc;close all;
x=0:0.1:2*pi;
y1 = x;
y2 = sin(x);
y3 = cos(x);
y4 = x.^0.5; % ͼ������
ax1 = axes('Position',[0.2 0.1 0.6 0.6]); % ������1�������ᣬ������ʼλ�óߴ�
xlabel('X');
title('Y1, Y2, Y3, Y4��X');
yyaxis left; % ��y��
line(ax1, x,y1);
ylabel('Y1');
yyaxis right; % ��y��
line(ax1, x,y2);
ylabel('Y2');
%% ��2��������

ax2 = axes('Position',[0.1 0.1 0.01 0.6], 'XColor','m', 'YColor','m',...
    'FontSize',10); % ������2�������ᣬ������ʼλ�óߴ磬X���y����ɫ�������С��y��̶�
% ax2.YAxis.TickDirection = 'in';
line(ax1, x,y3, 'Color','m');
ylabel('Y3');
%% ��3��������

ax3 = axes('Position',[0.9 0.1 0.01 0.6], 'XColor','c', 'YColor','c',...
    'FontSize',10, 'YAxisLocation','right'); % ������2�������ᣬ������ʼλ�óߴ磬X���y����ɫ�������С��y��̶�
% ax3.YAxis.TickDirection = 'out';
line(ax1, x,y4, 'Color','c');
ylabel('Y4');
legend(ax1,{'Y1','Y2','Y3','Y4'},'Location','north','NumColumns',4);