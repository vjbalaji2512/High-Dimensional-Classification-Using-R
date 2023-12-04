library(caret)
library(dplyr)
library("readxl")
library(randomForest)
library("readxl")
library(caret)
library(dplyr)
library(class)

#Read Data
Train_withID <- read.csv("train.csv")
Train_no_ID <- Train_withID[,-1]
table(Train_no_ID$target)

set.seed(1)
train = sample(1:nrow(Train_no_ID), 0.7*nrow(Train_no_ID))
X.train = Train_no_ID[train, ]
X.train$target <- as.factor(X.train$target)
X.test = Train_no_ID[-train,]
X.test$target <- as.factor(X.test$target)
table(X.train$target)
table(X.test$target)

# Random Forest model
set.seed(222)

rf1 <- randomForest(target~., data=X.train, importance = TRUE)
rf1
varImpPlot(rf1)


#RF2 with ntree=100, mtry=100

rf2 <- randomForest(target~., data=X.train,
                    ntree = 100,
                    mtry = 100,
                    importance = TRUE,
                    proximity = TRUE)
varImpPlot(rf2)
rf2

# Prediction & Confusion Matrix - train data

p1 <- predict(rf1, X.train)
confusionMatrix(p1, X.train$target)
p2 <- predict(rf2, X.train)
confusionMatrix(p2, X.train$target)


# Prediction & Confusion Matrix - test data

q1 <- predict(rf1, X.test)
confusionMatrix(q1, X.test$target)
q2 <- predict(rf2, X.test)
confusionMatrix(q2, X.test$target)


# Error rate of Random Forest
plot(rf1)
plot(rf2)

# Tune mtry
set.seed(1)
t <- tuneRF(X.train[,-301], X.train[,301],
            stepFactor = 0.1,
            plot = TRUE,
            ntreeTry = 300,
            trace = TRUE,
            improve = 0.001)

# No. of nodes for the trees
hist(treesize(rf1),
     main = "No. of Nodes for the Trees",
     col = "green")


# Partial Dependence Plot
partialPlot(rf2, X.train, X23, "0")
partialPlot(rf2, X.train, X23, "1")


# Multi-dimensional Scaling Plot of Proximity Matrix
MDSplot(rf2, X.test$target)

# Support vector machine
train_data <- read.csv("train.csv")
test_data <- read.csv("test.csv")
str(train_data)
set.seed(123)
intrain <- createDataPartition(y=train_data$target, p=0.7, list = FALSE)
training <- train_data[intrain,]
testing <- train_data[-intrain,]
dim(training)
dim(testing)
anyNA(train_data)
summary(train_data)

training[["target"]] = factor(training[["target"]])
tctrl <- trainControl(method = "repeatedcv", number=10,repeats=3)

svm_Linear = train(target~.,data= training, method= "svmLinear",
                   trControl=tctrl, preProcess= c("center","scale"),
                   tuneLength=10)
svm_Linear
test_predict <- predict(svm_Linear, newdata = testing)
test_predict

#confusionmatrix
confusionMatrix(table(test_predict, testing$target))

#improving accuracy by tuning and testing on 20% test data
grid <- expand.grid(C=c(0,0.01,0.05,0.1,0.25,0.5,0.75,1,1.25,1.5,1.75,2.5))
svm_Linear_Grid = train(target~.,data= training, method= "svmLinear",
                        trControl=tctrl, preProcess= c("center","scale"),
                        tuneGrid= grid,tuneLength=10)
svm_Linear_Grid
plot(svm_Linear_Grid)

#20% of test data
test_predict_grid <- predict(svm_Linear_Grid, newdata = testing)
test_predict_grid
confusionMatrix(table(test_predict_grid, testing$target))

#Testdata
test_predict_2 <- predict(svm_Linear_Grid, newdata = test_data)
test_predict_2

#writing it to new csv file
data_test <- data.frame(id=test_data[,1], target=test_predict_2)
write.csv(data_test,'Submission.csv', row.names = FALSE)

#k-nearest neighbors

df <- read.csv(file="train.csv")
training <- sample(1:nrow(df), nrow(df) * 7 / 10)
train <- df[training, ]
test <- df[-training, ]
test.target=test[,2]
dim(test)
train.X=train[,c(3:302)]
test.X=test[,c(3:302)]
train.target=train[,2]

#knnmodel

set.seed(1)
knn.pred=knn(train.X,test.X,train.target,k=1,prob=TRUE)
table(knn.pred,test.target)
mean(knn.pred==test.target)

#For k values from 1 to 5

set.seed(1)
k.val<- c()
pred.val<- c()

for(i in 1:5) {
  knn.pred=knn(train.X,test.X,train.target,k=i,prob = TRUE)
  table(knn.pred,test.target)
  k.val=append(k.val,i)
  pred.val=append(pred.val,mean(knn.pred==test.target))
}

df1<-data.frame(k.val,pred.val)
df1
plot(k.val,pred.val)

#knnmodel with k=4

knn.pred=knn(train.X,test.X,train.target,k=4,prob=TRUE)
table(knn.pred,test.target)

#accuracy
mean(knn.pred==test.target)


#knn.pred

test.data<- read.csv(file="test.csv")
knn.pred=knn(train.X,test.data[,-1],train.target,k=4,prob=TRUE)

#Writing it into csv file
data_test <- data.frame(id=test.data[,1], target=knn.pred)
write.csv(data_test, 'submission.csv', row.names = FALSE)

