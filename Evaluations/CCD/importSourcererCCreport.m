function report = importSourcererCCreport(filename, dataLines)
%IMPORTSOURCERERCCREPORT 从文本文件中导入数据
%  REPORT = IMPORTSOURCERERCCREPORT(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  返回数值数据。
%
%  REPORT = IMPORTSOURCERERCCREPORT(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  report = importSourcererCCreport("/home/cat409/Documents/MATLAB/ASTENS-BWA/CCD-results/query_1clones_index_WITH_FILTER.txt", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2021-01-25 13:42:57 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 4);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4"];
opts.VariableTypes = ["double", "double", "double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
report = readtable(filename, opts);

%% 转换为输出类型
report = table2array(report);
end