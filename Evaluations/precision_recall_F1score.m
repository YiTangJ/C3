function [precision,recall,F1score,accuracy,falseAlarm] = precision_recall_F1score(groundTruth,prediction)

sampleNum=size(prediction,1);
positives=groundTruth>0;
tp=sum(prediction(positives,:)==groundTruth(positives,:));
falseAlarm=sum(prediction(~positives,:)~=groundTruth(~positives,:));
tn=sum(prediction(~positives,:)==groundTruth(~positives,:));
fn=sum(prediction(positives,:)~=groundTruth(positives,:));

precision=tp/(tp+falseAlarm)*100;
recall=tp/(tp+fn)*100;
F1score=(2*precision*recall)/(precision+recall);
accuracy=(tp+tn)/sampleNum*100;

end
