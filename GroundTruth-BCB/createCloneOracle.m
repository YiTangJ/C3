function [cloneOracles] = createCloneOracle(labeledFunctions)
%CREATECLONEORACLE 此处显示有关此函数的摘要
%   此处显示详细说明

functionalitiesNum=size(labeledFunctions,1);
cloneOracles=[];
for i=1:functionalitiesNum
    list=labeledFunctions{i};
    num=size(list,1);
    for j=1:(num-1)
        cloneOracles=[cloneOracles;repmat(list(j),num-j,1) list(j+1:num)];
    end
end

end

