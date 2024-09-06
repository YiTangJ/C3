function predictions = importGraphCodeBERTreport(filename, dataLines)
%IMPORTFILE 从文本文件中导入数据
%  PREDICTIONS = IMPORTGRAPHCODEBERTREPORT(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  返回数值数据。
%
%  PREDICTIONS = IMPORTGRAPHCODEBERTREPORT(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  predictions = importGraphCodeBERTreport("/home/cat409/Programs/RelatedWork/CodeBERT/GraphCodeBERT/clonedetection/experiments/results/tmp/predictions_samples-1.txt", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2023-11-12 16:11:00 自动生成

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
opts.VariableNames = ["VarName1", "VarName2", "VarName3"];
opts.VariableTypes = ["double", "double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
predictions = readtable(filename, opts);

%% 转换为输出类型
predictions = table2array(predictions);
end