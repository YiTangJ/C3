function [traditionalMetrics,LearningMetrics] = analysisASTNN_BCB_CCD(path,sim,clones,false_positives)
%ANALYSISASTNN_BCB_CCD 此处显示有关此函数的摘要
%   此处显示详细说明

[report] = getReport_ASTNN(path);

groundTruth=table2array(report(:,3));
probability=table2array(report(:,4));
prediction=probability>=sim;
[precision,recall,F1score,accuracy,falseAlarm] = precision_recall_F1score(groundTruth,prediction);
LearningMetrics.precision=precision;
LearningMetrics.recall=recall;
LearningMetrics.F1score=F1score;
LearningMetrics.accuracy=accuracy;
LearningMetrics.falseAlarm=falseAlarm;

report=table2array(report);
funcID_one=report(:,1);
funcID_two=report(:,2);
similarity=report(:,4);
idx=similarity>=sim;
reportedClones=[funcID_one(idx,:) funcID_two(idx,:)];
[~,~,hitID]=intersect([reportedClones;reportedClones(:,2) reportedClones(:,1)],table2array(clones(:,1:2)),'rows');
hit=clones(hitID,:);
[~,~,falseID]=intersect([reportedClones;reportedClones(:,2) reportedClones(:,1)],table2array(false_positives(:,1:2)),'rows');
falseAlarm=false_positives(falseID,:);
[recall,hitNum] = analysisHit(hit,clones);
traditionalMetrics.recall=recall;
traditionalMetrics.hitNum=hitNum;
traditionalMetrics.falseAlarm=falseAlarm;

end

