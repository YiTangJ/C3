function [reportedClones,reportNum] = getReport_SourcererCC(path,sim)
%GETREPORT_SOURCERERCC 此处显示有关此函数的摘要
%   此处显示详细说明

sim=sim*10;
[files]=importSourcererCCfile(path+"files.txt");
report1=importSourcererCCreport(path+"sim-0."...
    +int2str(sim)+"/NODE_1/output"+int2str(sim)+".0/query_1clones_index_WITH_FILTER.txt");
report2=importSourcererCCreport(path+"sim-0."...
    +int2str(sim)+"/NODE_2/output"+int2str(sim)+".0/query_2clones_index_WITH_FILTER.txt");
report=[report1;report2];
reportNum=size(report,1);

num=size(report,1);
reportedClones=zeros(num,2);
reportA=table(report(:,2),'VariableName',{'fileid'});
reportA=join(reportA,files);
reportedClones(:,1)=table2array(reportA(:,2));
reportB=table(report(:,4),'VariableName',{'fileid'});
reportB=join(reportB,files);
reportedClones(:,2)=table2array(reportB(:,2));

end

