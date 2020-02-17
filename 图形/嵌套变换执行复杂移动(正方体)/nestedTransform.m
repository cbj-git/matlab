%% Ƕ�ױ任��ִ�и����ƶ�
% ����ʾ�������任�����Ƕ�ײ�νṹ��Ȼ��˳�����Щ������б任�������������δ���һ�������塣��ʾ����ʾ���ʹ�任������Ϊ�����任����ĸ����Դ�����νṹ���Լ��任��νṹ�ĳ�Ա���Ӱ�츽����Ա��
%
% ����չʾ�˲�νṹ��
%
%
%
% |transform_foldbox| ����ʵ�ֱ任��νṹ��|doUpdate| ��������ÿһ��������������������һ����Ϊ |transform_foldbox.m|
% ���ļ���ִ�� |transform_foldbox|��

clear;clc;close all;
transform_foldbox;
%%
function transform_foldbox
% Create six square and fold
% them into a cube

figure

% Set axis limits and view
axes('Projection','perspective')
view([25,25]); axis equal; grid on;
cameratoolbar('SetMode', 'orbit');
axis([0 4 0 4 -1 0])
xlabel('x'); ylabel('y'); zlabel('z');

% Create a hierarchy of transform objects
t(1) = hgtransform;
t(2) = hgtransform('parent',t(1));
t(3) = hgtransform('parent',t(2));
t(4) = hgtransform('parent',t(3));
t(5) = hgtransform('parent',t(4));
t(6) = hgtransform('parent',t(5));

% Patch data
X = [0 0 1 1];
Y = [0 1 1 0];
Z = [0 0 0 0];

% Text data
Xtext = .5;
Ytext = .5;
Ztext = .15;

% Corresponding pairs of objects (patch and text)
% are parented into the object hierarchy
p(1) = patch('FaceColor','red','Parent',t(1));
txt(1) = text('String','��','Parent',t(1));
p(2) = patch('FaceColor','green','Parent',t(2));
txt(2) = text('String','','Parent',t(2));
p(3) = patch('FaceColor','blue','Parent',t(3));
txt(3) = text('String','','Parent',t(3));
p(4) = patch('FaceColor','yellow','Parent',t(4));
txt(4) = text('String','','Parent',t(4));
p(5) = patch('FaceColor','cyan','Parent',t(5));
txt(5) = text('String','','Parent',t(5));
p(6) = patch('FaceColor','magenta','Parent',t(6));
txt(6) = text('String','','Parent',t(6));

% All the patch objects use the same x, y, and z data
set(p,'XData',X,'YData',Y,'ZData',Z)

% Set the position and alignment of the text objectsta
set(txt,'Position',[Xtext Ytext Ztext],...
    'HorizontalAlignment','center',...
    'VerticalAlignment','middle')

% Display the objects in their current location
doUpdate(1)

% Set up initial translation transforms
% Translate 1 unit in x
Tx = makehgtform('translate',[1 0 0]);
% Translate 1 unit in y
Ty = makehgtform('translate',[0 1 0]);

% Translate the unit squares to the desired locations
% The drawnow and pause commands display
% the objects after each translation
set(t(2),'Matrix',Tx);
txt(2).String = '��';
doUpdate(1)
set(t(3),'Matrix',Ty);
txt(3).String = '��';
doUpdate(1)
set(t(4),'Matrix',Tx);
txt(4).String = '��';
doUpdate(1)
set(t(5),'Matrix',Ty);
txt(5).String = '��';
doUpdate(1)
set(t(6),'Matrix',Tx);
txt(6).String = 'ǰ';
doUpdate(1)

% Specify rotation angle (pi/2 radians = 90 degrees)
fold = -pi/2;

% Rotate -y, translate x
Ry = makehgtform('yrotate',-fold);
TxRy = Tx*Ry;

% Rotate x, translate y
Rx = makehgtform('xrotate',fold);
TyRx = Ty*Rx;

% Set the transforms
% Draw after each group transform and pause
set(t(6),'Matrix',TxRy);
doUpdate(1)
set(t(5),'Matrix',TyRx);
doUpdate(1)
set(t(4),'Matrix',TxRy);
doUpdate(1)
set(t(3),'Matrix',TyRx);
doUpdate(1)
set(t(2),'Matrix',TxRy);
doUpdate(1)
end

function doUpdate(delay)
drawnow
pause(delay)
end