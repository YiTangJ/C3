clear;
benchmarkPath="GroundTruth-BCB/BCBenchmark.mat";
[benchmarkStats,clones,false_positives] = analysisBenchmark(benchmarkPath);
flagPairwise=1;
pairs=importPairsfile('GroundTruth-BCB/samples.txt');
reducedFunctionsID=unique([table2array(clones(:,1));table2array(clones(:,2))]);
flagReduce=1;

%% analyze results in NiCad
path="/home/cat409/Programs/RelatedWork/NiCad-6.2/experiments/BCB-ERA-latest/";
[report_type3_2] = importNiCADfile(path+"type3_2_reportedClones.txt");
[report_type3_2c] = importNiCADfile(path+"type3_2c_reportedClones.txt");
reportedClones=[report_type3_2;report_type3_2c];
if flagReduce
    [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
end
[results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
results_NiCad=results;

%% analyze results in SourcererCC
path="/home/cat409/Programs/RelatedWork/SourcererCC/experiments/BCB-ERA-latest/";
simRange=(0.4:0.1:0.8)';
results_SourcererCC.simRange=simRange;
simNum=size(simRange,1);
for i=1:simNum
    [reportedClones] = getReport_SourcererCC(path,simRange(i));
    if flagReduce
        [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
    end
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_SourcererCC.results{i,1}=results;
end

%% analyze results in CloneWorks
load(benchmarkPath,"functions");
path="/home/cat409/Programs/RelatedWork/CloneWorks/experiments/results/function-level/BCB-ERA-latest/";
simRange=(0.6:0.1:0.8)';
results_CloneWorks.simRange=simRange;
simNum=size(simRange,1);
for i=1:simNum
    [reportedClones] = getReport_CloneWorks(path,simRange(i),functions);
    if flagReduce
        [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
    end
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_CloneWorks.results{i,1}=results;
end

%% analyze results in Deckard
path="/home/cat409/Programs/RelatedWork/Deckard/experiments/BCB-ERA-latest/reports/";
simRange=(0.8:0.1:0.9)';
results_Deckard.simRange=simRange;
simNum=size(simRange,1);
for i=1:simNum
    [reportedClones] = getReport_Deckard(path,simRange(i));
    if flagReduce
        [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
    end
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_Deckard.results{i,1}=results;
end

%% analyze results in Oreo
path="/home/cat409/Programs/RelatedWork/Oreo/experiments/BCB-ERA-latest/";
simRange=(0.3:0.1:0.8)';
results_Oreo.simRange=simRange;
simNum=size(simRange,1);
for i=1:simNum
    [reportedClones] = getReport_BCEreport(path,simRange(i),functions);
    if flagReduce
        [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
    end
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_Oreo.results{i,1}=results;
end

%% analyze results in NIL
path="/home/cat409/Programs/RelatedWork/NIL/experiments/BCB/";
simRange=(0.1:0.1:0.9)';
results_NIL.simRange=simRange;
simNum=size(simRange,1);
for i=1:simNum
    [reportedClones] = getReport_BCEreport(path,simRange(i),functions);
    if flagReduce
        [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
    end
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_NIL.results{i,1}=results;
end

%% analyze results in Siamese
path="/home/cat409/Programs/RelatedWork/Siamese/experiments/BCB-ERA-latest/";
simRange=[0.08;0.1;0.3;0.5];
str=["0.08";"0.1";"0.3";"0.5"];
results_Siamese.simRange=simRange;
simNum=size(simRange,1);
for i=1:simNum
    [reportedClones] = getReport_Siamese(path+"/sim-"+str(i));
    if flagReduce
        [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
    end
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_Siamese.results{i,1}=results;
end

%% analyze results in ASTNN
path="/home/cat409/Programs/RelatedWork/ASTNN/experiments/java/originalData/";
samples=importPairsfile(path+'bcb_pair_ids.txt');
[samplesStats_ASTNN_orig] = analysisSamples(samples,benchmarkPath);
path="/home/cat409/Programs/RelatedWork/ASTNN/experiments/java/";
samples=importPairsfile(path+'bcb_pair_ids.txt');
[samplesStats_ASTNN_new] = analysisSamples(samples,benchmarkPath);
if flagPairwise
    path="/home/cat409/Programs/RelatedWork/ASTNN/experiments/java/reports/bilabel/";
    simRange=(0.8:0.05:0.95)';
    results_ASTNN.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        [report] = getReport_ASTNN(path);
        report=table2array(report);
        prediction=zeros(size(report,1),1);
        idx=report(:,4)>=simRange(i);
        prediction(idx,1)=1;
        prediction(~idx,1)=-1;
        reportedClones=[report(:,1:2) prediction];
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_ASTNN.results{i,1}=results;
    end
end

%% analyze results in FA-AST
path="/home/cat409/Programs/RelatedWork/FA-AST/experiments/";
samples=importPairsfile(path+'traindata-orig-pairs.txt');
[samplesStats_FAAST_orig] = analysisSamples(samples,benchmarkPath);
samples=importPairsfile(path+'traindata-balanced-pairs.txt');
[samplesStats_FAAST_new] = analysisSamples(samples,benchmarkPath);
if flagPairwise
    [id_one, id_two, ~] = importFAASTfile(path+"testdata-GT-BCE.txt");
    [~,idx]=ismember([id_one id_two],pairs(:,1:2),"rows");
    label=pairs(idx(idx~=0),3);
    idx=idx~=0;
    id_one=id_one(idx,:);
    id_two=id_two(idx,:);
    [similarity] = importFAASTreport(path+"/TrainingbyOriginalData/BCB-BCE-report.txt");
    similarity_orig=similarity(idx,:);
    [similarity] = importFAASTreport(path+"/Retrained/BCB-BCE-report.txt");
    similarity_new=similarity(idx,:);
    report=[id_one id_two label similarity_orig];
    simRange=(0.5:0.1:0.9)';
    results_FAAST_orig.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        prediction=zeros(size(report,1),1);
        idx=report(:,4)>=simRange(i);
        prediction(idx,1)=1;
        prediction(~idx,1)=-1;
        reportedClones=[report(:,1:2) prediction];
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_FAAST_orig.results{i,1}=results;
    end
    report=[id_one id_two label similarity_new];
    simRange=(0.5:0.1:0.9)';
    results_FAAST_new.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        prediction=zeros(size(report,1),1);
        idx=report(:,4)>=simRange(i);
        prediction(idx,1)=1;
        prediction(~idx,1)=-1;
        reportedClones=[report(:,1:2) prediction];
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_FAAST_new.results{i,1}=results;
    end
end
if flagReduce
    [id_one, id_two, ~] = importFAASTfile(path+"testdata-BCB-reduced.txt");
    [similarity_orig] = importFAASTreport(path+"/TrainingbyOriginalData/BCB-reduced-report.txt");
    [similarity_new] = importFAASTreport(path+"/Retrained/BCB-reduced-report.txt");
    report=[id_one id_two similarity_orig];
    simRange=(0.5:0.1:0.9)';
    results_FAAST_orig_reduced.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        idx=report(:,3)>=simRange(i);
        reportedClones=report(idx,1:2);
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_FAAST_orig_reduced.results{i,1}=results;
    end
    report=[id_one id_two similarity_new];
    simRange=(0.5:0.1:0.9)';
    results_FAAST_new_reduced.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        idx=report(:,3)>=simRange(i);
        reportedClones=report(idx,1:2);
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_FAAST_new_reduced.results{i,1}=results;
    end
end

%% analyze results in Amain
path="/home/cat409/Programs/RelatedWork/Amain/dataset/BCB/";
samples_P=importPairsfile(path+'BCB_clone.csv');
samples_P=[samples_P(:,1:2) ones(size(samples_P,1),1)];
samples_N=importPairsfile(path+'BCB_nonclone.csv');
samples_N=[samples_N(:,1:2) -1*ones(size(samples_N,1),1)];
samples=[samples_P;samples_N];
[samplesStats_Amain_orig] = analysisSamples(samples,benchmarkPath);
samples_P=importPairsfile(path+'samples_clone.csv');
samples_P=[samples_P(:,1:2) ones(size(samples_P,1),1)];
samples_N=importPairsfile(path+'samples_nonclone.csv');
samples_N=[samples_N(:,1:2) -1*ones(size(samples_N,1),1)];
samples=[samples_P;samples_N];
[samplesStats_Amain_new] = analysisSamples(samples,benchmarkPath);
path="/home/cat409/Programs/RelatedWork/Amain/experiments/BCB/results/";
if flagPairwise
    [report] = importAmainreport(path+"results-rate-10-BCE.txt");
    reportedClones=table2array(report);
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_Amain_orig=results;
    [report] = importAmainreport(path+"results-retrained-rate-10-BCE.txt");
    reportedClones=table2array(report);
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_Amain_new=results;
end
if flagReduce
    [report] = importAmainreport(path+"results-BCB-reduced-rate-10.txt");
    report=table2array(report);
    idx=report(:,3)==1;
    reportedClones=report(idx,1:2);
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_Amain_orig_reduced=results;
    [report] = importAmainreport(path+"results-BCB-reduced-retrained-rate-10.txt");
    report=table2array(report);
    idx=report(:,3)==1;
    reportedClones=report(idx,1:2);
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_Amain_new_reduced=results;
end

%% analyze results in UniXcoder
path="/home/cat409/Programs/RelatedWork/CodeBERT/UniXcoder/downstream-tasks/clone-detection/BCB/dataset/";
samples=importPairsfile(path+'train.txt');
[samplesStats_UniXcoder] = analysisSamples(samples,benchmarkPath);
path="/home/cat409/Programs/RelatedWork/CodeBERT/UniXcoder/downstream-tasks/clone-detection/BCB/experiments/results/";
if flagPairwise
    [report] = importUniXcoderreport(path+"predictions_samples-latest.txt");
    idx=report(:,4)>0.5;
    label=zeros(size(report,1),1);
    label(idx)=1;
    reportedClones=[report(:,1:2) label];
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_UniXcoder=results;
end
if flagReduce
    [report] = importUniXcoderreport(path+"predictions_testdate-reduced.txt");
    idx=report(:,4)>0.5;
    reportedClones=[report(idx,1:2)];
    [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_UniXcoder_reduced=results;
end

%% analyze results in GraphCodeBERT
path="/home/cat409/Programs/RelatedWork/CodeBERT/GraphCodeBERT/clonedetection/dataset/";
samples=importPairsfile(path+'train.txt');
[samplesStats_GraphCodeBERT] = analysisSamples(samples,benchmarkPath);
path="/home/cat409/Programs/RelatedWork/CodeBERT/GraphCodeBERT/clonedetection/experiments/results/";
if flagPairwise
    [report] = importGraphCodeBERTreport(path+"predictions_samples-latest.txt");
    idx=report(:,3)>0.5;
    label=zeros(size(report,1),1);
    label(idx)=1;
    reportedClones=[report(:,1:2) label];
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_GraphCodeBERT=results;
end
if flagReduce
    [report] = importGraphCodeBERTreport(path+"predictions_testdate-reduced.txt");
    idx=report(:,3)>0.5;
    reportedClones=[report(idx,1:2)];
    [reportedClones] = reduceReports(reportedClones,reducedFunctionsID);
    [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
    results_GraphCodeBERT_reduced=results;
end

%% analyze results in Code2vec
path="/home/cat409/Programs/RelatedWork/Code2vec/experiments/BCB-ERA-latest/";
[filename,vectors] = importCode2Vecfile(path+"codeVectors.txt");
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
if flagPairwise
    [report] = CosineSimilairyByVectors(functionID,vectors,pairs);
    simRange=(0.5:0.1:0.9)';
    results_Code2vec_Pairwise.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        prediction=zeros(size(report,1),1);
        idx=report(:,4)>=simRange(i);
        prediction(idx,1)=1;
        prediction(~idx,1)=-1;
        reportedClones=[report(:,1:2) prediction];
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_Code2vec_Pairwise.results{i,1}=results;
    end
end
if flagReduce
    func=unique([table2array(clones(:,1));table2array(clones(:,2))]);
    num=size(func,1);
    newpairs=zeros(num*(num-1)/2,2);
    count=0;
    for i=1:num-1
        newpairs(count+1:count+num-i,:)=[repmat(func(i),num-i,1) func(i+1:num)];
        count=count+num-i;
    end
    newpairs=[newpairs zeros(size(newpairs,1),1)];
    [report] = CosineSimilairyByVectors(functionID,vectors,newpairs);
    simRange=(0.5:0.1:0.9)';
    results_Code2vec_reduced.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        idx=report(:,4)>=simRange(i);
        reportedClones=report(idx,1:2);
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_Code2vec_reduced.results{i,1}=results;
    end
end

%% analyze results in Infercode
path="/home/cat409/Programs/RelatedWork/Infercode/experiments/BCB-ERA-latest/";
[filename,vectors] = importInfercodefile(path+"codeVectors.txt");
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
if flagPairwise
    [report] = CosineSimilairyByVectors(functionID,vectors,pairs);
    simRange=(0.5:0.1:0.9)';
    results_Infercode_Pairwise.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        prediction=zeros(size(report,1),1);
        idx=report(:,4)>=simRange(i);
        prediction(idx,1)=1;
        prediction(~idx,1)=-1;
        reportedClones=[report(:,1:2) prediction];
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_Infercode_Pairwise.results{i,1}=results;
    end
end
if flagReduce
    func=unique([table2array(clones(:,1));table2array(clones(:,2))]);
    num=size(func,1);
    newpairs=zeros(num*(num-1)/2,2);
    count=0;
    for i=1:num-1
        newpairs(count+1:count+num-i,:)=[repmat(func(i),num-i,1) func(i+1:num)];
        count=count+num-i;
    end
    newpairs=[newpairs zeros(size(newpairs,1),1)];
    [report] = CosineSimilairyByVectors(functionID,vectors,newpairs);
    simRange=(0.5:0.1:0.9)';
    results_Infercode_reduced.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        idx=report(:,4)>=simRange(i);
        reportedClones=report(idx,1:2);
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_Infercode_reduced.results{i,1}=results;
    end
end

%% analyze results in MiniMax Embedding Model "embo-01"
path="/home/cat409/Programs/RelatedWork/MiniMax/experiments/BCB-ERA/";
data=readtable(path+"codeVectors.txt");
filename=table2array(data(:,1));
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
vectors=table2array(data(:,2:1537));
if flagPairwise
    [report] = CosineSimilairyByVectors(functionID,vectors,pairs);
    simRange=(0.5:0.1:0.9)';
    results_MiniMaxEmbedding_Pairwise.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        prediction=zeros(size(report,1),1);
        idx=report(:,4)>=simRange(i);
        prediction(idx,1)=1;
        prediction(~idx,1)=-1;
        reportedClones=[report(:,1:2) prediction];
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_MiniMaxEmbedding_Pairwise.results{i,1}=results;
    end
end
if flagReduce
    func=unique([table2array(clones(:,1));table2array(clones(:,2))]);
    num=size(func,1);
    newpairs=zeros(num*(num-1)/2,2);
    count=0;
    for i=1:num-1
        newpairs(count+1:count+num-i,:)=[repmat(func(i),num-i,1) func(i+1:num)];
        count=count+num-i;
    end
    newpairs=[newpairs zeros(size(newpairs,1),1)];
    [report] = CosineSimilairyByVectors(functionID,vectors,newpairs);
    simRange=(0.5:0.1:0.9)';
    results_MiniMaxEmbedding_reduced.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        idx=report(:,4)>=simRange(i);
        reportedClones=report(idx,1:2);
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_MiniMaxEmbedding_reduced.results{i,1}=results;
    end
end

%% analyze results in OpenAI Embedding Model "text-embedding-ada-002"
path="/home/cat409/Programs/RelatedWork/OpenAI/experiments/BCB-ERA/";
data=readtable(path+"codeVectors.txt");
filename=table2array(data(:,1));
functionID=split(filename,".");
functionID=str2double(functionID(:,1));
vectors=table2array(data(:,2:1537));
if flagPairwise
    [report] = CosineSimilairyByVectors(functionID,vectors,pairs);
    simRange=(0.5:0.1:0.9)';
    results_OpenAIEmbedding_Pairwise.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        prediction=zeros(size(report,1),1);
        idx=report(:,4)>=simRange(i);
        prediction(idx,1)=1;
        prediction(~idx,1)=-1;
        reportedClones=[report(:,1:2) prediction];
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_OpenAIEmbedding_Pairwise.results{i,1}=results;
    end
end
if flagReduce
    func=unique([table2array(clones(:,1));table2array(clones(:,2))]);
    num=size(func,1);
    newpairs=zeros(num*(num-1)/2,2);
    count=0;
    for i=1:num-1
        newpairs(count+1:count+num-i,:)=[repmat(func(i),num-i,1) func(i+1:num)];
        count=count+num-i;
    end
    newpairs=[newpairs zeros(size(newpairs,1),1)];
    [report] = CosineSimilairyByVectors(functionID,vectors,newpairs);
    simRange=(0.5:0.1:0.9)';
    results_OpenAIEmbedding_reduced.simRange=simRange;
    simNum=size(simRange,1);
    for i=1:simNum
        idx=report(:,4)>=simRange(i);
        reportedClones=report(idx,1:2);
        [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
        results_OpenAIEmbedding_reduced.results{i,1}=results;
    end
end
