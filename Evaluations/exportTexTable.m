function exportTexTable(tableType,path)
%EXPORTTEXTABLE 此处显示有关此函数的摘要
%   此处显示详细说明

[resultsTable] = exportTexResults(tableType);

fid=fopen(path,'at');
[rows,cols]=size(resultsTable);

fprintf(fid,"\\begin{table}\n");
fprintf(fid,"\\caption{"+tableType+"}\n");
fprintf(fid,"\\begin{tabular}{"+repmat('c',1,cols)+"}\n");
for i=1:rows
    fprintf(fid,"%.2f",resultsTable(i,1));
    for j=2:cols
        fprintf(fid,"& %.2f",resultsTable(i,j));
    end
    fprintf(fid,"\\tabularnewline\n");
end
fprintf(fid,"\\end{tabular}\n");
fprintf(fid,"\\end{table}\n");
fclose(fid);

end

