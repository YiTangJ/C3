function [report] = CosineSimilairyByVectors(functionID,vectors,pairs)
%COSINESIMILAIRYBYVECTORS 此处显示有关此函数的摘要
%   此处显示详细说明

[~,id1]=ismember(pairs(:,1),functionID);
[~,id2]=ismember(pairs(:,2),functionID);
idx=id1.*id2>0;
label=pairs(idx,3);
pairs=[id1(idx,:) id2(idx,:)];
num=size(pairs,1);
similarity=zeros(num,1);
sizeLimit=500000;
if num>sizeLimit
    for i=1:floor(num/sizeLimit)
        idx=(1:sizeLimit)';
        idx=idx+(i-1)*sizeLimit;
        A=vectors(pairs(idx,1),:);
        B=vectors(pairs(idx,2),:);
        similarity_tmp=A.*B;
        similarity_tmp=sum(similarity_tmp,2);
        A=A.^2;
        A=sum(A,2);
        A=A.^0.5;
        B=B.^2;
        B=sum(B,2);
        B=B.^0.5;
        similarity(idx,:)=similarity_tmp./A./B;
    end
    idx=(i*sizeLimit+1:num);
    A=vectors(pairs(idx,1),:);
    B=vectors(pairs(idx,2),:);
    similarity_tmp=A.*B;
    similarity_tmp=sum(similarity_tmp,2);
    A=A.^2;
    A=sum(A,2);
    A=A.^0.5;
    B=B.^2;
    B=sum(B,2);
    B=B.^0.5;
    similarity(idx,:)=similarity_tmp./A./B;
else
    A=vectors(pairs(:,1),:);
    B=vectors(pairs(:,2),:);
    similarity=A.*B;
    similarity=sum(similarity,2);
    A=A.^2;
    A=sum(A,2);
    A=A.^0.5;
    B=B.^2;
    B=sum(B,2);
    B=B.^0.5;
    similarity=similarity./A./B;
end
report=[functionID(pairs(:,1)) functionID(pairs(:,2)) label similarity];

end

