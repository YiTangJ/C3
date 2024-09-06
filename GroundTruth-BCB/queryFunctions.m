function [functions] = queryFunctions()
%QUERYFUNCTIONS 此处显示有关此函数的摘要
%   此处显示详细说明

loadDatabase;
query="select name,type,startline,endline,id from functions";
functions=select(dcon,query);
functionsID=loadFunctionsID("/home/cat409/Documents/MATLAB/ASTENS-BWA/GrandTruth-BCB/reducedFuncIDs.txt");
functionsID.Properties.VariableNames{1} = 'id';
[~,ia,~]=intersect(functions(:,5),functionsID);
functions=functions(ia,:);

end

