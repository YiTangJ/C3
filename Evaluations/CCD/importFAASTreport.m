function similarity = importFAASTreport(filename, dataLines)
%IMPORTFAASTREPORT 从文本文件中导入数据
%  SIMILARITY = IMPORTFAASTREPORT(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。
%  以列向量形式返回数据。
%
%  SIMILARITY = IMPORTFAASTREPORT(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  similarity = importFAASTreport("/home/cat409/Programs/RelatedWork/GraphMatch_Clone/experiments/astandnext_epoch_2", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2022-03-13 09:19:24 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 1);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = "similarity";
opts.VariableTypes = "double";

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
tbl = readtable(filename, opts);

%% 转换为输出类型
similarity = tbl.similarity;
end