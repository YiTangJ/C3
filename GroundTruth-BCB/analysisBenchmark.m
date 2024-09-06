function [benchmarkStats,clones,false_positives] = analysisBenchmark(benchmark)
%ANALYSISBENCHMARK 此处显示有关此函数的摘要
%   此处显示详细说明

load(benchmark, 'clones', 'false_positives');
samples=[clones;false_positives];
benchmarkStats.Num_Clones=size(clones,1);
benchmarkStats.Num_False_Positives=size(false_positives,1);

%% find all functionalities
functionalities=unique(table2array(samples(:,3)));
benchmarkStats.Functionalities=functionalities;

%% seperate functions from different functionalities
num=size(functionalities,1);
functions_clones=cell(num,1);
% functions_false_positives=cell(num,1);
functionsNum=zeros(num,1);
for i=1:num
    idx=table2array(clones(:,3))==functionalities(i);
    functions_clones{i}=unique([table2array(clones(idx,1));table2array(clones(idx,2))]);
%     idx=table2array(false_positives(:,3))==functionalities(i);
%     functions_false_positives{i}=unique([table2array(false_positives(idx,1));table2array(false_positives(idx,2))]);
    functionsNum(i,:)=size(functions_clones{i},1);
end
benchmarkStats.Functions_Clones=functions_clones;
% statistics.Functions_False_Positives=functions_false_positives;
benchmarkStats.FunctionsNum=functionsNum;

%% statistics repeated functions between different functionalities
repeatedFunctions_clones=[];
for i=1:(num-1)
    for j=i+1:num
        idx=ismember(functions_clones{i},functions_clones{j});
        if sum(idx)
            repeated=functions_clones{i}(idx,:);
            for p=1:sum(idx)
                idx=(table2array(clones(:,1))==repeated(p)|table2array(clones(:,2))==repeated(p))&table2array(clones(:,3))==functionalities(i);
                repeatedNumA=sum(idx);
                idx=(table2array(clones(:,1))==repeated(p)|table2array(clones(:,2))==repeated(p))&table2array(clones(:,3))==functionalities(j);
                repeatedNumB=sum(idx);
                repeatedFunctions_clones=[repeatedFunctions_clones;...
                    repeated(p) functionalities(i) repeatedNumA functionalities(j) repeatedNumB];
            end
        end
    end
end
benchmarkStats.RepeatedFunctions_Clones=repeatedFunctions_clones;
% repeatedFunctions_false_positives=[];
% for i=1:(num-1)
%     for j=i+1:num
%         idx=ismember(functions_false_positives{i},functions_false_positives{j});
%         if sum(idx)
%             repeated=functions_false_positives{i}(idx,:);
%             for p=1:sum(idx)
%                 idx=(table2array(false_positives(:,1))==repeated(p)|table2array(false_positives(:,2))==repeated(p))&table2array(false_positives(:,3))==functionalities(i);
%                 repeatedNumA=sum(idx);
%                 idx=(table2array(false_positives(:,1))==repeated(p)|table2array(false_positives(:,2))==repeated(p))&table2array(false_positives(:,3))==functionalities(j);
%                 repeatedNumB=sum(idx);
%                 repeatedFunctions_false_positives=[repeatedFunctions_false_positives;...
%                     repeated(p) functionalities(i) repeatedNumA functionalities(j) repeatedNumB];
%             end
%         end
%     end
% end
% statistics.RepeatedFunctions_False_Positives=repeatedFunctions_false_positives;

%% get distinguished functions by functionalities
labeledFunctions_clones=[];
% labeledFunctions_false_positives=[];
for i=1:size(functionalities,1)
    idx=ismember(functions_clones{i},repeatedFunctions_clones(:,1));
    funcs=functions_clones{i}(~idx,:);
    labeledFunctions_clones=[labeledFunctions_clones;funcs int64(ones(size(funcs,1),1)).*functionalities(i)];  
%     idx=ismember(functions_false_positives{i},repeatedFunctions_false_positives(:,1));
%     funcs=functions_false_positives{i}(~idx,:);
%     labeledFunctions_false_positives=[labeledFunctions_false_positives;funcs int64(ones(size(funcs,1),1)).*functionalities(i)];  
end
benchmarkStats.LabeledFunctions_Clones=labeledFunctions_clones;
% statistics.LabeledFunctions_False_Positives=labeledFunctions_false_positives;

% %% get the unique label of functions
% idx=ismember(labeledFunctions_false_positives(:,1),labeledFunctions_clones(:,1));
% labeledFunctions_false_positives(idx,:)=[];
% oneLableFunctions=[labeledFunctions_clones;labeledFunctions_false_positives];
% statistics.OneLableFunctions=oneLableFunctions;

%% statistics the ground truth from clones
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
clones_groundTruth=[T1Num_gt;T2Num_gt;VST3Num_gt;ST3Num_gt;MT3Num_gt;WT3Num_gt];
benchmarkStats.CloneTypes(:,1)=clones_groundTruth;

%% statistics the ground truth from false_positives
lineSim_gt=table2array(false_positives(:,5));
tokenSim_gt=table2array(false_positives(:,6));
syntacticalSim_gt=lineSim_gt;
idx=lineSim_gt>tokenSim_gt;
syntacticalSim_gt(idx,:)=tokenSim_gt(idx,:);
T1Num_gt=sum(table2array(false_positives(:,4))==1);
T2Num_gt=sum(table2array(false_positives(:,4))==2);
VST3Num_gt=sum(table2array(false_positives(:,4))==3&syntacticalSim_gt(:,1)>=0.9);
ST3Num_gt=sum(table2array(false_positives(:,4))==3&syntacticalSim_gt(:,1)>=0.7&syntacticalSim_gt(:,1)<0.9);
MT3Num_gt=sum(table2array(false_positives(:,4))==3&syntacticalSim_gt(:,1)>=0.5&syntacticalSim_gt(:,1)<0.7);
WT3Num_gt=sum(table2array(false_positives(:,4))==3&syntacticalSim_gt(:,1)<0.5);
false_positives_groundTruth=[T1Num_gt;T2Num_gt;VST3Num_gt;ST3Num_gt;MT3Num_gt;WT3Num_gt];
benchmarkStats.CloneTypes(:,2)=false_positives_groundTruth;

end

