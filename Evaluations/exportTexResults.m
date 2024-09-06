function [resultsTable] = exportTexResults(tableType)
%EXPORTTEXRESULTS 此处显示有关此函数的摘要
%   此处显示详细说明

load("results-uniAnalysis-CCDTools.mat");
if tableType=="Precision-traditional-BCE"||tableType=="Precision-learning-BCE"
    load("results-uniAnalysis-CCDTools-BCE-reduced.mat");
end
% load("results-uniAnalysis-TreeSeqCC.mat");唐艺嘉注释掉了
% load("results-uniAnalysis-BCE-reduced.mat");

tools=["NiCad" "-";...
    "SourcererCC" "0.7";...
    "SourcererCC" "0.6";...
    "CloneWorks" "0.7";...
    "CloneWorks" "0.6";...
    "Deckard" "0.9";...
    "Deckard" "0.8";...
    "Oreo" "0.6";...
    "Oreo" "0.3";...
    "NIL" "0.5";...
    "NIL" "0.3";...
    "ASTNN" "0.9";...
    "ASTNN" "0.8";...
    "FAAST" "0.7";...
    "FAAST" "0.7(retrained)";...
    "Amain" "-";...
    "Amain" "retrained";...
    "UniXcoder" "-"; ...
    "GraphCodeBERT" "-"; ...
    "Code2vec" "0.7";...
    "Code2vec" "0.5";...
    "Infercode" "0.9";...
    "Infercode" "0.8";...
    "TreeSeqCC" "0.9";...
    ];

if tableType=="Recall"
    [rows,~]=size(tools);
    cols=15;
    recall=zeros(rows,cols);
    funcNum=312103;
    for i=1:rows
        toolname=tools(i,1);
        config=tools(i,2);
        switch toolname
            case "NiCad"
                results=results_NiCad;
            case "SourcererCC"
                config=floor(str2double(config)*10);
                idx=config==floor(results_SourcererCC.simRange*10);
                results=results_SourcererCC.results{idx};
            case "CloneWorks"
                config=floor(str2double(config)*10);
                idx=config==floor(results_CloneWorks.simRange*10);
                results=results_CloneWorks.results{idx};
            case "Deckard"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Deckard.simRange*10);
                results=results_Deckard.results{idx};
            case "Oreo"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Oreo.simRange*10);
                results=results_Oreo.results{idx};
            case "NIL"
                config=floor(str2double(config)*10);
                idx=config==floor(results_NIL.simRange*10);
                results=results_NIL.results{idx};
            case "ASTNN"
                config=floor(str2double(config)*10);
                idx=config==floor(results_ASTNN.simRange*10);
                results=results_ASTNN.results{idx};
            case "FAAST"
                if contains(config,"retrained")
                    config=split(config,"(");
                    config=config(1);
                    config=floor(str2double(config)*10);
                    idx=config==floor(results_FAAST_new.simRange*10);
                    results=results_FAAST_new.results{idx};
                else
                    config=floor(str2double(config)*10);
                    idx=config==floor(results_FAAST_orig.simRange*10);
                    results=results_FAAST_orig.results{idx};
                end
            case "Amain"
                if contains(config,"retrained")
                    results=results_Amain_new;
                else
                    results=results_Amain_orig;
                end
            case "UniXcoder"
                results=results_UniXcoder;
            case "GraphCodeBERT"
                results=results_GraphCodeBERT;
            case "Code2vec"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Code2vec_Pairwise.simRange*10);
                results=results_Code2vec_Pairwise.results{idx};
            case "Infercode"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Infercode_Pairwise.simRange*10);
                results=results_Infercode_Pairwise.results{idx};
            % case "TreeSeqCC"
            %     results=results_TreeSeqCC_learning;
            %     results.Num_Reported=results.Num_Positives;
        end
        recall(i,:)=[results.Num_Reported results.Num_Reported/funcNum/funcNum*10000 ...
            results.Positives_Recall(1) results.Positives_HitNum(1)...
            results.Positives_Recall(2) results.Positives_HitNum(2)...
            results.Positives_Recall(3) results.Positives_HitNum(3)...
            results.Positives_Recall(4) results.Positives_HitNum(4)...
            results.Positives_Recall(5) results.Positives_HitNum(5)...
            results.Positives_Recall(6) results.Positives_HitNum(6)...
            results.Positives_False_Alarm];
    end
    resultsTable=recall;
