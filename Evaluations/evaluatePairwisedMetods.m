% load('BCBenchmark.mat', 'clones', 'false_positives')
load('G:/ECCD/ECCD/GroundTruth-BCB/BCBenchmark.mat', 'clones', 'false_positives')
pairs=importPairsfile('G:/ECCD/ECCD/GroundTruth-BCB/samples.txt');

%% analyze results in ASTNN
recall_astnn=zeros(3,6);
hitNum_astnn=zeros(3,6);
precision_astnn=zeros(3,1);
recall_learning_astnn=zeros(3,1);
F1score_astnn=zeros(3,1);
falseAlarmNum_astnn=zeros(3,1);
%path="/home/cat409/Programs/RelatedWork/ASTNN/experiments/java/reports/bilabel/";
path="G:/ECCD/data/ASTNN/experiments/java/reports/bilabel/";
[traditionalMetrics,LearningMetrics] = analysisASTNN_BCB_CCD(path,0.8,clones,false_positives);
recall_astnn(1,:)=traditionalMetrics.recall;
hitNum_astnn(1,:)=traditionalMetrics.hitNum;
precision_astnn(1,:)=LearningMetrics.precision;
recall_learning_astnn(1,:)=LearningMetrics.recall;
F1score_astnn(1,:)=LearningMetrics.F1score;
falseAlarmNum_astnn(1,:)=LearningMetrics.falseAlarm;
[traditionalMetrics,LearningMetrics] = analysisASTNN_BCB_CCD(path,0.9,clones,false_positives);
recall_astnn(2,:)=traditionalMetrics.recall;
hitNum_astnn(2,:)=traditionalMetrics.hitNum;
precision_astnn(2,:)=LearningMetrics.precision;
recall_learning_astnn(2,:)=LearningMetrics.recall;
F1score_astnn(2,:)=LearningMetrics.F1score;
falseAlarmNum_astnn(2,:)=LearningMetrics.falseAlarm;
[traditionalMetrics,LearningMetrics] = analysisASTNN_BCB_CCD(path,0.95,clones,false_positives);
recall_astnn(3,:)=traditionalMetrics.recall;
hitNum_astnn(3,:)=traditionalMetrics.hitNum;
precision_astnn(3,:)=LearningMetrics.precision;
recall_learning_astnn(3,:)=LearningMetrics.recall;
F1score_astnn(3,:)=LearningMetrics.F1score;
falseAlarmNum_astnn(3,:)=LearningMetrics.falseAlarm;

%% analyze results in Code2vec
recall_code2vec=zeros(3,6);
hitNum_code2vec=zeros(3,6);
precision_code2vec=zeros(3,1);
recall_learning_code2vec=zeros(3,1);
F1score_code2vec=zeros(3,1);
falseAlarmNum_code2vec=zeros(3,1);
%path="/home/cat409/Programs/RelatedWork/Code2vec/experiments/BCB-ERA-latest/";
path="G:/ECCD/data/Code2vec/experiments/BCB-ERA-latest/";
[filename,vectors] = importCode2Vecfile(path+"codeVectors.txt");
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
[report] = CosineSimilairyByVectors(functionID,vectors,pairs);
[traditionalMetrics,LearningMetrics] = analysisPairwisedCCD(report,0.5,clones,false_positives);
recall_code2vec(1,:)=traditionalMetrics.recall;
hitNum_code2vec(1,:)=traditionalMetrics.hitNum;
precision_code2vec(1,:)=LearningMetrics.precision;
recall_learning_code2vec(1,:)=LearningMetrics.recall;
F1score_code2vec(1,:)=LearningMetrics.F1score;
falseAlarmNum_code2vec(1,:)=LearningMetrics.falseAlarm;
[traditionalMetrics,LearningMetrics] = analysisPairwisedCCD(report,0.6,clones,false_positives);
recall_code2vec(2,:)=traditionalMetrics.recall;
hitNum_code2vec(2,:)=traditionalMetrics.hitNum;
precision_code2vec(2,:)=LearningMetrics.precision;
recall_learning_code2vec(2,:)=LearningMetrics.recall;
F1score_code2vec(2,:)=LearningMetrics.F1score;
falseAlarmNum_code2vec(2,:)=LearningMetrics.falseAlarm;
[traditionalMetrics,LearningMetrics] = analysisPairwisedCCD(report,0.7,clones,false_positives);
recall_code2vec(3,:)=traditionalMetrics.recall;
hitNum_code2vec(3,:)=traditionalMetrics.hitNum;
precision_code2vec(3,:)=LearningMetrics.precision;
recall_learning_code2vec(3,:)=LearningMetrics.recall;
F1score_code2vec(3,:)=LearningMetrics.F1score;
falseAlarmNum_code2vec(3,:)=LearningMetrics.falseAlarm;

