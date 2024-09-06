function [report] = getReport_ASTNN(path)
%GETREPORT_ASTNN 此处显示有关此函数的摘要
%   此处显示详细说明

reportT1=importASTNNreport(path+"report-T1.txt");
reportT2=importASTNNreport(path+"report-T2.txt");
reportT3=importASTNNreport(path+"report-T3.txt");
reportT4=importASTNNreport(path+"report-T4.txt");
reportT5=importASTNNreport(path+"report-T5.txt");
reportT6=importASTNNreport(path+"report-T6.txt");
reportT0=importASTNNreport(path+"report-T0.txt");
report=[reportT1;reportT2;reportT3;reportT4;reportT5;reportT6;reportT0];

end

