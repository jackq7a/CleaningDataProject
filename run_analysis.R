
## Read in Files to be used
features     = read.table('features.txt',header=FALSE);
activityType = read.table('activity_labels.txt',header=FALSE);
subjecttrain = read.table('train/subject_train.txt',header=FALSE);
xtrain       = read.table('train/x_train.txt',header=FALSE);
ytrain       = read.table('train/y_train.txt',header=FALSE);
subjecttest = read.table('test/subject_test.txt',header=FALSE);
xtest       = read.table('test/x_test.txt',header=FALSE);
ytest       = read.table('test/y_test.txt',header=FALSE);

## Assign Column Names
colnames(activityType)  = c('activityId','activityType');
colnames(subjecttrain)  = "subjectId";
colnames(xtrain)        = features[,2];
colnames(ytrain)        = "activityId";
colnames(subjecttest) = "subjectId";
colnames(xtest)       = features[,2];
colnames(ytest)       = "activityId";


## Create Variables to work with
trainingdata = cbind(ytrain,subjecttrain,xtrain);
testdata = cbind(ytest,subjecttest,xtest);
finaldata = rbind(trainingdata,testdata);
colNames  = colnames(finaldata);


lvector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
finaldata = finaldata[lvector==TRUE];
finaldata = merge(finaldata,activityType,by='activityId',all.x=TRUE);
colNames  = colnames(finaldata);

for (i in 1:length(colNames))
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(finaldata) = colNames;




finaldata2  = finaldata[,names(finaldata) != 'activityType'];

tidydata    = aggregate(finaldata2[,names(finaldata2) != c('activityId','subjectId')],by=list(activityId=finaldata2$activityId,subjectId = finaldata2$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
tidydata    = merge(tidydata,activityType,by='activityId',all.x=TRUE);

# Export the tidyData set
write.table(tidydata, 'tidydata.txt',row.names=FALSE,sep='\t');
