function [reportedClones,reportNum] = getReport_Deckard(path,sim)
%GETREPORT_DECKARD 此处显示有关此函数的摘要
%   此处显示详细说明

[funcID_one_clone, funcID_two_clone] = importDeckardfile(path+"clones/report-10_2_0."+int2str(10*sim)+".txt");
[funcID_one_false, funcID_two_false] = importDeckardfile(path+"falseAlerm/report-10_2_0."+int2str(10*sim)+".txt");
funcID_one=[funcID_one_clone;funcID_one_false];
funcID_two=[funcID_two_clone;funcID_two_false];
reportedClones=[funcID_one funcID_two];
reportNum=size(reportedClones,1);

end

