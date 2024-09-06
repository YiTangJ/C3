function [reportedClones,reportNum] = getReport_CloneWorks(path,sim,functions)
%GETREPORT_CLONEWORKS 此处显示有关此函数的摘要
%   此处显示详细说明

sim=sim*10;
[fileid,type,name] = importCloneWorksfile(path+"files.txt");
report_type1 = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type1.clones");
report_type2blind = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type2blind.clones");
report_type2systematic = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type2systematic.clones");
report_type3pattern = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type3pattern.clones");
report_type3token = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type3token.clones");
report=[report_type1;report_type2blind;report_type2systematic;report_type3pattern;report_type3token];
reportNum=size(report,1);

name=cellstr(name);
type=cellstr(type);
files=table(name,type,fileid,'VariableName',{'name','type','fileid'});
functions=join(functions,files);

report=array2table(report,'VariableName',{'fileidA','startlineA','endlineA','fileidB','startlineB','endlineB'});
functionsA=functions(:,[6 3 4 5]);
functionsA.Properties.VariableNames{1} = 'fileidA';
functionsA.Properties.VariableNames{2} = 'startlineA';
functionsA.Properties.VariableNames{3} = 'endlineA';
functionsA.Properties.VariableNames{4} = 'idA';
report=outerjoin(report,functionsA,'LeftKeys',[1 2 3],'RightKeys',[1 2 3]);
functionsB=functions(:,[6 3 4 5]);
functionsB.Properties.VariableNames{1} = 'fileidB';
functionsB.Properties.VariableNames{2} = 'startlineB';
functionsB.Properties.VariableNames{3} = 'endlineB';
functionsB.Properties.VariableNames{4} = 'idB';
report=outerjoin(report,functionsB,'LeftKeys',[4 5 6],'RightKeys',[1 2 3]);
reportedClones=table2array(report(:,[10 14]));
idx=(reportedClones(:,1).*reportedClones(:,2)>0);
reportedClones=reportedClones(idx,:);

end

