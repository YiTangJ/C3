function [reportedClones,reportNum] = getReport_Siamese(path)
%GETREPORT_SIAMESE 此处显示有关此函数的摘要
%   此处显示详细说明

report = importSiamesereport(path+"/clones.txt");
idx=report(:,1)~=report(:,2);
reportedClones=report(idx,:);
reportNum=size(reportedClones,1);

end

