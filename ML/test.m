classes=testData(:,41);
results=zeros(1,10);
class_number=zeros(1,10);
predictions=FineKNN.predictFcn(testData(:,1:40));

classes_array=table2array(classes);
classes = categorical(classes_array);
for i=1:length(predictions)
    if predictions(i,1)== classes(i,1)
        [row,column]=find(classNamesTable==classes(i,1));
        results(column)=results(column)+1;
    end
    
    class_number(column)=class_number(column)+1;
end
% Results
acc=results./class_number;
mean(acc) %average

cmat=confusionmat(classes,predictions);
plotconfusion(classes,predictions);

for i=1:size(cmat,1)
    recall(i)=cmat(i,i)/sum(cmat(i,:));
    precision(i)=cmat(i,i)/sum(cmat(:,i));
end
Recall=sum(recall)/size(cmat,1)
Precision=sum(precision)/size(cmat,1)
F_score=2*Recall*Precision/(Precision+Recall)

plotconfusion(classes,predictions);

a=grp2idx(classes);
b=grp2idx(predictions);
prec_rec(b, a);

xx = table2array(Temp1(:,1));
xy = table2array(Temp1(:,2));
xz = table2array(Temp1(:,33));

figure,
scatter3(xx, xy, xz);

