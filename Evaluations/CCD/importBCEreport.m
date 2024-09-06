function report = importBCEreport(filename, dataLines)
%IMPORTBCEREPORT 从文本文件中导入数据
%  REPORT = IMPORTBCEREPORT(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  以表形式返回数据。
%
%  REPORT = IMPORTBCEREPORT(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  report = importBCEreport("/home/cat409/Documents/MATLAB/ASTENS-BWA/Evaluations/CloneDetectionEva/CCD/reportedClones_0.8.txt", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2021-06-24 03:02:45 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 8);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["type_one", "name_one", "startline_one", "endline_one", "type_two", "name_two", "startline_two", "endline_two"];
opts.VariableTypes = ["string", "string", "double", "double", "string", "string", "double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 指定变量属性
opts = setvaropts(opts, ["type_one", "name_one", "type_two", "name_two"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["type_one", "name_one", "type_two", "name_two"], "EmptyFieldRule", "auto");

% 导入数据
report = readtable(filename, opts);

end