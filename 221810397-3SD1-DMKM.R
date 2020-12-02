library(readxl)
library(caret)
library(RWeka)
library(partykit)
library(MLmetrics)

data<-read_xlsx("D:/Kuliah/Semester 5/Data Mining dan Knowledge Management/UTS/seeds.xlsx")
str(data)
data$varieties<-as.factor(data$varieties)
class(data$varieties)

train <- createFolds(data$varieties, k=10)
C45Fit <- train(varieties ~., method="J48", data=data,
                tuneLength = 5,
                trControl = trainControl(
                  method="cv", indexOut=train))
C45Fit
C45Fit$finalModel
plot(C45Fit$finalModel)
prediksi<-predict(C45Fit, data)
confusionMatrix(table(Predicted = prediksi, Actual=data$varieties))

F1_Score(data$varieties, prediksi, positive = NULL)
