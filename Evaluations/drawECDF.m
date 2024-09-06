path="/home/cat409/Documents/MATLAB/ASTENS-TreeSeqCC/Evaluations/TreeSeqCC/reports/";
[report] = importASTENSBWAfile(path+"Pairwise-basic_CBOW.txt",7);
report=report(:,1:7);
report=table2array(report);
report=[report(:,1:3) min(report(:,5:7),[],2)];

%% Draw ECDF
idxT1=report(:,3)==1;
idxT2=report(:,3)==2;
idxVST3=report(:,3)==3;
idxST3=report(:,3)==4;
idxMT3=report(:,3)==5;
idxWT3=report(:,3)==6;
idxFalse=report(:,3)==0;
col=4;
xmin=-1;
xmax=1;

figure('WindowState','maximized');
h=subplot(1,1,1);
hold on;
% yyaxis left;
[f,x]=ecdf(report(idxT1,col),'Function','survivor');
[regularX1,regularY1,x,f] = regularPoints(x,f,xmin,xmax,2000);
num=size(regularY1,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f1=scatter(regularX1(pos),regularY1(pos),'g+','LineWidth',2);
% plot(x,f,'g-','LineWidth',2);
plot(regularX1,regularY1,'g-','LineWidth',2);

[f,x]=ecdf(report(idxT2,col),'Function','survivor');
[regularX2,regularY2,x,f] = regularPoints(x,f,xmin,xmax,2000);
num=size(regularY2,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f2=scatter(regularX2(pos),regularY2(pos),'ko','LineWidth',2);
% plot(x,f,'k','LineWidth',2);
plot(regularX2,regularY2,'k','LineWidth',2);

[f,x]=ecdf(report(idxVST3,col),'Function','survivor');
[regularX3,regularY3,x,f] = regularPoints(x,f,xmin,xmax,2000);
num=size(regularY3,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f3=scatter(regularX3(pos),regularY3(pos),'yd','LineWidth',2);
% plot(x,f,'y:','LineWidth',2);
plot(regularX3,regularY3,'y:','LineWidth',2);

[f,x]=ecdf(report(idxST3,col),'Function','survivor');
[regularX4,regularY4,x,f] = regularPoints(x,f,xmin,xmax,2000);
num=size(regularY4,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f4=scatter(regularX4(pos),regularY4(pos),'b*','LineWidth',2);
% plot(x,f,'b--','LineWidth',2);
plot(regularX4,regularY4,'b--','LineWidth',2);

[f,x]=ecdf(report(idxMT3,col),'Function','survivor');
[regularX5,regularY5,x,f] = regularPoints(x,f,xmin,xmax,2000);
num=size(regularY5,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f5=scatter(regularX5(pos),regularY5(pos),'rx','LineWidth',2);
% plot(x,f,'r-.','LineWidth',2);
plot(regularX5,regularY5,'r-.','LineWidth',2);

[f,x]=ecdf(report(idxWT3,col),'Function','survivor');
[regularX6,regularY6,x,f] = regularPoints(x,f,xmin,xmax,2000);
num=size(regularY6,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f6=scatter(regularX6(pos),regularY6(pos),'m^','LineWidth',2);
% plot(x,f,'m-','LineWidth',2);
plot(regularX6,regularY6,'m-','LineWidth',2);

[f,x]=ecdf(report(idxFalse,col),'Function','survivor');
[regularX7,regularY7,x,f] = regularPoints(x,f,xmin,xmax,2000);
num=size(regularY7,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f7=scatter(regularX7(pos),regularY7(pos),'cs','LineWidth',2);
% plot(x,f,'c-','LineWidth',2);
plot(regularX7,regularY7,'c-','LineWidth',2);

grid on;
grid minor;
set(h,'FontName','Times New Roman','FontSize',24,'XLim',[0,1],'YLim',[0,1]);
xlabel('Reported Similarity of TreeSeqCC','FontName','Times New Roman','FontSize',32);
% xlabel('Line Similarity in BigCloneBench','FontName','Times New Roman','FontSize',32);
set(h,'YTickLabel',num2str((0:10:100)'));
ylabel('Percentage(%)','FontName','Times New Roman','FontSize',32);

% yyaxis right;
% deviation=regularY6-regularY7;
% f8=plot(regularX7,deviation,'Color',[0.85 0.325 0.098],'LineWidth',2);
% ylim([0 1]);
% set(h,'YTickLabel',num2str((0:10:100)'));
% ylabel('Deviation between WT3/T4 and FP','Color',[0.85 0.325 0.098],'FontName','Times New Roman','FontSize',32);

% h.YAxis(1).Color='k';
legend([f1 f2 f3 f4 f5 f6 f7],'T1','T2','VST3','ST3','MT3','WT3/T4','FP',...
    'position',[0.131733655475663 0.113782930103008 0.0606913171301318 0.1798941746906]);