function recall = importBCEReportfile(filename, dataLines)
%IMPORTBCEREPORTFILE 从文本文件中导入数据
%  RECALLASTNN0 = IMPORTBCEREPORTFILE(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。
%  以表形式返回数据。
%
%  RECALLASTNN0 = IMPORTBCEREPORTFILE(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  recallASTNN0 = importBCEReportfile("/home/cat409/Programs/RelatedWork/BigCloneEval/Eval/Recall/recall-ASTNN_0.8.txt", [35, 64]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2022-07-23 17:08:58 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [35, 64];
end

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = ":";

% 指定列名称和类型
opts.VariableNames = ["Tool", "ASTNN"];
opts.VariableTypes = ["categorical", "string"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 指定变量属性
opts = setvaropts(opts, "ASTNN", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Tool", "ASTNN"], "EmptyFieldRule", "auto");

% 导入数据
report = readtable(filename, opts);

clones_all=report(2:9,2);
[recall_all]=gatherData(clones_all);
clones_InterProject=report(12:19,2);
[recall_InterProject]=gatherData(clones_InterProject);
clones_IntraProject=report(23:30,2);
[recall_IntraProject]=gatherData(clones_IntraProject);
recall=[recall_all' recall_InterProject' recall_IntraProject'];
end

function [recall]=gatherData(clones)

clones=table2array(clones);
clones=string(clones);
clones=split(clones,"=");
clones=clones(:,2);
recall=double(clones)*100;
recall(3:4,:)=[];
end