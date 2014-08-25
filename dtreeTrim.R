setwd("C://R_working_dir//data//titanic")
train <- read.csv("data/train.csv")
test <- read.csv("data/test.csv")

#packages for some fancy plots
install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

#Recreate the gender model
fit <- rpart(Survived ~ Sex, data = train, method = "class")
fancyRpartPlot(fit)

#build a deeper decision tree with more variables/nodes
fit <- rpart(Survived ~ Sex + Pclass +Age + SibSp + Parch +
               Fare + Embarked, data = train, method = "class")

#make a plot with base R
plot(fit)
text(fit)

#Now make it look better with Rpartplot
fancyRpartPlot(fit)

# Now let's make a prediction and write a submission file
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "dtree.csv", row.names = FALSE)

# Let's unleash the decision tree and let it grow to the max
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=2, cp=0))
fancyRpartPlot(fit)

# Now let's make a prediction and write a submission file
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfullgrowntree.csv", row.names = FALSE)

# Manually trim a decision tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=2, cp=0.005))
new.fit <- prp(fit,snip=TRUE)$obj
fancyRpartPlot(new.fit)
