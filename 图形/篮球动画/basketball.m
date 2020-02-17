%% ����Ͷ��
% ��ʼ����

close all;clear;clc;
g = 9.8; % �������ٶ�
r1 = .5; % ����뾶
r2 = .7; % ���뾶
z2 = 3; % ���z�߶�
R = 7; % �����߾���
figure('Position',[0 40 1550 750]);
axes('Projection','perspective');
view([100 15]); axis equal; grid on;
light; lighting gouraud;
cameratoolbar('SetMode', 'orbit');
xlabel('x'); ylabel('y'); zlabel('z');
axis([-R-1 R+1 -1 R+1 0 z2+R]);
%%
% ѡ��

opts.Resize = 'off';
% opts.WindowStyle = 'modal';
% opts.Interpreter = 'tex';
se = inputdlg({'�Ƿ񱣴涯��(y��n, �ֱ�����ǻ��):', '���ֵ�λ��(m, ����y>0, ��2�����ֵ�[0 7 2; 3 4 2])', '�ٶ�(m/s, [v1 v2 ...]):',...
    '�Ƕ�(\circ, 0~90, [th1 th2 ...])'}, '����', ones(1,4), {'n', '[3 6 2; 7 0 2]', '[10 12]', '[60 70]'}, opts);
if isempty(se)
    disp('����ȡ�����룡');
    return
end
pos0 = evalin('base', se{2}); % ���ֵ�λ�ü���
v0 = evalin('base', se{3}); % ���ֵ��ٶȼ���
thetaEle0 = evalin('base', se{4}); % ���ֵ����Ǽ���
num = numel(v0); % ���ֵ����
% ������
assert(num == numel(thetaEle0) && num == size(pos0, 1), '���ֵ�λ��, �ٶȺͽǶ�����ά�Ȳ�һ�£�');
% �����ʼ��
h = gobjects(num,3);
pos = cell(num,1);
posy = zeros(num,1);
thetaAzi = zeros(num,1);
vxy = zeros(num,1);
vz = zeros(num,1);
%%
% ��̬ͼ�ζ���

% ������
t1 = linspace(0, pi, 50);
x1 = R*cos(t1);
y1 = R*sin(t1);
line(x1, y1, zeros(1, numel(t1)), 'Color','b');
% �ذ�
x1 = xlim;
y1 = ylim;
patch([x1(1) x1(2) x1(2) x1(1)], [y1(1) y1(1) y1(2) y1(2)], [0 0 0 0],...
    [.9290 .6940 .1250], 'FaceAlpha',.5, 'EdgeColor','none');
% ���
t1 = linspace(0, 2*pi, 50);
x1 = r2*cos(t1);
y1 = r2*sin(t1);
ini1 = ones(1, numel(t1));
line(x1, y1, z2*ini1,  'Color','r', 'LineWidth',1);
text(0, 0, z2+.5, '���', 'HorizontalAlignment','right');
%%
% ��̬ͼ�ζ���

for ii = 1:num
    %%% �任����
    
    h(ii,1) = hgtransform; % ��z����ת
    h(ii,2) = hgtransform('parent',h(ii,1)); % λ��
    h(ii,3) = hgtransform('parent',h(ii,2)); % ��x����ת
    pos{ii} = pos0(ii,:); % ���ֵ�λ��
    thetaAzi(ii) = atand(pos{ii}(1) / pos{ii}(2)); % ���ֵ���y��������н�(����)
    vxy(ii) = v0(ii) * cosd(thetaEle0(ii)); % ���ֵ㵽�������ٶȵ�ˮƽ����
    vz(ii) = v0(ii) * sind(thetaEle0(ii)); % ���ֵ��ٶȵĴ�ֱ����
    posy(ii) = hypot(pos{ii}(1), pos{ii}(2)); % ���ֵ���y����ת��y��ʱyֵ
    %%% �ռ�ͼ�ζ���
    
    % �����й켣
    y1 = linspace(posy(ii), -1, 50);
    t2 = (posy(ii) - y1) / vxy(ii);
    z1 = vz(ii) * t2 - .5 * g * t2.^2 + pos{ii}(3);
    line(zeros(1, numel(y1)), y1, z1, 'Color','b', 'Linestyle','--', 'Parent',h(ii,1));
    % �������
    [x1, y1, z1] = sphere(50);
    line([pos{ii}(1) pos{ii}(1)], [pos{ii}(2) pos{ii}(2)], [0 pos{ii}(3)], 'Color','k', 'LineWidth',3, 'Marker','o', 'MarkerSize',5); % ��
    text(pos{ii}(1), pos{ii}(2), .5, '��');
    surf(r1*x1, r1*y1, r1*z1, 'EdgeColor','none', 'FaceColor',[.8500 .3250 .0980], 'Parent',h(ii,2));
    % ����·
    x1 = r1*cos(t1);
    y1 = r1*sin(t1);
    l1 = line(x1, y1, 0*ini1, 'Color','k', 'LineWidth',.5 , 'Parent',h(ii,3)); % ��·1
    line(x1, 0*ini1, y1, 'Color','b', 'LineWidth',.5, 'Parent',h(ii,3)); % ��·2
    tr = @(th) [1 0 0;0 cosd(th) -sind(th); 0 sind(th) cosd(th)]; % ��x����תth��
    co1 =  tr(-45) * [l1.XData; l1.YData; l1.ZData];
    line(co1(1,:), co1(2,:), co1(3,:), 'Color','m', 'LineWidth',.5 , 'Parent',h(ii,3)); % ��·3
    co1 =  tr(45) * [l1.XData; l1.YData; l1.ZData];
    line(co1(1,:), co1(2,:), co1(3,:), 'Color','y', 'LineWidth',.5 , 'Parent',h(ii,3)); % ��·4
end
%%
% ����

% ���涯��
pause(1);
yes = strcmp(se{1}, 'y');
if yes
    aviobj=VideoWriter('basketball.avi', 'Motion JPEG AVI'); % �½���basketball.avi���ļ�
    open(aviobj); % ��basketball.avi���ļ�
end
% ����
for ii = 0:.02:max(posy)+1
    for jj = 1:num
        % ��x����ת
        Trx = makehgtform('xrotate', -ii*pi);
        h(jj,3).Matrix = Trx;
        % λ��
        y1 = posy(jj) - ii;
        t1 = ii / vxy(jj);
        z1 = vz(jj) * t1 - .5 * g * t1.^2 + pos{jj}(3);
        Tm = makehgtform('translate', [0 y1 z1]);
        h(jj,2).Matrix = Tm;
        % ��z����ת
        Trz = makehgtform('zrotate', -thetaAzi(jj)*pi/180);
        h(jj,1).Matrix = Trz;
    end
    drawnow;
    % д��֡
    if yes
        writeVideo(aviobj, getframe(gcf));
    end
end
% �ر�
if yes
    close(aviobj);
    disp('����ɹ���');
end