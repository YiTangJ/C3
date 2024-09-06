function exportReports(toolName,path,functions,sim,functionsID)
%EXPORTREPORTS 此处显示有关此函数的摘要
%   此处显示详细说明

if nargin < 4
    if strcmp(toolName,'NiCad')
        [report_type3_2] = importNiCADfile(path+"/type3_2_reportedClones.txt");
        [report_type3_2c] = importNiCADfile(path+"/type3_2c_reportedClones.txt");
        report=[report_type3_2;report_type3_2c];

        [formattedClones] = reportTransfer(report,functions);
        writetable(formattedClones,'EvalReport-NiCad.txt','Delimiter',',');
        return;
    end
elseif nargin < 5
    if strcmp(toolName,'SourcererCC')
        sim=sim*10;
        [files]=importSourcererCCfile(path+"/files.txt");
        report1=importSourcererCCreport(path+"/sim-0." ...
            +int2str(sim)+"/NODE_1/output"+int2str(sim)+".0/query_1clones_index_WITH_FILTER.txt");
        report2=importSourcererCCreport(path+"/sim-0." ...
            +int2str(sim)+"/NODE_2/output"+int2str(sim)+".0/query_2clones_index_WITH_FILTER.txt");
        report=[report1;report2];

        num=size(report,1);
        reportedClones=zeros(num,2);
        reportA=table(report(:,2),'VariableName',{'fileid'});
        reportA=join(reportA,files);
        reportedClones(:,1)=table2array(reportA(:,2));
        reportB=table(report(:,4),'VariableName',{'fileid'});
        reportB=join(reportB,files);
        reportedClones(:,2)=table2array(reportB(:,2));

        [formattedClones] = reportTransfer(reportedClones,functions);
        writetable(formattedClones,'EvalReport-SourcererCC.txt','Delimiter',',');
        return;
    end

    if strcmp(toolName,'CloneWorks')
        sim=sim*10;
        [fileid,type,name] = importCloneWorksfile(path+"/files.txt");
        report_type1 = importCloneWorksreport(path+"/sim-0."...
            +int2str(sim)+"/type1.clones");
        report_type2blind = importCloneWorksreport(path+"/sim-0."...
            +int2str(sim)+"/type2blind.clones");
        report_type2systematic = importCloneWorksreport(path+"/sim-0."...
            +int2str(sim)+"/type2systematic.clones");
        report_type3pattern = importCloneWorksreport(path+"/sim-0."...
            +int2str(sim)+"/type3pattern.clones");
        report_type3token = importCloneWorksreport(path+"/sim-0."...
            +int2str(sim)+"/type3token.clones");
        report=[report_type1;report_type2blind;report_type2systematic;report_type3pattern;report_type3token];

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

        [formattedClones] = reportTransfer(reportedClones,functions);
        writetable(formattedClones,'EvalReport-CloneWorks.txt','Delimiter',',');
        return;
    end
else
    if strcmp(toolName,'TreeSeqCC')
        [report] = importASTENSBWAfile(path+"reports/Pairwise-basic_CBOW-BCE.txt",7);
        report=report(:,1:7);
        report=table2array(report);
        idx=report(:,5)>=sim&report(:,6)>=sim&report(:,7)>=sim;
        reportedClones=report(idx,1:2);

        [formattedClones] = reportTransfer(reportedClones,functions);
        writetable(formattedClones,'EvalReport-TreeSeqCC.txt','Delimiter',',');
        return;
    end
end

end

