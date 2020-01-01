 clear
 clc
 L = load('Book2.mat').Book2;
 T=[L(:,1:19) L(:,21:42)];
 
 t1=table2array(T(:,[1, 5:40]));
 t2=table2array(T(:,2:4));
 t3=table2array(T(:,41));
 
 Table=array2table([t1(:,1) grp2idx(t2(:,1)) grp2idx(t2(:,2)) grp2idx(t2(:,3)) t1(:,2:end) grp2idx(t3)]);

 
% normalize the data
data = [normalize(Table(:,1:40),'zscore') Table(:,41)];

% Separate to training and test data
trainData=[];
testData=[];
trainLabel=[];
testLabel=[];

for i=1:10
    row=find(table2array(data(:,41))==i);
    subData=data(row,:);
    rng('default');
    cv = cvpartition(size(subData,1),'HoldOut',0.3);
    idx = cv.test;
    subTrainLabel = T(~idx,41);
    subTestLabel = T(idx,41);
    subDataTrain = subData(~idx,:);
    subDataTest  = subData(idx,:);
    trainData=cat(1,trainData , subDataTrain);
    testData=cat(1,testData , subDataTest);
    trainLabel=cat(1,trainLabel, subTrainLabel);
    testLabel=cat(1,testLabel, subTestLabel);
    subData=[];
    subDataTrain=[];
    subDataTest=[];
    subTrainLabel=[];
    subTestLabel=[];
end




