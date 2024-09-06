function [formattedClones] = reportTransfer(report,functions)
%REPORTTRANSFER 此处显示有关此函数的摘要
%   此处显示详细说明

func_one=report(:,1);
func_two=report(:,2);
functions = movevars(functions, 'type', 'Before', 'name');
functionsID=table2array(functions(:,5));
[~,ia_one]=ismember(func_one,functionsID);
[~,ia_two]=ismember(func_two,functionsID);
idx=ia_one~=0;
ia_one=ia_one(idx,:);
ia_two=ia_two(idx,:);
idx=ia_two~=0;
ia_one=ia_one(idx,:);
ia_two=ia_two(idx,:);
formattedClones=functions(ia_one,1:4);
formattedClones.Properties.VariableNames{1} = 'type_one';
formattedClones.Properties.VariableNames{2} = 'name_one';
formattedClones.Properties.VariableNames{3} = 'startline_one';
formattedClones.Properties.VariableNames{4} = 'endline_one';
formattedClones=[formattedClones functions(ia_two,1:4)];
formattedClones.Properties.VariableNames{5} = 'type_two';
formattedClones.Properties.VariableNames{6} = 'name_two';
formattedClones.Properties.VariableNames{7} = 'startline_two';
formattedClones.Properties.VariableNames{8} = 'endline_two';

end

