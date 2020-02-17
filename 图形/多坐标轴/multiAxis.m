%% 画有多个坐标轴的图
%% 第1个坐标轴

clear;clc;close all;
x=0:0.1:2*pi;
y1 = x;
y2 = sin(x);
y3 = cos(x);
y4 = x.^0.5; % 图形数据
ax1 = axes('Position',[0.2 0.1 0.6 0.6]); % 创建第1个坐标轴，包含初始位置尺寸
xlabel('X');
title('Y1, Y2, Y3, Y4和X');
yyaxis left; % 左y轴
line(ax1, x,y1);
ylabel('Y1');
yyaxis right; % 右y轴
line(ax1, x,y2);
ylabel('Y2');
%% 第2个坐标轴

ax2 = axes('Position',[0.1 0.1 0.01 0.6], 'XColor','m', 'YColor','m',...
    'FontSize',10); % 创建第2个坐标轴，包含初始位置尺寸，X轴和y轴颜色，字体大小，y轴刻度
% ax2.YAxis.TickDirection = 'in';
line(ax1, x,y3, 'Color','m');
ylabel('Y3');
%% 第3个坐标轴

ax3 = axes('Position',[0.9 0.1 0.01 0.6], 'XColor','c', 'YColor','c',...
    'FontSize',10, 'YAxisLocation','right'); % 创建第2个坐标轴，包含初始位置尺寸，X轴和y轴颜色，字体大小，y轴刻度
% ax3.YAxis.TickDirection = 'out';
line(ax1, x,y4, 'Color','c');
ylabel('Y4');
legend(ax1,{'Y1','Y2','Y3','Y4'},'Location','north','NumColumns',4);