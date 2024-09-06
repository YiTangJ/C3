function [regularX,regularY,x,y] = regularPoints(x,y,xmin,xmax,pointsNum)
%REGULARPOINTS 此处显示有关此函数的摘要
%   此处显示详细说明

if min(x)>xmin
    xmin=min(x);
end
if max(x)<xmax
    xmax=max(x);
end
step=(xmax-xmin)/pointsNum;
idx=x>=xmin&x<=xmax;
x=x(idx,1);
y=y(idx,1);
if x(size(x,1),1)==x(1,1)
    regularX=ones(pointsNum+1,1).*x(1,1);
else
    regularX=(xmin:step:xmax)';
end
regularY=zeros(pointsNum+1,1);
idx=x<=xmin+0.5*step;
regularY(1,1)=max(y(idx,1));
idx=x>=xmax-0.5*step;
regularY(pointsNum+1,1)=min(y(idx,1));
for i=2:pointsNum
    idx=x==regularX(i,1);
    if sum(idx)
        regularY(i,1)=min(y(idx,1));
    else
        idx=x>=regularX(i,1)-0.5*step&x<=regularX(i,1)+0.5*step;
        if sum(idx)
            regularY(i,1)=min(y(idx,1));
        else
            regularY(i,1)=regularY(i-1,1);
        end
    end
end

end
