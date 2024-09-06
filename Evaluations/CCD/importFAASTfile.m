function [id_one, id_two, label] = importFAASTfile(filename, dataLines)
%IMPORTFAASTFILE 从文本文件中导入数据
%  [ID_ONE, ID_TWO, LABEL] = IMPORTFAASTFILE(FILENAME)读取文本文件 FILENAME
%  中默认选定范围的数据。  以列向量形式返回数据。
%
%  [ID_ONE, ID_TWO, LABEL] = IMPORTFAASTFILE(FILE, DATALINES)按指定行间隔读取文本文件
%  FILENAME 中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  [id_one, id_two, label] = importFAASTfile("/home/cat409/Programs/RelatedWork/GraphMatch_Clone/experiments/testdata.txt", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2022-03-13 09:14:28 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 3);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = "\t";

% 指定列名称和类型
opts.VariableNames = ["id_one", "id_two", "label"];
opts.VariableTypes = ["string", "string", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 指定变量属性
opts = setvaropts(opts, ["id_one", "id_two"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["id_one", "id_two"], "EmptyFieldRule", "auto");

% 导入数据
tbl = readtable(filename, opts);

%% 转换为输出类型
id_one = tbl.id_one;
id_two = tbl.id_two;
label = tbl.label;
id_one=split(id_one,"/");
id_one=id_one(:,3);
id_one=split(id_one,".");
id_one=double(id_one(:,1));
id_two=split(id_two,"/");
id_two=id_two(:,3);
id_two=split(id_two,".");
id_two=double(id_two(:,1));
end