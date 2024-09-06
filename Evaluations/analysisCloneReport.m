function [results] = analysisCloneReport(report,benchmarkStats,clones,false_positives)
%ANALYSISCLONEREPORT 此处显示有关此函数的摘要
%   此处显示详细说明

codePairs=report(:,1:2);
idx=codePairs(:,1)<codePairs(:,2);
codePairs(idx,:)=[codePairs(idx,2) codePairs(idx,1)];
[~,idx]=unique(codePairs,"rows");
report=report(idx,:);
if size(report,2)==2
    positives=report;
    
    results.Num_Reported=size(positives,1);
    [~,~,idx]=intersect([positives;positives(:,2) positives(:,1)],table2array(clones(:,1:2)),"rows");
    hit=clones(idx,:);
    [recall,hitNum,overallRecall] = analysisHit(hit,clones);
    results.Num_Clones=sum(hitNum,2);
    results.Positives_Recall=recall;
    results.Positives_Overall_Recall=overallRecall;
    results.Positives_HitNum=hitNum;
    [~,~,idx]=intersect([positives;positives(:,2) positives(:,1)],table2array(false_positives(:,1:2)),"rows");
    results.Positives_False_Alarm=size(idx,1);
    
    labeledFunctions=benchmarkStats.LabeledFunctions_Clones;
    BCBLabel_positives=zeros(size(positives,1),1);
    [ia]=ismember(positives,table2array(clones(:,1:2)),"rows");
    BCBLabel_positives(ia,1)=2;
    [ia]=ismember([positives(:,2) positives(:,1)],table2array(clones(:,1:2)),"rows");
    BCBLabel_positives(ia,1)=2;
    [ia]=ismember(positives,table2array(false_positives(:,1:2)),"rows");
    BCBLabel_positives(ia,1)=-2;
    [ia]=ismember([positives(:,2) positives(:,1)],table2array(false_positives(:,1:2)),"rows");
    BCBLabel_positives(ia,1)=-2;
    functionalityLabel_positives=zeros(size(positives,1),1);
    id1=ismember(positives(:,1),labeledFunctions(:,1));
    id2=ismember(positives(:,2),labeledFunctions(:,1));
    labeledPositives_index=find(id1&id2);
    labeledPositives=positives(labeledPositives_index,:);
    [~,id1]=ismember(labeledPositives(:,1),labeledFunctions(:,1));
    [~,id2]=ismember(labeledPositives(:,2),labeledFunctions(:,1));
    label=[labeledFunctions(id1,2) labeledFunctions(id2,2)];
    idx=label(:,1)==label(:,2);
    functionalityLabel_positives(labeledPositives_index(idx),1)=1;
    idx=label(:,1)~=label(:,2);
    functionalityLabel_positives(labeledPositives_index(idx),1)=-1;
    idx=BCBLabel_positives~=0;
    functionalityLabel_positives(idx,1)=BCBLabel_positives(idx,1);
    positives_BCB_tp=sum(functionalityLabel_positives==2);
    positives_labeled_BCB_tp=sum(functionalityLabel_positives(labeledPositives_index)==2);
    positives_Functionality_tp=sum(functionalityLabel_positives==1);
    positives_labeled_Functionality_tp=sum(functionalityLabel_positives(labeledPositives_index)==1);
    positives_BCB_fp=sum(functionalityLabel_positives==-2);
    positives_labeled_BCB_fp=sum(functionalityLabel_positives(labeledPositives_index)==-2);
    positives_Functionality_fp=sum(functionalityLabel_positives==-1);
    positives_labeled_Functionality_fp=sum(functionalityLabel_positives(labeledPositives_index)==-1);
    positives_undetermined=sum(functionalityLabel_positives==0);
    positives_labeled_undetermined=sum(functionalityLabel_positives(labeledPositives_index)==0);
    results.Positives_Clones=positives_BCB_tp;
    results.Positives_Possible_Clones=positives_Functionality_tp;
    results.Positives_False_Alarm_Addtional=positives_BCB_fp+positives_Functionality_fp;
    results.Positives_Undetermined=positives_undetermined;
    results.Num_Labeled_Positives=size(labeledPositives,1);
    results.Labeled_Positives_Clones=positives_labeled_BCB_tp;
    results.Labeled_Positives_Possible_Clones=positives_labeled_Functionality_tp;
    results.Labeled_Positives_False_Alarm=positives_labeled_BCB_fp+positives_labeled_Functionality_fp;
    results.Labeled_Positives_Precision_Lower_Bound=positives_labeled_BCB_tp/results.Num_Labeled_Positives*100;
    results.Labeled_Positives_Precision_Upper_Bound=100-(positives_labeled_BCB_fp+positives_labeled_Functionality_fp)/results.Num_Labeled_Positives*100;
    results.Labeled_Positives_False_Alarm_Lower_Bound=(positives_labeled_BCB_fp+positives_labeled_Functionality_fp)/results.Num_Labeled_Positives*100;
    
