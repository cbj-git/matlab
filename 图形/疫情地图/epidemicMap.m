%% �����ͼ
%% 1.api�ӿ�
% �ߵµ�ͼapi���״����к��ͼ���ݱ��浽country.mat���ٴ�����ʱǰ2С����ڲ������У�����ע�͵���
% 
% �������req = URL + key + (�����ؼ���) + �¼�����������2 + (�����������߽������) + (���ؽ������) +  �����ʽ(json)��

% clear;clc;close all;
% options = weboptions("RequestMethod","get", "Timeout",10); % web��ȡ����Ϊget,��ʱ10s
% req = "https://restapi.amap.com/v3/config/district" + "?key=�����������key" + ...
%     "&subdistrict=2" + "&output=json"; % �ߵµ�ͼ������api�������
% country = webread(req, options); % web��ȡ���ң�ʡ�ͳ��������
% country = country.districts.districts;
%% 
% ѭ����ȡʡ�硣

%  for ii = 1:numel(country)
%     req = "https://restapi.amap.com/v3/config/district" + "?key=�����������key" +...
%         "&keywords=" + country(ii).name + "&subdistrict=0" + "&extensions=all" + "&filter=" + country(ii).adcode +...
%         "&output=json"; % ��������api�������
%     pro = webread(req, options); % web��ȡʡ��
%     country(ii).polyline = pro.districts.polyline; % ʡ�����ͬһ��struct
%     country(ii).center = str2double(split(country(ii).center, ","));
%     country(ii).polyline = str2double(split(country(ii).polyline, [",",";","|"])); % ʡ���ַ�ת����
%
%     s = size(country(ii).districts);
%     for jj = 1:s(1)
%         country(ii).districts(jj).center = str2double(split(country(ii).districts(jj).center, ",")); % ���������ַ�ת����
%     end
%  end
%  save country country; % �����ͼ����
%% 
% ��������api���������req = URL + key + �����ʽ(json)��

clear;clc;close all;
load country country; % ����ǰ�汣��ĵ�ͼ����
country = struct2table(country); % ��ʽת��
options = weboptions("RequestMethod","get", "Timeout",10); % web��ȡ����Ϊget,��ʱ10s
req = "http://api.tianapi.com/txapi/ncovcity/index" + "?key=add4e61c407d01c04f58dc57195fa850";
epidemic = webread(req, options); % web��ȡ
epidemic = epidemic.newslist;
epidemic = struct2table(epidemic); % ��ʽת��
%% 2.���ݴ���
% �ϲ�table�࣬��������epidemic�͵�ͼ����country��

epidemic.Properties.VariableNames{'locationId'} = 'adcode';
epidemic.adcode = cellstr(num2str(epidemic.adcode));
epidemic = innerjoin(epidemic, country, "Keys","adcode"); % �ü�����adcode����epidemic��country
epidemic = removevars(epidemic, "provinceName"); % ɾ���ظ������
epidemic = movevars(epidemic, "name", "Before", "provinceShortName");
%% 
% epidemic��Ԫ��structת��Ϊtable��

s1 = size(epidemic);
for ii = 1:s1(1)
    if ~isempty(epidemic.districts{ii})
        epidemic.districts{ii} = struct2table(epidemic.districts{ii}, "AsArray",true); % ��Ԫ��structת��Ϊtable
    end
    if ~isempty(epidemic.cities{ii})
        epidemic.cities{ii} = struct2table(epidemic.cities{ii}, "AsArray",true);
        epidemic.cities{ii}.Properties.VariableNames{'locationId'} = 'adcode';
        epidemic.cities{ii}.adcode = cellstr(num2str(epidemic.cities{ii}.adcode));
        epidemic.cities{ii} = innerjoin(epidemic.cities{ii}, epidemic.districts{ii}, "Keys","adcode"); % ���Ӹ���������
    end
end
epidemic = removevars(epidemic, "districts"); % ɾ����������������
epidemic = epidemic(:, {'name','cities','confirmedCount','suspectedCount','curedCount','deadCount',...
    'comment','citycode','polyline'}); % ���������
clearvars country;
%% 3.��ͼ����
% ��������

ax = axes;
hold on;
axis equal;
axis([73 135 3 55]);
colormap jet;
caxis([0 150]);
cor1 = cell2mat([epidemic.polyline]); % ʡ������
scatter(cor1(1:50:end), cor1(2:50:end), 1, 'k', 'filled', 'o'); % ʡ��ȷ������
%% 
% �ؼ������顣

cor2 = []; % ���ؼ�������
levela = []; % ���ؼ���ȷ������
for ii = 1:s1(1)
    s2 = size(epidemic.cities{ii});
    if s2(2) == 12
        cor2 = [cor2; cell2mat([epidemic.cities{ii}.center])]; % ���ؼ�������
        levela = [levela; epidemic.cities{ii}.confirmedCount]; % ���ؼ���ȷ������
    end
end
scatter(cor2(1:2:end), cor2(2:2:end), 2*sqrt(levela), levela, 'filled', 'd');
colorbar;
title("����������ؼ���ȷ������");
xlabel("����\circ");
ylabel("γ��\circ");
hold off;
ta = epidemic(:, 1:6);
clearvars cor1 epidemic;

ta.Properties.VariableNames = {'ʡ','��','ȷ��','����','����','����'};
ta{end+1, 1} = {'�ܼ�'};
ta(end, 3:6) = array2table( sum(ta{:, 3:6}) );
disp("��ʡ���������");
ta = sortrows(ta, "ȷ��", "descend")

n = inputdlg("ʡ����ʡ���(1~34)��","����",1,"����ʡ");
if ~isempty(n)
    idx1 = strcmp(n{1}, ta.('ʡ'));
    idx2 = (str2double(n{1})+1 == 1:s1(1)+1)';
    idx = find(idx1 + idx2);
    disp(ta{idx, 'ʡ'} + "�������������");
    tb = ta{idx, '��'}{1};
    if ~isempty(tb)
        tb = sortrows(tb, "confirmedCount", "descend");
        tb = tb(:, {'name','confirmedCount','suspectedCount','curedCount','deadCount'}); % ���������
        tb.Properties.VariableNames = {'��','ȷ��','����','����','����'}
    end
end