end
if tableType=="BCE-Recall"
    % path="/home/cat409/Programs/RelatedWork/BigCloneEval/Eval/Recall/";
    path="G:/ECCD/data/BigCloneEval/Eval/Recall/";
    [rows,~]=size(tools);
    cols=18;
    recall=zeros(rows,cols);
    baseline = importBCEReportfile(path+"recall-Baseline.txt");
    baseline=repmat(baseline,rows,1);
    for i=1:rows
        toolname=tools(i,1);
        config=tools(i,2);
        switch toolname
            case "NiCad"
                report = importBCEReportfile(path+"recall-NiCad.txt");
            case "FAAST"
                if contains(config,"retrained")
                    config=split(config,"(");
                    config=config(1);
                    config=floor(str2double(config)*10);
                    report = importBCEReportfile(path+"recall-"+toolname+"_0."+int2str(config)+"_retrained.txt");
                else
                    config=floor(str2double(config)*10);
                    report = importBCEReportfile(path+"recall-"+toolname+"_0."+int2str(config)+".txt");
                end
            case "Amain"
                if contains(config,"retrained")
                    report = importBCEReportfile(path+"recall-"+toolname+"_retrained.txt");
                else
                    report = importBCEReportfile(path+"recall-"+toolname+".txt");
                end
            case "UniXcoder"
                report = importBCEReportfile(path+"recall-"+toolname+".txt");
            case "GraphCodeBERT"
                report = importBCEReportfile(path+"recall-"+toolname+".txt");
            case "TreeSeqCC"
                report = importBCEReportfile(path+"recall-"+toolname+".txt");
            otherwise
                config=floor(str2double(config)*10);
                report = importBCEReportfile(path+"recall-"+toolname+"_0."+int2str(config)+".txt");
        end
        recall(i,:)=report;
    end
    idx=recall>baseline;
    recall(idx)=baseline(idx);
    resultsTable=recall;
end
if tableType=="Precision-traditional"||tableType=="Precision-traditional-BCE"
    tools(12:13,:)=[];
    [rows,~]=size(tools);
    cols=6;
    precision=zeros(rows,cols);
    funcNum=6438;
    if tableType=="Precision-traditional-BCE"
        funcNum=14780;
    end
    for i=1:rows
        toolname=tools(i,1);
        config=tools(i,2);
        switch toolname
            case "NiCad"
                results=results_NiCad_reduced;
            case "SourcererCC"
                config=floor(str2double(config)*10);
                idx=config==floor(results_SourcererCC_reduced.simRange*10);
                results=results_SourcererCC_reduced.results{idx};
            case "CloneWorks"
                config=floor(str2double(config)*10);
                idx=config==floor(results_CloneWorks_reduced.simRange*10);
                results=results_CloneWorks_reduced.results{idx};
            case "Deckard"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Deckard_reduced.simRange*10);
                results=results_Deckard_reduced.results{idx};
            case "Oreo"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Oreo_reduced.simRange*10);
                results=results_Oreo_reduced.results{idx};
            case "NIL"
                config=floor(str2double(config)*10);
                idx=config==floor(results_NIL_reduced.simRange*10);
                results=results_NIL_reduced.results{idx};
            case "FAAST"
                if contains(config,"retrained")
                    config=split(config,"(");
                    config=config(1);
                    config=floor(str2double(config)*10);
                    idx=config==floor(results_FAAST_new.simRange*10);
                    results=results_FAAST_new_reduced.results{idx};
                else
                    config=floor(str2double(config)*10);
                    idx=config==floor(results_FAAST_orig.simRange*10);
                    results=results_FAAST_orig_reduced.results{idx};
                end
            case "Amain"
                if contains(config,"retrained")
                    results=results_Amain_new_reduced;
                else
                    results=results_Amain_orig_reduced;
                end
            case "UniXcoder"
                results=results_UniXcoder_reduced;
            case "GraphCodeBERT"
                results=results_GraphCodeBERT_reduced;
            case "Code2vec"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Code2vec_reduced.simRange*10);
                results=results_Code2vec_reduced.results{idx};
            case "Infercode"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Infercode_reduced.simRange*10);
                results=results_Infercode_reduced.results{idx};
            case "TreeSeqCC"
                if tableType=="Precision-traditional-BCE"
                    results=results_TreeSeqCC_traditional_reduced_BCE;
                else
                    results=results_TreeSeqCC_traditional_reduced;
                end
        end
        precision(i,:)=[results.Num_Reported results.Num_Reported/funcNum/funcNum*100 ...
            results.Num_Clones results.Positives_False_Alarm...
            results.Labeled_Positives_Precision_Lower_Bound results.Labeled_Positives_Precision_Upper_Bound];
    end
    if tableType=="Precision-traditional-BCE"
        precision(12:17,:)=[];
    end
    resultsTable=precision;
