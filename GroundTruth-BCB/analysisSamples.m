function [statistics] = analysisSamples(samples,benchmark)
%ANALYSISSAMPLES 此处显示有关此函数的摘要
%   此处显示详细说明

load(benchmark, 'clones', 'false_positives');
statistics.Num_Samples=size(samples,1);
idx=samples(:,3)>0;
positives=samples(idx,1:2);
statistics.Num_Positives=size(positives,1);
[~,~,idx]=intersect([positives;positives(:,2) positives(:,1)],table2array(clones(:,1:2)),"rows");
statistics.Num_Positives_in_Clones=size(idx,1);
hit=clones(idx,:);
[~,~,idx]=intersect([positives;positives(:,2) positives(:,1)],table2array(false_positives(:,1:2)),"rows");
statistics.Num_Positives_in_False_Positives=size(idx,1);
[recall,~] = analysisHit(hit,clones);
statistics.CloneTypes=recall;
idx=samples(:,3)<=0;
negatives=samples(idx,1:2);
statistics.Num_Negatives=size(negatives,1);
[~,~,idx]=intersect([negatives;negatives(:,2) negatives(:,1)],table2array(clones(:,1:2)),"rows");
statistics.Num_Negatives_in_Clones=size(idx,1);
[~,~,idx]=intersect([negatives;negatives(:,2) negatives(:,1)],table2array(false_positives(:,1:2)),"rows");
statistics.Num_Negatives_in_False_Positives=size(idx,1);
[idx]=ismember(samples(:,1:2),table2array(clones(:,1:2)),"rows");
samples(idx,:)=[];
[idx]=ismember([samples(:,2) samples(:,1)],table2array(clones(:,1:2)),"rows");
samples(idx,:)=[];
[idx]=ismember(samples(:,1:2),table2array(false_positives(:,1:2)),"rows");
samples(idx,:)=[];
[idx]=ismember([samples(:,2) samples(:,1)],table2array(false_positives(:,1:2)),"rows");
samples(idx,:)=[];
statistics.Out_of_Benchmark=size(samples,1);

[benchmarkStats] = analysisBenchmark(benchmark);
labeledFunctions=benchmarkStats.LabeledFunctions_Clones;
idx=samples(:,3)>0;
positives=samples(idx,1:2);
statistics.OOB_Positives=size(positives,1);
idx=ismember(positives(:,1),labeledFunctions(:,1));
labeledPositives=positives(idx,:);
idx=ismember(labeledPositives(:,2),labeledFunctions(:,1));
labeledPositives=labeledPositives(idx,:);
[~,id1]=ismember(labeledPositives(:,1),labeledFunctions(:,1));
[~,id2]=ismember(labeledPositives(:,2),labeledFunctions(:,1));
label=[labeledFunctions(id1,2) labeledFunctions(id2,2)];
idx=label(:,1)==label(:,2);
statistics.OOB_Positives_Correct=sum(idx);
idx=label(:,1)~=label(:,2);
statistics.OOB_Positives_Wrong=sum(idx);
statistics.OOB_Positives_Undetermined=statistics.Num_Positives-statistics.Num_Positives_in_Clones-statistics.Num_Positives_in_False_Positives-size(labeledPositives,1);
idx=samples(:,3)<=0;
negatives=samples(idx,1:2);
statistics.OOB_Negatives=size(negatives,1);
idx=ismember(negatives(:,1),labeledFunctions(:,1));
labeledNegatives=negatives(idx,:);
idx=ismember(labeledNegatives(:,2),labeledFunctions(:,1));
labeledNegatives=labeledNegatives(idx,:);
[~,id1]=ismember(labeledNegatives(:,1),labeledFunctions(:,1));
[~,id2]=ismember(labeledNegatives(:,2),labeledFunctions(:,1));
label=[labeledFunctions(id1,2) labeledFunctions(id2,2)];
idx=label(:,1)~=label(:,2);
statistics.OOB_Negatives_Correct=sum(idx);
idx=label(:,1)==label(:,2);
statistics.OOB_Negatives_Wrong=sum(idx);
statistics.OOB_Negatives_Undetermined=statistics.Num_Negatives-statistics.Num_Negatives_in_Clones-statistics.Num_Negatives_in_False_Positives-size(labeledNegatives,1);

end

