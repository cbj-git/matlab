%% 篮球投射
% 初始设置

close all;clear;clc;
g = 9.8; % 重力加速度
r1 = .5; % 篮球半径
r2 = .7; % 球筐半径
z2 = 3; % 球筐z高度
R = 7; % 三分线距离
figure('Position',[0 40 1550 750]);
axes('Projection','perspective');
view([100 15]); axis equal; grid on;
light; lighting gouraud;
cameratoolbar('SetMode', 'orbit');
xlabel('x'); ylabel('y'); zlabel('z');
axis([-R-1 R+1 -1 R+1 0 z2+R]);
%%
% 选择

opts.Resize = 'off';
% opts.WindowStyle = 'modal';
% opts.Interpreter = 'tex';
se = inputdlg({'是否保存动画(y或n, 分别代表是或否):', '出手点位置(m, 其中y>0, 如2个出手点[0 7 2; 3 4 2])', '速度(m/s, [v1 v2 ...]):',...
    '角度(\circ, 0~90, [th1 th2 ...])'}, '输入', ones(1,4), {'n', '[3 6 2; 7 0 2]', '[10 12]', '[60 70]'}, opts);
if isempty(se)
    disp('您已取消输入！');
    return
end
pos0 = evalin('base', se{2}); % 出手点位置集合
v0 = evalin('base', se{3}); % 出手点速度集合
thetaEle0 = evalin('base', se{4}); % 出手点仰角集合
num = numel(v0); % 出手点个数
% 输入检查
assert(num == numel(thetaEle0) && num == size(pos0, 1), '出手点位置, 速度和角度输入维度不一致！');
% 数组初始化
h = gobjects(num,3);
pos = cell(num,1);
posy = zeros(num,1);
thetaAzi = zeros(num,1);
vxy = zeros(num,1);
vz = zeros(num,1);
%%
% 静态图形对象

% 三分线
t1 = linspace(0, pi, 50);
x1 = R*cos(t1);
y1 = R*sin(t1);
line(x1, y1, zeros(1, numel(t1)), 'Color','b');
% 地板
x1 = xlim;
y1 = ylim;
patch([x1(1) x1(2) x1(2) x1(1)], [y1(1) y1(1) y1(2) y1(2)], [0 0 0 0],...
    [.9290 .6940 .1250], 'FaceAlpha',.5, 'EdgeColor','none');
% 球筐
t1 = linspace(0, 2*pi, 50);
x1 = r2*cos(t1);
y1 = r2*sin(t1);
ini1 = ones(1, numel(t1));
line(x1, y1, z2*ini1,  'Color','r', 'LineWidth',1);
text(0, 0, z2+.5, '球筐', 'HorizontalAlignment','right');
%%
% 动态图形对象

for ii = 1:num
    %%% 变换对象
    
    h(ii,1) = hgtransform; % 绕z轴旋转
    h(ii,2) = hgtransform('parent',h(ii,1)); % 位移
    h(ii,3) = hgtransform('parent',h(ii,2)); % 绕x轴旋转
    pos{ii} = pos0(ii,:); % 出手点位置
    thetaAzi(ii) = atand(pos{ii}(1) / pos{ii}(2)); % 出手点与y轴正方向夹角(正或负)
    vxy(ii) = v0(ii) * cosd(thetaEle0(ii)); % 出手点到篮筐方向速度的水平分量
    vz(ii) = v0(ii) * sind(thetaEle0(ii)); % 出手点速度的垂直分量
    posy(ii) = hypot(pos{ii}(1), pos{ii}(2)); % 出手点绕y轴旋转到y轴时y值
    %%% 空间图形对象
    
    % 球运行轨迹
    y1 = linspace(posy(ii), -1, 50);
    t2 = (posy(ii) - y1) / vxy(ii);
    z1 = vz(ii) * t2 - .5 * g * t2.^2 + pos{ii}(3);
    line(zeros(1, numel(y1)), y1, z1, 'Color','b', 'Linestyle','--', 'Parent',h(ii,1));
    % 篮球和人
    [x1, y1, z1] = sphere(50);
    line([pos{ii}(1) pos{ii}(1)], [pos{ii}(2) pos{ii}(2)], [0 pos{ii}(3)], 'Color','k', 'LineWidth',3, 'Marker','o', 'MarkerSize',5); % 人
    text(pos{ii}(1), pos{ii}(2), .5, '人');
    surf(r1*x1, r1*y1, r1*z1, 'EdgeColor','none', 'FaceColor',[.8500 .3250 .0980], 'Parent',h(ii,2));
    % 球纹路
    x1 = r1*cos(t1);
    y1 = r1*sin(t1);
    l1 = line(x1, y1, 0*ini1, 'Color','k', 'LineWidth',.5 , 'Parent',h(ii,3)); % 纹路1
    line(x1, 0*ini1, y1, 'Color','b', 'LineWidth',.5, 'Parent',h(ii,3)); % 纹路2
    tr = @(th) [1 0 0;0 cosd(th) -sind(th); 0 sind(th) cosd(th)]; % 绕x轴旋转th度
    co1 =  tr(-45) * [l1.XData; l1.YData; l1.ZData];
    line(co1(1,:), co1(2,:), co1(3,:), 'Color','m', 'LineWidth',.5 , 'Parent',h(ii,3)); % 纹路3
    co1 =  tr(45) * [l1.XData; l1.YData; l1.ZData];
    line(co1(1,:), co1(2,:), co1(3,:), 'Color','y', 'LineWidth',.5 , 'Parent',h(ii,3)); % 纹路4
end
%%
% 动画

% 保存动画
pause(1);
yes = strcmp(se{1}, 'y');
if yes
    aviobj=VideoWriter('basketball.avi', 'Motion JPEG AVI'); % 新建叫basketball.avi的文件
    open(aviobj); % 打开basketball.avi的文件
end
% 动画
for ii = 0:.02:max(posy)+1
    for jj = 1:num
        % 绕x轴旋转
        Trx = makehgtform('xrotate', -ii*pi);
        h(jj,3).Matrix = Trx;
        % 位移
        y1 = posy(jj) - ii;
        t1 = ii / vxy(jj);
        z1 = vz(jj) * t1 - .5 * g * t1.^2 + pos{jj}(3);
        Tm = makehgtform('translate', [0 y1 z1]);
        h(jj,2).Matrix = Tm;
        % 绕z轴旋转
        Trz = makehgtform('zrotate', -thetaAzi(jj)*pi/180);
        h(jj,1).Matrix = Trz;
    end
    drawnow;
    % 写入帧
    if yes
        writeVideo(aviobj, getframe(gcf));
    end
end
% 关闭
if yes
    close(aviobj);
    disp('保存成功！');
end