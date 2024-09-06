function [fileid, type, name] = importCloneWorksfile(filename, dataLines)
%IMPORTCLONEWORKSFILE 从文本文件中导入数据
%  [FILEID, FOLDER, FILENAME] = IMPORTCLONEWORKSFILE(FILENAME)读取文本文件 FILENAME
%  中默认选定范围的数据。  以列向量形式返回数据。
%
%  [FILEID, FOLDER, FILENAME] = IMPORTCLONEWORKSFILE(FILE, DATALINES)按指定行间隔读取文本文件
%  FILENAME 中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  [fileid, folder, filename] = importCloneWorksfile("/home/cat409/Documents/MATLAB/ASTENS-BWA/Evaluations/CloneDetectionEva/CCD/BCB-ERA-files.txt", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2021-05-26 14:03:26 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 7);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = "/";

% 指定列名称和类型
opts.VariableNames = ["fileid", "Var2", "Var3", "Var4", "Var5", "type", "name"];
opts.SelectedVariableNames = ["fileid", "type", "name"];
opts.VariableTypes = ["double", "string", "string", "string", "string", "string", "string"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 指定变量属性
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "type", "name"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3", "Var4", "Var5", "type", "name"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "fileid", "TrimNonNumeric", true);
opts = setvaropts(opts, "fileid", "ThousandsSeparator", ",");

% 导入数据
tbl = readtable(filename, opts);

%% 转换为输出类型
fileid = tbl.fileid;
type = tbl.type;
name = tbl.name;
end