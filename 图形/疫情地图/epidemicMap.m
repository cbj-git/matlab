%% 疫情地图
%% 1.api接口
% 高德地图api。首次运行后绘图数据保存到country.mat。再次运行时前2小代码节不必运行，可以注释掉。
% 
% 请求参数req = URL + key + (搜索关键词) + 下级行政区级数2 + (返回行政区边界坐标点) + (返回结果控制) +  输出格式(json)。

% clear;clc;close all;
% options = weboptions("RequestMethod","get", "Timeout",10); % web读取操作为get,超时10s
% req = "https://restapi.amap.com/v3/config/district" + "?key=这里输入你的key" + ...
%     "&subdistrict=2" + "&output=json"; % 高德地图行政区api请求参数
% country = webread(req, options); % web读取国家，省和城市坐标点
% country = country.districts.districts;
%% 
% 循环读取省界。

%  for ii = 1:numel(country)
%     req = "https://restapi.amap.com/v3/config/district" + "?key=这里输入你的key" +...
%         "&keywords=" + country(ii).name + "&subdistrict=0" + "&extensions=all" + "&filter=" + country(ii).adcode +...
%         "&output=json"; % 疫情数据api请求参数
%     pro = webread(req, options); % web读取省界
%     country(ii).polyline = pro.districts.polyline; % 省界放入同一个struct
%     country(ii).center = str2double(split(country(ii).center, ","));
%     country(ii).polyline = str2double(split(country(ii).polyline, [",",";","|"])); % 省界字符转数字
%
%     s = size(country(ii).districts);
%     for jj = 1:s(1)
%         country(ii).districts(jj).center = str2double(split(country(ii).districts(jj).center, ",")); % 城市坐标字符转数字
%     end
%  end
%  save country country; % 保存地图数据
%% 
% 肺炎疫情api。请求参数req = URL + key + 输出格式(json)。

clear;clc;close all;
load country country; % 导入前面保存的地图数据
country = struct2table(country); % 格式转换
options = weboptions("RequestMethod","get", "Timeout",10); % web读取操作为get,超时10s
req = "http://api.tianapi.com/txapi/ncovcity/index" + "?key=add4e61c407d01c04f58dc57195fa850";
epidemic = webread(req, options); % web读取
epidemic = epidemic.newslist;
epidemic = struct2table(epidemic); % 格式转换
%% 2.数据处理
% 合并table类，肺炎疫情epidemic和地图数据country。

epidemic.Properties.VariableNames{'locationId'} = 'adcode';
epidemic.adcode = cellstr(num2str(epidemic.adcode));
epidemic = innerjoin(epidemic, country, "Keys","adcode"); % 用键变量adcode联接epidemic和country
epidemic = removevars(epidemic, "provinceName"); % 删除重复表变量
epidemic = movevars(epidemic, "name", "Before", "provinceShortName");
%% 
% epidemic表元素struct转换为table。

s1 = size(epidemic);
for ii = 1:s1(1)
    if ~isempty(epidemic.districts{ii})
        epidemic.districts{ii} = struct2table(epidemic.districts{ii}, "AsArray",true); % 表元素struct转换为table
    end
    if ~isempty(epidemic.cities{ii})
        epidemic.cities{ii} = struct2table(epidemic.cities{ii}, "AsArray",true);
        epidemic.cities{ii}.Properties.VariableNames{'locationId'} = 'adcode';
        epidemic.cities{ii}.adcode = cellstr(num2str(epidemic.cities{ii}.adcode));
        epidemic.cities{ii} = innerjoin(epidemic.cities{ii}, epidemic.districts{ii}, "Keys","adcode"); % 联接各城市属性
    end
end
epidemic = removevars(epidemic, "districts"); % 删除多余城市名表变量
epidemic = epidemic(:, {'name','cities','confirmedCount','suspectedCount','curedCount','deadCount',...
    'comment','citycode','polyline'}); % 表变量处理
clearvars country;
%% 3.画图计算
% 行政区。

ax = axes;
hold on;
axis equal;
axis([73 135 3 55]);
colormap jet;
caxis([0 150]);
cor1 = cell2mat([epidemic.polyline]); % 省界坐标
scatter(cor1(1:50:end), cor1(2:50:end), 1, 'k', 'filled', 'o'); % 省界确诊人数
%% 
% 地级市疫情。

cor2 = []; % 各地级市坐标
levela = []; % 各地级市确诊人数
for ii = 1:s1(1)
    s2 = size(epidemic.cities{ii});
    if s2(2) == 12
        cor2 = [cor2; cell2mat([epidemic.cities{ii}.center])]; % 各地级市坐标
        levela = [levela; epidemic.cities{ii}.confirmedCount]; % 各地级市确诊人数
    end
end
scatter(cor2(1:2:end), cor2(2:2:end), 2*sqrt(levela), levela, 'filled', 'd');
colorbar;
title("肺炎疫情各地级市确诊人数");
xlabel("经度\circ");
ylabel("纬度\circ");
hold off;
ta = epidemic(:, 1:6);
clearvars cor1 epidemic;

ta.Properties.VariableNames = {'省','市','确诊','怀疑','治愈','死亡'};
ta{end+1, 1} = {'总计'};
ta(end, 3:6) = array2table( sum(ta{:, 3:6}) );
disp("各省疫情情况：");
ta = sortrows(ta, "确诊", "descend")

n = inputdlg("省名或省序号(1~34)：","输入",1,"湖北省");
if ~isempty(n)
    idx1 = strcmp(n{1}, ta.('省'));
    idx2 = (str2double(n{1})+1 == 1:s1(1)+1)';
    idx = find(idx1 + idx2);
    disp(ta{idx, '省'} + "各市疫情情况：");
    tb = ta{idx, '市'}{1};
    if ~isempty(tb)
        tb = sortrows(tb, "confirmedCount", "descend");
        tb = tb(:, {'name','confirmedCount','suspectedCount','curedCount','deadCount'}); % 表变量处理
        tb.Properties.VariableNames = {'市','确诊','怀疑','治愈','死亡'}
    end
end