function [functionID] = findFunctionID(report,functions)
%FINDFUNCTIONID 此处显示有关此函数的摘要
%   此处显示详细说明

functionID=0;
type=cellstr(table2array(report(1,1)));
name=cellstr(table2array(report(1,2)));
startline=table2array(report(1,3));
endline=table2array(report(1,4));
func=table(name,type,'VariableNames',{'name','type'});
[idx]=ismember(functions(:,1:2),func,'rows');
candfuncs=functions(idx,:);
if size(candfuncs,1)
    startlineList=table2array(candfuncs(:,3));
    endlineList=table2array(candfuncs(:,4));
    idx=startlineList>endline|endlineList<startline;
    candfuncs(idx,:)=[];
    n=size(candfuncs,1);
    if n
        startlineList=table2array(candfuncs(:,3));
        endlineList=table2array(candfuncs(:,4));
        funcID=table2array(candfuncs(:,5));
        A=startlineList;
        idx=startlineList<startline;
        A(idx,:)=startline;
        B=endlineList;
        idx=endlineList>endline;
        B(idx,:)=endline;
        overlap=double((B-A))./double((endlineList-startlineList));
        if max(overlap)>=0.7
            [~,idx]=max(overlap);
            functionID=funcID(idx,:);
        end
    end
end
    
end

