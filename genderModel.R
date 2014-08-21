setwd("C://R_working_dir//data//titanic")
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")

#observing gender patterns
summary(train$sex)
#this gives proportions among the entire table
prop.table(table(train$Sex, train$Survived))
#get proportions only on the first dimension(row-wise)
prop.table(table(train$Sex, train$Survived),1)

test$Survived <- 0
#prediction that all women survive as the proportions above suggest
test$Survived[test$Sex== 'female'] <- 1

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
#write.csv(submit,file="gendermodel.csv",row.names=FALSE)

#observing age patterns
summary(train$Age)
train$Child <- 0
train$Child[train$Age < 18] <- 1
#count of survivors in that category
aggregate(Survived ~ Child + Sex, data = train, FUN = sum)
#total number of people in that category
aggregate(Survived ~ Child + Sex, data = train, FUN = length)
#percantage of survivors category-wise
aggregate(Survived ~ Child + Sex, data = train, FUN = function(x){sum(x)/length(x)})

#the above analysis still shows that women survive mostly
#observing the class and fare patterns
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

#percentage of survivors by class and fare and sex
aggregate(Survived ~ Fare2 + Pclass + Sex, data = train, FUN = function(x) {sum(x)/length(x)})

#observed that women of 3rd class who paid more than 30$ died more
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit,file="gendermodel.csv",row.names=FALSE)