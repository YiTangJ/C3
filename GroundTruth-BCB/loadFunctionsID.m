function functionsID = loadFunctionsID(filename, dataLines)
%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 2);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = [",", "."];

% 指定列名称和类型
opts.VariableNames = ["funcID", "Var2"];
opts.SelectedVariableNames = "funcID";
opts.VariableTypes = ["double", "string"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 指定变量属性
opts = setvaropts(opts, "Var2", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var2", "EmptyFieldRule", "auto");

% 导入数据
tbl = readtable(filename, opts);

functionsID = readtable(filename, opts);

end