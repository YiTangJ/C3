function files = importSourcererCCfile(filename, dataLines)
%IMPORTSOURCERERCCFILE 从文本文件中导入数据
%  FILES = IMPORTSOURCERERCCFILE(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  以表形式返回数据。
%
%  FILES = IMPORTSOURCERERCCFILE(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  files = importSourcererCCfile("/home/cat409/Documents/MATLAB/ASTENS-BWA/Evaluations/CloneDetectionEva/CCD/files.txt", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2021-05-26 19:19:16 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = [" ", ",", "."];

% 指定列名称和类型
opts.VariableNames = ["Var1", "fileid", "functionId", "Var4"];
opts.SelectedVariableNames = ["fileid", "functionId"];
opts.VariableTypes = ["string", "double", "double", "string"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 指定变量属性
opts = setvaropts(opts, ["Var1", "Var4"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var4"], "EmptyFieldRule", "auto");

% 导入数据
files = readtable(filename, opts);

end