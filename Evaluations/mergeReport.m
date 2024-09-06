function [report] = mergeReport(reportA,reportB)
%MERGEREPORT 此处显示有关此函数的摘要
%   此处显示详细说明

if size(reportA,1)
    if size(reportB,1)
        idx=reportA(:,1)<reportA(:,2);
        reportA(idx,1:2)=[reportA(idx,2) reportA(idx,1)];
        idx=reportB(:,1)<reportB(:,2);
        reportB(idx,1:2)=[reportB(idx,2) reportB(idx,1)];
        [idA,idB]=ismember(reportA(:,1:2),reportB(:,1:2),"rows");
        report=reportA;
        simA=reportA(idA,3);
        simB=reportB(idB(idB~=0),3);
        idx=simB>simA;
        sim=simA;
        sim(idx,:)=simB(idx,:);
        report(idA,3)=sim;
        idx=ismember(reportB(:,1:2),reportA(:,1:2),"rows");
        report=[report;reportB(~idx,:)];
    else
        report=reportA;
    end
else
    report=reportB;
end

end

