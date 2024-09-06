%% Draw ECDF for ASTNN

reportT1=importASTNNreport(path+"report-T1.txt");
reportT2=importASTNNreport(path+"report-T2.txt");
reportT3=importASTNNreport(path+"report-T3.txt");
reportT4=importASTNNreport(path+"report-T4.txt");
reportT5=importASTNNreport(path+"report-T5.txt");
reportFA=importASTNNreport(path+"report-T0.txt");

figure('WindowState','maximized');
h=subplot(1,1,1);
hold on;
[f,x]=ecdf(table2array(reportT1(:,4)));
num=size(f,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f1=scatter(x(pos),f(pos),'g+','LineWidth',2);
plot(x,f,'g-','LineWidth',2);

[f,x]=ecdf(table2array(reportT2(:,4)));
num=size(f,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f2=scatter(x(pos),f(pos),'ko','LineWidth',2);
plot(x,f,'k','LineWidth',2);

[f,x]=ecdf(table2array(reportT3(:,4)));
num=size(f,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f3=scatter(x(pos),f(pos),'b*','LineWidth',2);
plot(x,f,'b--','LineWidth',2);

[f,x]=ecdf(table2array(reportT4(:,4)));
num=size(f,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f4=scatter(x(pos),f(pos),'rx','LineWidth',2);
plot(x,f,'r-.','LineWidth',2);

[f,x]=ecdf(table2array(reportT5(:,4)));
num=size(f,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f5=scatter(x(pos),f(pos),'m^','LineWidth',2);
plot(x,f,'m-','LineWidth',2);

[f,x]=ecdf(table2array(reportFA(:,4)));
num=size(f,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f6=scatter(x(pos),f(pos),'cs','LineWidth',2);
plot(x,f,'c-','LineWidth',2);

grid on;
grid minor;
yticklabels((0:10:100));
legend([f1 f2 f3 f4 f5 f6],'T1','T2','ST3','MT3','WT3/T4','FP',...
    'position',[0.79,0.12,0.11,0.22]);
set(h,'FontName','Times New Roman','FontSize',24,'XLim',[0.8,1]);
xlabel('Similarity Threshold (ASTNN)','FontName','Times New Roman','FontSize',32);
ylabel('Percentage(%)','FontName','Times New Roman','FontSize',32);