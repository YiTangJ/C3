function [samples] = analysisDiff()
%ANALYSISDIFF 此处显示有关此函数的摘要
%   此处显示详细说明

load('astens-bwa/BCBenchmark.mat', 'functions');
samples=importPairsfile('groundTruth/samples.txt');

%% get report from NiCad
col=4;
path="/home/cat409/Programs/RelatedWork/NiCad-6.2/experiments/BCB-ERA-latest/";
[report_type3_2] = importNiCADfile(path+"type3_2_reportedClones.txt");
[report_type3_2c] = importNiCADfile(path+"type3_2c_reportedClones.txt");
report=[report_type3_2;report_type3_2c];
report=[report;report(:,2) report(:,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from SourcererCC
col=5;
sim=0.5;
sim=sim*10;
path="/home/cat409/Programs/RelatedWork/SourcererCC/experiments/BCB-ERA-latest/";
[files]=importSourcererCCfile(path+"files.txt");
report1=importSourcererCCreport(path+"sim-0." ...
    +int2str(sim)+"/NODE_1/output"+int2str(sim)+".0/query_1clones_index_WITH_FILTER.txt");
report2=importSourcererCCreport(path+"sim-0." ...
    +int2str(sim)+"/NODE_2/output"+int2str(sim)+".0/query_2clones_index_WITH_FILTER.txt");
report=[report1;report2];
reportA=table(report(:,2),'VariableName',{'fileid'});
reportA=join(reportA,files);
reportedClones(:,1)=table2array(reportA(:,2));
reportB=table(report(:,4),'VariableName',{'fileid'});
reportB=join(reportB,files);
reportedClones(:,2)=table2array(reportB(:,2));
report=[reportedClones;reportedClones(:,2) reportedClones(:,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from Deckard
col=6;
sim=0.8;
path="/home/cat409/Programs/RelatedWork/Deckard/experiments/BCB-ERA-latest/reports/";
[funcID_one_clone, funcID_two_clone] = importDeckardfile(path+"clones/report-10_2_0."+int2str(10*sim)+".txt");
[funcID_one_false, funcID_two_false] = importDeckardfile(path+"falseAlerm/report-10_2_0."+int2str(10*sim)+".txt");
funcID_one=[funcID_one_clone;funcID_one_false];
funcID_two=[funcID_two_clone;funcID_two_false];
reportedClones=[funcID_one funcID_two];
report=[reportedClones;reportedClones(:,2) reportedClones(:,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from CloneWorks
col=7;
sim=0.6;
path="/home/cat409/Programs/RelatedWork/CloneWorks/experiments/results/function-level/BCB-ERA-latest/";
sim=sim*10;
[fileid,type,name] = importCloneWorksfile(path+"files.txt");
report_type1 = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type1.clones");
report_type2blind = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type2blind.clones");
report_type2systematic = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type2systematic.clones");
report_type3pattern = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type3pattern.clones");
report_type3token = importCloneWorksreport(path+"sim-0."...
    +int2str(sim)+"/type3token.clones");
report=[report_type1;report_type2blind;report_type2systematic;report_type3pattern;report_type3token];
name=cellstr(name);
type=cellstr(type);
files=table(name,type,fileid,'VariableName',{'name','type','fileid'});
functions=join(functions,files);
report=array2table(report,'VariableName',{'fileidA','startlineA','endlineA','fileidB','startlineB','endlineB'});
functionsA=functions(:,[6 3 4 5]);
functionsA.Properties.VariableNames{1} = 'fileidA';
functionsA.Properties.VariableNames{2} = 'startlineA';
functionsA.Properties.VariableNames{3} = 'endlineA';
functionsA.Properties.VariableNames{4} = 'idA';
report=outerjoin(report,functionsA,'LeftKeys',[1 2 3],'RightKeys',[1 2 3]);
functionsB=functions(:,[6 3 4 5]);
functionsB.Properties.VariableNames{1} = 'fileidB';
functionsB.Properties.VariableNames{2} = 'startlineB';
functionsB.Properties.VariableNames{3} = 'endlineB';
functionsB.Properties.VariableNames{4} = 'idB';
report=outerjoin(report,functionsB,'LeftKeys',[4 5 6],'RightKeys',[1 2 3]);
reportedClones=table2array(report(:,[10 14]));
idx=(reportedClones(:,1).*reportedClones(:,2)>0);
reportedClones=reportedClones(idx,:);
report=[reportedClones;reportedClones(:,2) reportedClones(:,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from Oreo
col=8;
sim=0.3;
path="/home/cat409/Programs/RelatedWork/Oreo/experiments/BCB-ERA-latest/";
sim=sim*10;
[report] = importOreoreport(path+"reportedClones_0."...
    +int2str(sim)+".txt");
num=size(report,1);
reportedClones=zeros(num,2);
func_one=report(:,1:4);
func_one.Properties.VariableNames{1} = 'type';
func_one.Properties.VariableNames{2} = 'name';
func_one.Properties.VariableNames{3} = 'startline';
func_one.Properties.VariableNames{4} = 'endline';
[exactFunc_one,idx]=ismember(func_one,functions(:,1:4));
reportedClones(exactFunc_one,1)=table2array(functions(idx(exactFunc_one),5));
func_two=report(:,5:8);
func_two.Properties.VariableNames{1} = 'type';
func_two.Properties.VariableNames{2} = 'name';
func_two.Properties.VariableNames{3} = 'startline';
func_two.Properties.VariableNames{4} = 'endline';
[exactFunc_two,idx]=ismember(func_two,functions(:,1:4));
reportedClones(exactFunc_two,2)=table2array(functions(idx(exactFunc_two),5));
report=[reportedClones;reportedClones(:,2) reportedClones(:,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from NIL
col=9;
path="/home/cat409/Programs/RelatedWork/NIL/experiments/BCB/";
sim=0.3;
sim=sim*100;
[report] = importOreoreport(path+"result_5_10_"...
    +int2str(sim)+".txt");
num=size(report,1);
reportedClones=zeros(num,2);
func_one=report(:,1:4);
func_one.Properties.VariableNames{1} = 'type';
func_one.Properties.VariableNames{2} = 'name';
func_one.Properties.VariableNames{3} = 'startline';
func_one.Properties.VariableNames{4} = 'endline';
[exactFunc_one,idx]=ismember(func_one,functions(:,1:4));
reportedClones(exactFunc_one,1)=table2array(functions(idx(exactFunc_one),5));
func_two=report(:,5:8);
func_two.Properties.VariableNames{1} = 'type';
func_two.Properties.VariableNames{2} = 'name';
func_two.Properties.VariableNames{3} = 'startline';
func_two.Properties.VariableNames{4} = 'endline';
[exactFunc_two,idx]=ismember(func_two,functions(:,1:4));
reportedClones(exactFunc_two,2)=table2array(functions(idx(exactFunc_two),5));
report=[reportedClones;reportedClones(:,2) reportedClones(:,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from ASTNN
col=10;
sim=0.8;
path="/home/cat409/Programs/RelatedWork/ASTNN/experiments/java/reports/bilabel/";
reportT1=importASTNNreport(path+"report-T1.txt");
reportT2=importASTNNreport(path+"report-T2.txt");
reportT3=importASTNNreport(path+"report-T3.txt");
reportT4=importASTNNreport(path+"report-T4.txt");
reportT5=importASTNNreport(path+"report-T5.txt");
reportT6=importASTNNreport(path+"report-T6.txt");
reportT0=importASTNNreport(path+"report-T0.txt");
report=[reportT1;reportT2;reportT3;reportT4;reportT5;reportT6;reportT0];
report=table2array(report);
idx=report(:,4)>=sim;
report=[report(idx,1:2);report(idx,2) report(idx,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from Code2vec
col=11;
sim=0.5;
path="/home/cat409/Programs/RelatedWork/Code2vec/experiments/BCB-ERA-latest/";
[filename,vectors] = importCode2Vecfile(path+"codeVectors.txt");
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
[report] = CosineSimilairyByVectors(functionID,vectors,samples(:,1:3));
idx=report(:,4)>=sim;
report=[report(idx,1:2);report(idx,2) report(idx,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from Infercode
col=12;
sim=0.9;
path="/home/cat409/Programs/RelatedWork/Infercode/experiments/BCB-ERA-latest/";
[filename,vectors] = importInfercodefile(path+"codeVectors.txt");
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
[report] = CosineSimilairyByVectors(functionID,vectors,samples(:,1:3));
idx=report(:,4)>=sim;
report=[report(idx,1:2);report(idx,2) report(idx,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

%% get report from GraphMatch
% col=13;
% sim=0;
% path="/home/cat409/Programs/RelatedWork/GraphMatch_Clone/experiments/";
% [id_one, id_two, ~] = importGraphMatchfile(path+"testdata-GT.txt");
% [~,idx]=ismember([id_one id_two],samples(:,1:2),"rows");
% label=samples(idx,3);
% [similarity] = importGraphMatchreport(path+"/Retrained/BCB-report.txt");
% report=[id_one id_two label similarity];
% idx=report(:,4)>=sim;
% report=[report(idx,1:2);report(idx,2) report(idx,1)];
% idx=ismember(samples(:,1:2),report,'rows');
% samples(idx,col)=1;

%% get report from Siamese
col=14;
path="/home/cat409/Programs/RelatedWork/Siamese/experiments/BCB-ERA-latest/sim-0.08/";
report = importSiamesereport(path+"/clones.txt");
idx=report(:,1)~=report(:,2);
reportedClones=report(idx,:);
report=[reportedClones;reportedClones(:,2) reportedClones(:,1)];
idx=ismember(samples(:,1:2),report,'rows');
samples(idx,col)=1;

end

