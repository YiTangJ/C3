clear;
pairs=importPairsfile('GroundTruth-BCB/samples.txt');

%% get reports from different tools
path="/home/cat409/Programs/RelatedWork/ASTNN/experiments/java/reports/bilabel/";
[report_ASTNN] = getReport_ASTNN(path);
report_ASTNN=table2array(report_ASTNN);

path="/home/cat409/Programs/RelatedWork/FA-AST/experiments/";
[id_one, id_two, ~] = importFAASTfile(path+"testdata-GT.txt");
[~,idx]=ismember([id_one id_two],pairs(:,1:2),"rows");
label=pairs(idx(idx~=0),3);
idx=idx~=0;
id_one=id_one(idx,:);
id_two=id_two(idx,:);
[similarity] = importFAASTreport(path+"/Retrained/BCB-report.txt");
similarity_new=similarity(idx,:);
report_FAAST=[id_one id_two label similarity_new];

path="/home/cat409/Programs/RelatedWork/Code2vec/experiments/BCB-ERA-latest/";
[filename,vectors] = importCode2Vecfile(path+"codeVectors.txt");
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
[report_Code2vec] = CosineSimilairyByVectors(functionID,vectors,pairs);

path="/home/cat409/Programs/RelatedWork/Infercode/experiments/BCB-ERA-latest/";
[filename,vectors] = importInfercodefile(path+"codeVectors.txt");
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
[report_Infercode] = CosineSimilairyByVectors(functionID,vectors,pairs);

path="/home/cat409/Programs/RelatedWork/CodeBERT/UniXcoder/downstream-tasks/clone-detection/BCB/experiments/results/";
report_UniXcoder = importUniXcoderreport(path+"predictions_samples-latest.txt");
[idx,loc]=ismember(report_UniXcoder(:,1:2),pairs(:,1:2),'rows');
report_UniXcoder(idx,3)=pairs(loc(idx,:),3);

path="/home/cat409/Programs/RelatedWork/CodeBERT/GraphCodeBERT/clonedetection/experiments/results/";
report_GraphCodeBERT = importGraphCodeBERTreport(path+"predictions_samples-latest.txt");
report_GraphCodeBERT(:,4)=report_GraphCodeBERT(:,3);
[idx,loc]=ismember(report_GraphCodeBERT(:,1:2),pairs(:,1:2),'rows');
report_GraphCodeBERT(idx,3)=pairs(loc(idx,:),3);

path="/home/cat409/Documents/MATLAB/ASTENS-TreeSeqCC/Evaluations/TreeSeqCC/reports/";
[report] = importASTENSBWAfile(path+"Pairwise-basic_CBOW-BCE.txt",7);
report=report(:,1:7);
report=table2array(report);
report_TreeSeqCC=[report(:,1:3) min(report(:,5:7),[],2)];

%% draw ROC figure
f=figure;
f.Position(3:4)=[1980 1980];
h=subplot(1,1,1);
hold on;

