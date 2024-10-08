function report = importASTNNreport(filename, dataLines)
%IMPORTASTNNREPORT 从文本文件中导入数据
%  REPORT = IMPORTASTNNREPORT(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  以表形式返回数据。
%
%  REPORT = IMPORTASTNNREPORT(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  report = importASTNNreport("/home/cat409/Programs/RelatedWork/astnn/clone/data/java/report/report-T1.txt", [2, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2021-11-19 17:24:46 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [2, Inf];
end

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 4);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = " ";

% 指定列名称和类型
opts.VariableNames = ["id1", "id2", "label", "prediction"];
opts.VariableTypes = ["double", "double", "double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% 导入数据
report = readtable(filename, opts);

end