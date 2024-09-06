function [reportedClones,reportNum] = getReport_BCEreport(path,sim,functions)
%GETREPORT_BCEREPORT 此处显示有关此函数的摘要
%   此处显示详细说明

sim=sim*10;
[report] = importBCEreport(path+"reportedClones_0."...
    +int2str(sim)+".txt");

num=size(report,1);
reportNum=num;
reportedClones=zeros(num,2);
func_one=report(:,1:4);
func_one.Properties.VariableNames{1} = 'type';
func_one.Properties.VariableNames{2} = 'name';
func_one.Properties.VariableNames{3} = 'startline';
func_one.Properties.VariableNames{4} = 'endline';
[exactFunc_one,idx]=ismember(func_one,functions(:,1:4));
% label_one=ones(num,1)-exactFunc_one;
reportedClones(exactFunc_one,1)=table2array(functions(idx(exactFunc_one),5));
func_two=report(:,5:8);
func_two.Properties.VariableNames{1} = 'type';
func_two.Properties.VariableNames{2} = 'name';
func_two.Properties.VariableNames{3} = 'startline';
func_two.Properties.VariableNames{4} = 'endline';
[exactFunc_two,idx]=ismember(func_two,functions(:,1:4));
% label_two=ones(num,1)-exactFunc_two;
reportedClones(exactFunc_two,2)=table2array(functions(idx(exactFunc_two),5));

% parfor i=1:num
%     if label_one(i,:)
%         func_one=report(i,1:4);
%         [functionID_one] = findFunctionID(func_one,functions);
%         reportedClones(i,1)=functionID_one;
%     end
% end
% parfor i=1:num
%     if label_two(i,:)
%         func_two=report(i,5:8);
%         [functionID_two] = findFunctionID(func_two,functions);
%         reportedClones(i,2)=functionID_two;
%     end
% end

end