end
if tableType=="Precision-learning"||tableType=="Precision-learning-BCE"
    tools(1:11,:)=[];
    [rows,~]=size(tools);
    cols=7;
    precision=zeros(rows,cols);
    for i=1:rows
        toolname=tools(i,1);
        config=tools(i,2);
        switch toolname
            case "ASTNN"
                config=floor(str2double(config)*10);
                idx=config==floor(results_ASTNN.simRange*10);
                results=results_ASTNN.results{idx};
            case "FAAST"
                if contains(config,"retrained")
                    config=split(config,"(");
                    config=config(1);
                    config=floor(str2double(config)*10);
                    idx=config==floor(results_FAAST_new.simRange*10);
                    results=results_FAAST_new.results{idx};
                else
                    config=floor(str2double(config)*10);
                    idx=config==floor(results_FAAST_orig.simRange*10);
                    results=results_FAAST_orig.results{idx};
                end
            case "Amain"
                if contains(config,"retrained")
                    results=results_Amain_new;
                else
                    results=results_Amain_orig;
                end
            case "UniXcoder"
                results=results_UniXcoder;
            case "GraphCodeBERT"
                results=results_GraphCodeBERT;
            case "Code2vec"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Code2vec_Pairwise.simRange*10);
                results=results_Code2vec_Pairwise.results{idx};
            case "Infercode"
                config=floor(str2double(config)*10);
                idx=config==floor(results_Infercode_Pairwise.simRange*10);
                results=results_Infercode_Pairwise.results{idx};
            case "TreeSeqCC"
                if tableType=="Precision-learning-BCE"
                    results=results_TreeSeqCC_learning_BCE;
                else
                    results=results_TreeSeqCC_learning;
                end
        end
        precision(i,:)=[results.Num_Reported results.Num_Positives results.Num_Negatives...
            results.LearningMetric_Precision results.LearningMetric_Recall...
            results.LearningMetric_F1_Score results.LearningMetric_FalsePositiveRate];
    end
    resultsTable=precision;
