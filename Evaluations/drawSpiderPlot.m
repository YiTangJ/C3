clear;
load('GroundTruth-BCB/BCBenchmark.mat', 'clones', 'false_positives');
load('data-antlr.mat','candASTENS', 'filenames', 'functionsID', 'lenASTENS');
idx=lenASTENS>=5&lenASTENS<=5000;
candASTENS=candASTENS(idx,:);
filenames=filenames(idx,:);
lenASTENS=lenASTENS(idx,:);
functionsID=functionsID(idx,:);
[FPs] = FPFilter_preprocess('Filters/FunctionalityPrediction/ASTSDL-BiLSTM.txt',functionsID);
[FPs] = regularVector(FPs);
% [FPs] = FPFilter_preprocess('Filters/FunctionalityPrediction/CodeSDL-basic_CBOW_BiLSTM.txt',functionsID);
% [FPs] = regularVector(FPs);

benchmarkPath="GroundTruth-BCB/BCBenchmark.mat";
[benchmarkStats,clones,false_positives] = analysisBenchmark(benchmarkPath);

labels=benchmarkStats.LabeledFunctions_Clones;
labelsNum=size(unique(labels(:,2)),1);

%%
figure('WindowState','maximized');
titleOrder=['a','b','c','d','e','f','g','h','i','j'];
for i=1:labelsNum
    func=find(labels(:,2)==i+1);
    idx=ismember(functionsID,labels(func,1));
    X=FPs(idx,:);
    num=size(X,1);
    transparency=1/num;
    if transparency<0.002
        transparency=0.002;
    end
    if i<9
        subplot(3,4,i);
    elseif i==9
            subplot(3,4,[9 10]);
    elseif i==10
            subplot(3,4,[11 12]);
    end
    ax=gca;
    spider_plot(X,...
        'AxesLabels',{'ID_0','ID_1','ID_2','ID_3','ID_4','ID_5','ID_6','ID_7','ID_8','ID_9','ID_{10}'},...
        'AxesLimits', [zeros(1,labelsNum+1);ones(1,labelsNum+1)],...
        'AxesInterval',10,...
        'AxesDisplay','none',...
        'AxesLabelsEdge','none',...
        'LabelFont','Times New Roman',...
        'LabelFontSize',12,...
        'Color',repmat([1 0 0],num,1),...
        'LineTransparency',transparency,...
        'FillOption','on',...
        'FillTransparency',transparency,...
        'Marker','none');
    title("("+titleOrder(i)+")"+" for ID_{"+i+"}",'FontSize',16,'FontName','Times New Roman');
    ax.Position(3)=1.2*ax.Position(3);
    ax.Position(4)=1.2*ax.Position(4);
    if i==9
        ax.Position(1)=0.8*ax.Position(1);
    end
    if i==10
        ax.Position(1)=0.95*ax.Position(1);
    end
end