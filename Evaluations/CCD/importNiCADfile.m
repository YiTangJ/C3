function [report] = importNiCADfile(filename, dataLines)
%IMPORTFILE 从文本文件中导入数据
%  [REPORT] =
%  IMPORTNICADFILE(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  以列向量形式返回数据。
%
%  [REPORT] =
%  IMPORTNICADFILE(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME 中的数据。对于不连续的行间隔，请将
%  DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  [report] = importNiCADFile("/home/cat409/Documents/MATLAB/ASTENS-BWA/Evaluations/SimilarIncompleteFile/CCD/NiCad/report-full.txt", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2021-06-17 11:52:59 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = [" "];

% 指定列名称和类型
opts.VariableNames = ["func_one", "func_two"];
opts.VariableTypes = ["double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";

% 导入数据
tbl = readtable(filename, opts);

%% 转换为输出类型
func_one = tbl.func_one;
func_two = tbl.func_two;

report=[func_one func_two];
end