function [hit,falseAlarm,reportNum] = analysisNiCad_BCB_CCD(path,type,clones,false_positives)
%ANALYSISNICAD_BCB_CCD 此处显示有关此函数的摘要
%   此处显示详细说明

if strcmp(type,"all")
%     [report_type1] = importNiCADfile("/home/cat409/Programs/CCD/NiCad-6.2/experiments/BCB-ERA-v2/"...
%         +"type1_reportedClones.txt");
%     [report_type2] = importNiCADfile("/home/cat409/Programs/CCD/NiCad-6.2/experiments/BCB-ERA-v2/"...
%         +"type2_reportedClones.txt");
%     [report_type2c] = importNiCADfile("/home/cat409/Programs/CCD/NiCad-6.2/experiments/BCB-ERA-v2/"...
%         +"type2c_reportedClones.txt");
%     [report_type3_1] = importNiCADfile("/home/cat409/Programs/CCD/NiCad-6.2/experiments/BCB-ERA-v2/"...
%         +"type3_1_reportedClones.txt");
    [report_type3_2] = importNiCADfile(path+"type3_2_reportedClones.txt");
    [report_type3_2c] = importNiCADfile(path+"type3_2c_reportedClones.txt");
    report=[report_type3_2;report_type3_2c];
else
    [report] = importNiCADfile(path+type+"_reportedClones.txt");
end
reportNum=size(report,1);

[~,~,hitID]=intersect([report;report(:,2) report(:,1)],table2array(clones(:,1:2)),'rows');
hit=clones(hitID,:);
[~,~,falseID]=intersect([report;report(:,2) report(:,1)],table2array(false_positives(:,1:2)),'rows');
falseAlarm=false_positives(falseID,:);

end

