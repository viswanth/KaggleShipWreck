setwd("C://R_working_dir//data//titanic")
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")

#structure of the train data
str(train)

#number of survived and number of not survived
table(train$Survived)
#percentage of survived and not survived
prop.table(table(train$Survived))

#initially add 0 survival to the entire data
test$Survived <- rep(0,nrow(test))

submit <- data.frame(PassengerId = test$PassengerId, 
                     Survived = test$Survived)

write.csv(submit, file="initialsubmission.csv",row.names = FALSE)