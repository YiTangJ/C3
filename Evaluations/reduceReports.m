function [report] = reduceReports(report,reducedFunctionsID)
%REDUCEREPORTS 此处显示有关此函数的摘要
%   此处显示详细说明

idx=ismember(report(:,1),reducedFunctionsID);
report=report(idx,:);
idx=ismember(report(:,2),reducedFunctionsID);
report=report(idx,:);

end