%% analyze results in Infercode
recall_infercode=zeros(3,6);
hitNum_infercode=zeros(3,6);
precision_infercode=zeros(3,1);
recall_learning_infercode=zeros(3,1);
F1score_infercode=zeros(3,1);
falseAlarmNum_infercode=zeros(3,1);
%path="/home/cat409/Programs/RelatedWork/Infercode/experiments/BCB-ERA-latest/";
path="G:/ECCD/data/Infercode/experiments/BCB-ERA-latest/";
[filename,vectors] = importInfercodefile(path+"codeVectors.txt");
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
[report] = CosineSimilairyByVectors(functionID,vectors,pairs);
[traditionalMetrics,LearningMetrics] = analysisPairwisedCCD(report,0.8,clones,false_positives);
recall_infercode(1,:)=traditionalMetrics.recall;
hitNum_infercode(1,:)=traditionalMetrics.hitNum;
precision_infercode(1,:)=LearningMetrics.precision;
recall_learning_infercode(1,:)=LearningMetrics.recall;
F1score_infercode(1,:)=LearningMetrics.F1score;
falseAlarmNum_infercode(1,:)=LearningMetrics.falseAlarm;
[traditionalMetrics,LearningMetrics] = analysisPairwisedCCD(report,0.9,clones,false_positives);
recall_infercode(2,:)=traditionalMetrics.recall;
hitNum_infercode(2,:)=traditionalMetrics.hitNum;
precision_infercode(2,:)=LearningMetrics.precision;
recall_learning_infercode(2,:)=LearningMetrics.recall;
F1score_infercode(2,:)=LearningMetrics.F1score;
falseAlarmNum_infercode(2,:)=LearningMetrics.falseAlarm;
[traditionalMetrics,LearningMetrics] = analysisPairwisedCCD(report,0.95,clones,false_positives);
recall_infercode(3,:)=traditionalMetrics.recall;
hitNum_infercode(3,:)=traditionalMetrics.hitNum;
precision_infercode(3,:)=LearningMetrics.precision;
recall_learning_infercode(3,:)=LearningMetrics.recall;
F1score_infercode(3,:)=LearningMetrics.F1score;
falseAlarmNum_infercode(3,:)=LearningMetrics.falseAlarm;

%% analyze results in FA-AST
TrainingNum=2;
recall_faast=zeros(TrainingNum,6);
hitNum_faast=zeros(TrainingNum,6);
precision_faast=zeros(TrainingNum,1);
recall_learning_faast=zeros(TrainingNum,1);
F1score_faast=zeros(TrainingNum,1);
falseAlarmNum_faast=zeros(TrainingNum,1);
%path="/home/cat409/Programs/RelatedWork/FA-AST/experiments/";
path="G:/ECCD/data/FA-AST/experiments/";
[id_one, id_two, ~] = importFAASTfile(path+"testdata-GT.txt");
[~,idx]=ismember([id_one id_two],pairs(:,1:2),"rows");
label=pairs(idx(idx~=0),3);
idx=idx~=0;
id_one=id_one(idx,:);
id_two=id_two(idx,:);
[similarity] = importFAASTreport(path+"/Retrained/BCB-report.txt");
similarity=similarity(idx,:);
report=[id_one id_two label similarity];
[traditionalMetrics,LearningMetrics] = analysisPairwisedCCD(report,0,clones,false_positives);
recall_faast(1,:)=traditionalMetrics.recall;
hitNum_faast(1,:)=traditionalMetrics.hitNum;
precision_faast(1,:)=LearningMetrics.precision;
recall_learning_faast(1,:)=LearningMetrics.recall;
F1score_faast(1,:)=LearningMetrics.F1score;
falseAlarmNum_faast(1,:)=LearningMetrics.falseAlarm;
[similarity] = importFAASTreport(path+"/TrainingbyOriginalData/BCB-report.txt");
similarity=similarity(idx,:);
report=[id_one id_two label similarity];
[traditionalMetrics,LearningMetrics] = analysisPairwisedCCD(report,0,clones,false_positives);
recall_faast(2,:)=traditionalMetrics.recall;
hitNum_faast(2,:)=traditionalMetrics.hitNum;
precision_faast(2,:)=LearningMetrics.precision;
recall_learning_faast(2,:)=LearningMetrics.recall;
F1score_faast(2,:)=LearningMetrics.F1score;
falseAlarmNum_faast(2,:)=LearningMetrics.falseAlarm;

clear path filename vectors functionID report...
    traditionalMetrics LearningMetrics TrainingNum i id_one id_two...
    idx label similarity;