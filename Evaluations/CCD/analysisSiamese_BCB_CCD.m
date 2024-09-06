function [hit,falseAlarm,reportNum] = analysisSiamese_BCB_CCD(path,clones,false_positives)
%ANALYSISSIAMESE_BCB_CCD 此处显示有关此函数的摘要
%   此处显示详细说明

[reportedClones,reportNum] = getReport_Siamese(path);

[~,~,hitID]=intersect([reportedClones;reportedClones(:,2) reportedClones(:,1)],table2array(clones(:,1:2)),'rows');
hit=clones(hitID,:);
[~,~,falseID]=intersect([reportedClones;reportedClones(:,2) reportedClones(:,1)],table2array(false_positives(:,1:2)),'rows');
falseAlarm=false_positives(falseID,:);

end

