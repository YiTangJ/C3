function [recall,hitNum,overallRecall] = analysisHit(hit,clones)
%ANALYSISHIT 此处显示有关此函数的摘要
%   此处显示详细说明

lineSim_gt=table2array(clones(:,5));
tokenSim_gt=table2array(clones(:,6));
syntacticalSim_gt=lineSim_gt;
idx=lineSim_gt>tokenSim_gt;
syntacticalSim_gt(idx,:)=tokenSim_gt(idx,:);

T1Num_gt=sum(table2array(clones(:,4))==1);
T2Num_gt=sum(table2array(clones(:,4))==2);
VST3Num_gt=sum(table2array(clones(:,4))==3&syntacticalSim_gt(:,1)>=0.9);
ST3Num_gt=sum(table2array(clones(:,4))==3&syntacticalSim_gt(:,1)>=0.7&syntacticalSim_gt(:,1)<0.9);
MT3Num_gt=sum(table2array(clones(:,4))==3&syntacticalSim_gt(:,1)>=0.5&syntacticalSim_gt(:,1)<0.7);
WT3Num_gt=sum(table2array(clones(:,4))==3&syntacticalSim_gt(:,1)<0.5);

lineSim=table2array(hit(:,5));
tokenSim=table2array(hit(:,6));
syntacticalSim=lineSim;
idx=lineSim>tokenSim;
syntacticalSim(idx,:)=tokenSim(idx,:);

T1Num=sum(table2array(hit(:,4))==1);
T2Num=sum(table2array(hit(:,4))==2);
VST3Num=sum(table2array(hit(:,4))==3&syntacticalSim(:,1)>=0.9);
ST3Num=sum(table2array(hit(:,4))==3&syntacticalSim(:,1)>=0.7&syntacticalSim(:,1)<0.9);
MT3Num=sum(table2array(hit(:,4))==3&syntacticalSim(:,1)>=0.5&syntacticalSim(:,1)<0.7);
WT3Num=sum(table2array(hit(:,4))==3&syntacticalSim(:,1)<0.5);

recall=[T1Num/T1Num_gt T2Num/T2Num_gt VST3Num/VST3Num_gt ...
    ST3Num/ST3Num_gt MT3Num/MT3Num_gt WT3Num/WT3Num_gt].*100;
overallRecall=(T1Num+T2Num+VST3Num+ST3Num+MT3Num+WT3Num)/(T1Num_gt+T2Num_gt+VST3Num_gt ...
    +ST3Num_gt+MT3Num_gt+WT3Num_gt)*100;
hitNum=[T1Num T2Num VST3Num ST3Num MT3Num WT3Num];

end