%% draw ROC of ASTNN
label_ASTNN=zeros(size(report_ASTNN,1),1);
scores_ASTNN=report_ASTNN(:,4);
idx=report_ASTNN(:,3)>0;
label_ASTNN(idx,:)=1;
idx=report_ASTNN(:,3)==0;
label_ASTNN(idx,:)=-1;
[X_ASTNN,Y_ASTNN,T_ASTNN,AUC_ASTNN]=perfcurve(label_ASTNN,scores_ASTNN,1);
num=size(X_ASTNN,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f_ASTNN=scatter(X_ASTNN(pos),Y_ASTNN(pos),30,'c+','LineWidth',2);
plot(X_ASTNN,Y_ASTNN,'c:','LineWidth',2);

%% draw ROC of FAAST
label_FAAST=zeros(size(report_FAAST,1),1);
scores_FAAST=report_FAAST(:,4);
idx=report_FAAST(:,3)>0;
label_FAAST(idx,:)=1;
idx=report_FAAST(:,3)==0;
label_FAAST(idx,:)=-1;
[X_FAAST,Y_FAAST,T_FAAST,AUC_FAAST]=perfcurve(label_FAAST,scores_FAAST,1);
num=size(X_FAAST,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f_FAAST=scatter(X_FAAST(pos),Y_FAAST(pos),30,'rx','LineWidth',2);
plot(X_FAAST,Y_FAAST,'r-.','LineWidth',2);

%% draw ROC of UniXcoder
label_UniXcoder=zeros(size(report_UniXcoder,1),1);
scores_UniXcoder=report_UniXcoder(:,4);
idx=report_UniXcoder(:,3)>0;
label_UniXcoder(idx,:)=1;
idx=report_UniXcoder(:,3)==0;
label_UniXcoder(idx,:)=-1;
[X_UniXcoder,Y_UniXcoder,T_UniXcoder,AUC_UniXcoder]=perfcurve(label_UniXcoder,scores_UniXcoder,1);
num=size(X_UniXcoder,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f_UniXcoder=scatter(X_UniXcoder(pos),Y_UniXcoder(pos),30,'gs','LineWidth',2);
plot(X_UniXcoder,Y_UniXcoder,'g--','LineWidth',2);

%% draw ROC of GraphCodeBERT
label_GraphCodeBERT=zeros(size(report_GraphCodeBERT,1),1);
scores_GraphCodeBERT=report_GraphCodeBERT(:,4);
idx=report_GraphCodeBERT(:,3)>0;
label_GraphCodeBERT(idx,:)=1;
idx=report_GraphCodeBERT(:,3)==0;
label_GraphCodeBERT(idx,:)=-1;
[X_GraphCodeBERT,Y_GraphCodeBERT,T_GraphCodeBERT,AUC_GraphCodeBERT]=perfcurve(label_GraphCodeBERT,scores_GraphCodeBERT,1);
num=size(X_GraphCodeBERT,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f_GraphCodeBERT=scatter(X_GraphCodeBERT(pos),Y_GraphCodeBERT(pos),30,'y<','LineWidth',2);
plot(X_GraphCodeBERT,Y_GraphCodeBERT,'y:','LineWidth',2);

%% draw ROC of Code2vec
label_Code2vec=zeros(size(report_Code2vec,1),1);
scores_Code2vec=report_Code2vec(:,4);
idx=report_Code2vec(:,3)>0;
label_Code2vec(idx,:)=1;
idx=report_Code2vec(:,3)==0;
label_Code2vec(idx,:)=-1;
[X_Code2vec,Y_Code2vec,T_Code2vec,AUC_Code2vec]=perfcurve(label_Code2vec,scores_Code2vec,1);
num=size(X_Code2vec,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f_Code2vec=scatter(X_Code2vec(pos),Y_Code2vec(pos),30,'md','LineWidth',2);
plot(X_Code2vec,Y_Code2vec,'m-.','LineWidth',2);

%% draw ROC of Infercode
label_Infercode=zeros(size(report_Infercode,1),1);
scores_Infercode=report_Infercode(:,4);
idx=report_Infercode(:,3)>0;
label_Infercode(idx,:)=1;
idx=report_Infercode(:,3)==0;
label_Infercode(idx,:)=-1;
[X_Infercode,Y_Infercode,T_Infercode,AUC_Infercode]=perfcurve(label_Infercode,scores_Infercode,1);
num=size(X_Infercode,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f_Infercode=scatter(X_Infercode(pos),Y_Infercode(pos),30,'b*','LineWidth',2);
plot(X_Infercode,Y_Infercode,'b--','LineWidth',2);

%% draw ROC of TreeSeqCC
label_TreeSeqCC=zeros(size(report_TreeSeqCC,1),1);
scores_TreeSeqCC=report_TreeSeqCC(:,4);
idx=report_TreeSeqCC(:,3)>0;
label_TreeSeqCC(idx,:)=1;
idx=report_TreeSeqCC(:,3)==0;
label_TreeSeqCC(idx,:)=-1;
[X_TreeSeqCC,Y_TreeSeqCC,T_TreeSeqCC,AUC_TreeSeqCC]=perfcurve(label_TreeSeqCC,scores_TreeSeqCC,1);
num=size(X_TreeSeqCC,1);
if num>10
    pos=floor(num/10.*(1:10));
else
    pos=(1:num);
end
f_TreeSeqCC=scatter(X_TreeSeqCC(pos),Y_TreeSeqCC(pos),30,'ko','LineWidth',2);
plot(X_TreeSeqCC,Y_TreeSeqCC,'k-','LineWidth',2);

%% setting figure
grid on;
grid minor;
set(h,'FontName','Times New Roman','FontSize',24);
xlabel('False Positive Rate','FontName','Times New Roman','FontSize',32);
ylabel('True Positive Rate','FontName','Times New Roman','FontSize',32);
legend([f_ASTNN f_FAAST f_UniXcoder f_GraphCodeBERT f_Code2vec f_Infercode f_TreeSeqCC],'ASTNN','FA-AST','UniXcoder','GraphCodeBERT','Code2vec','Infercode','TreeSeqCC',...
    'position',[0.771524290668113,0.116465109392238,0.12964823810599,0.179894174690599]);