end
% 唐艺嘉把下面关于TreeSqCCe注释了
% if tableType=="Configurations"||tableType=="Configurations-BCE"
%     path="/home/cat409/Documents/MATLAB/ASTENS-TreeSeqCC/Evaluations/TreeSeqCC/reports/";
%     rows=4+1+1+4+1+4;
%     cols=12;
%     metrics=zeros(rows,cols);
% 
%     if tableType=="Configurations-BCE"
%         benchmarkPath="GroundTruth-BCB/BCBenchmark-latest.mat";
%     else
%         benchmarkPath="GroundTruth-BCB/BCBenchmark.mat";
%     end
%     [benchmarkStats,clones,false_positives] = analysisBenchmark(benchmarkPath);
% 
%     if tableType=="Configurations-BCE"
%         [report] = importASTENSBWAfile(path+"ConfigurationTest-Pairwise-BCE.txt",9);
%     else
%         [report] = importASTENSBWAfile(path+"ConfigurationTest-Pairwise.txt",9);
%     end
%     report=report(:,1:9);
%     report=table2array(report);
%     for i=1:4
%         idx=report(:,i+3)>=0.9;
%         prediction=zeros(size(report,1),1);
%         prediction(idx,1)=1;
%         prediction(~idx,1)=-1;
%         reportedClones=[report(:,1:2) prediction];
%         [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
%         metrics(i,:)=[results.Num_Positives results.Num_Negatives results.Positives_Recall...
%             results.LearningMetric_Precision results.LearningMetric_Recall...
%             results.LearningMetric_F1_Score results.LearningMetric_FalsePositiveRate];
% 
%         idx=report(:,i+3)>=0.9&report(:,9)>=0.9;
%         prediction=zeros(size(report,1),1);
%         prediction(idx,1)=1;
%         prediction(~idx,1)=-1;
%         reportedClones=[report(:,1:2) prediction];
%         [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
%         metrics(i+6,:)=[results.Num_Positives results.Num_Negatives results.Positives_Recall...
%             results.LearningMetric_Precision results.LearningMetric_Recall...
%             results.LearningMetric_F1_Score results.LearningMetric_FalsePositiveRate];
% 
%         idx=report(:,i+3)>=0.9&report(:,8)>=0.9&report(:,9)>=0.9;
%         prediction=zeros(size(report,1),1);
%         prediction(idx,1)=1;
%         prediction(~idx,1)=-1;
%         reportedClones=[report(:,1:2) prediction];
%         [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
%         metrics(i+11,:)=[results.Num_Positives results.Num_Negatives results.Positives_Recall...
%             results.LearningMetric_Precision results.LearningMetric_Recall...
%             results.LearningMetric_F1_Score results.LearningMetric_FalsePositiveRate];
%     end
% 
%     idx=report(:,8)>=0.9;
%     prediction=zeros(size(report,1),1);
%     prediction(idx,1)=1;
%     prediction(~idx,1)=-1;
%     reportedClones=[report(:,1:2) prediction];
%     [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
%     metrics(5,:)=[results.Num_Positives results.Num_Negatives results.Positives_Recall...
%         results.LearningMetric_Precision results.LearningMetric_Recall...
%         results.LearningMetric_F1_Score results.LearningMetric_FalsePositiveRate];
% 
%     idx=report(:,9)>=0.9;
%     prediction=zeros(size(report,1),1);
%     prediction(idx,1)=1;
%     prediction(~idx,1)=-1;
%     reportedClones=[report(:,1:2) prediction];
%     [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
%     metrics(6,:)=[results.Num_Positives results.Num_Negatives results.Positives_Recall...
%         results.LearningMetric_Precision results.LearningMetric_Recall...
%         results.LearningMetric_F1_Score results.LearningMetric_FalsePositiveRate];
% 
%     idx=report(:,8)>=0.9&report(:,9)>=0.9;
%     prediction=zeros(size(report,1),1);
%     prediction(idx,1)=1;
%     prediction(~idx,1)=-1;
%     reportedClones=[report(:,1:2) prediction];
%     [results] = analysisCloneReport(reportedClones,benchmarkStats,clones,false_positives);
%     metrics(11,:)=[results.Num_Positives results.Num_Negatives results.Positives_Recall...
%         results.LearningMetric_Precision results.LearningMetric_Recall...
%         results.LearningMetric_F1_Score results.LearningMetric_FalsePositiveRate];
% 
%     resultsTable=metrics;
% end

end