elseif size(report,2)==3
    idx=report(:,3)>0;
    positives=report(idx,1:2);
    idx=report(:,3)<=0;
    negatives=report(idx,1:2);

    results.Num_Reported=size(report,1);
    results.Num_Positives=size(positives,1);
    [~,~,idx]=intersect([positives;positives(:,2) positives(:,1)],table2array(clones(:,1:2)),"rows");
    hit=clones(idx,:);
    [recall,hitNum,overallRecall] = analysisHit(hit,clones);
    results.Positives_Clones=sum(hitNum,2);
    results.Positives_Recall=recall;
    results.Positives_Overall_Recall=overallRecall;
    results.Positives_HitNum=hitNum;
    [~,~,idx]=intersect([positives;positives(:,2) positives(:,1)],table2array(false_positives(:,1:2)),"rows");
    results.Positives_False_Alarm=size(idx,1);

    results.Num_Negatives=size(negatives,1);
    [~,~,idx]=intersect([negatives;negatives(:,2) negatives(:,1)],table2array(clones(:,1:2)),"rows");
    hit=clones(idx,:);
    [recall,hitNum] = analysisHit(hit,clones);
    results.Negatives_Missed_Recall=recall;
    results.Negatives_Missed_HitNum=hitNum;
    [~,~,idx]=intersect([negatives;negatives(:,2) negatives(:,1)],table2array(false_positives(:,1:2)),"rows");
    results.Negatives_True_Negatives=size(idx,1);

    learning_tp=sum(results.Positives_HitNum,2);
    learning_fp=results.Positives_False_Alarm;
    learning_tn=results.Negatives_True_Negatives;
    learning_fn=sum(results.Negatives_Missed_HitNum,2);
    precision=learning_tp/(learning_tp+learning_fp)*100;
    recall=learning_tp/(learning_tp+learning_fn)*100;
    F1score=(2*precision*recall)/(precision+recall);
    accuracy=(learning_tp+learning_tn)/results.Num_Reported*100;
    FPR=learning_fp/(learning_fp+learning_tn)*100;
    FNR=learning_fn/(learning_tp+learning_fn)*100;
    results.LearningMetric_Precision=precision;
    results.LearningMetric_Recall=recall;
    results.LearningMetric_F1_Score=F1score;
    results.LearningMetric_Accuracy=accuracy;
    results.LearningMetric_FalsePositiveRate=FPR;
    results.LearningMetric_FalseNegativeRate=FNR;

    labeledFunctions=benchmarkStats.LabeledFunctions_Clones;
    BCBLabel_positives=zeros(size(positives,1),1);
    [ia]=ismember(positives,table2array(clones(:,1:2)),"rows");
    BCBLabel_positives(ia,1)=2;
    [ia]=ismember([positives(:,2) positives(:,1)],table2array(clones(:,1:2)),"rows");
    BCBLabel_positives(ia,1)=2;
    [ia]=ismember(positives,table2array(false_positives(:,1:2)),"rows");
    BCBLabel_positives(ia,1)=-2;
    [ia]=ismember([positives(:,2) positives(:,1)],table2array(false_positives(:,1:2)),"rows");
    BCBLabel_positives(ia,1)=-2;
    functionalityLabel_positives=zeros(size(positives,1),1);
    id1=ismember(positives(:,1),labeledFunctions(:,1));
    id2=ismember(positives(:,2),labeledFunctions(:,1));
    labeledPositives_index=find(id1&id2);
    labeledPositives=positives(labeledPositives_index,:);
    [~,id1]=ismember(labeledPositives(:,1),labeledFunctions(:,1));
    [~,id2]=ismember(labeledPositives(:,2),labeledFunctions(:,1));
    label=[labeledFunctions(id1,2) labeledFunctions(id2,2)];
    idx=label(:,1)==label(:,2);
    functionalityLabel_positives(labeledPositives_index(idx),1)=1;
    idx=label(:,1)~=label(:,2);
    functionalityLabel_positives(labeledPositives_index(idx),1)=-1;
    idx=BCBLabel_positives~=0;
    functionalityLabel_positives(idx,1)=BCBLabel_positives(idx,1);
    positives_BCB_tp=sum(functionalityLabel_positives==2);
    positives_Functionality_tp=sum(functionalityLabel_positives==1);
    positives_BCB_fp=sum(functionalityLabel_positives==-2);
    positives_Functionality_fp=sum(functionalityLabel_positives==-1);
    positives_undetermined=sum(functionalityLabel_positives==0);

    BCBLabel_negatives=zeros(size(negatives,1),1);
    [ia]=ismember(negatives,table2array(clones(:,1:2)),"rows");
    BCBLabel_negatives(ia,1)=2;
    [ia]=ismember([negatives(:,2) negatives(:,1)],table2array(clones(:,1:2)),"rows");
    BCBLabel_negatives(ia,1)=2;
    [ia]=ismember(negatives,table2array(false_positives(:,1:2)),"rows");
    BCBLabel_negatives(ia,1)=-2;
    [ia]=ismember([negatives(:,2) negatives(:,1)],table2array(false_positives(:,1:2)),"rows");
    BCBLabel_negatives(ia,1)=-2;
    functionalityLabel_negatives=zeros(size(negatives,1),1);
    id1=ismember(negatives(:,1),labeledFunctions(:,1));
    id2=ismember(negatives(:,2),labeledFunctions(:,1));
    labeledPositives_index=find(id1&id2);
    labeledPositives=negatives(labeledPositives_index,:);
    [~,id1]=ismember(labeledPositives(:,1),labeledFunctions(:,1));
    [~,id2]=ismember(labeledPositives(:,2),labeledFunctions(:,1));
    label=[labeledFunctions(id1,2) labeledFunctions(id2,2)];
    idx=label(:,1)==label(:,2);
    functionalityLabel_negatives(labeledPositives_index(idx),1)=1;
    idx=label(:,1)~=label(:,2);
    functionalityLabel_negatives(labeledPositives_index(idx),1)=-1;
    idx=BCBLabel_negatives~=0;
    functionalityLabel_negatives(idx,1)=BCBLabel_negatives(idx,1);
    negatives_BCB_fn=sum(functionalityLabel_negatives==2);
    negatives_Functionality_fn=sum(functionalityLabel_negatives==1);
    negatives_BCB_tn=sum(functionalityLabel_negatives==-2);
    negatives_Functionality_tn=sum(functionalityLabel_negatives==-1);
    negatives_undetermined=sum(functionalityLabel_negatives==0);
    results.ByFunctionality_Positives_Clones=positives_BCB_tp;
    results.ByFunctionality_Positives_Possibel_Clones=positives_Functionality_tp;
    results.ByFunctionality_Positives_False_Alarm=positives_BCB_fp+positives_Functionality_fp;
    results.ByFunctionality_Positives_Undetermined=positives_undetermined;
    results.ByFunctionality_Negatives_Missed_Clones=negatives_BCB_fn;
    results.ByFunctionality_Negatives_Possible_Missed_Clones=negatives_Functionality_fn;
    results.ByFunctionality_Negatives_Rejected=negatives_BCB_tn+negatives_Functionality_tn;
    results.ByFunctionality_Negatives_Undetermined=negatives_undetermined;
    results.NewMetric=[positives_BCB_tp positives_Functionality_tp positives_BCB_fp positives_Functionality_fp positives_undetermined;...
        negatives_BCB_fn negatives_Functionality_fn negatives_BCB_tn negatives_Functionality_tn negatives_undetermined];
end

end

