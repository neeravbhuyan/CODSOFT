setwd('C:/Users/NEERAV/OneDrive/Desktop/CODSOFT')
titanic = read.csv('Titanic-Dataset.csv')

# Data Cleaning
titanic$Survived = as.numeric(titanic$Survived)
titanic$Pclass = as.factor(titanic$Pclass)
titanic$Sex = as.factor(titanic$Sex)
titanic$Age[is.na(titanic$Age)] = median(titanic$Age, na.rm = TRUE)

# splitting into training sample and testing sample
set.seed(123)

index = sample(1:nrow(titanic), 0.8*nrow(titanic))

train = titanic[index,]
test = titanic[-index,]

# Defining the logistic regression model
model = glm(Survived ~ Pclass + Sex + Age + Fare + SibSp + Parch, data = train, family = binomial)

# Model Summary
summary(model)

# predicted probabilities
prob = predict(model, newdata = test, type = "response")

# predicted classes
pred = ifelse(prob > 0.5, 1, 0)

# Result Matrix
table(Prediction = pred, Actual = test$Survived)

# Accuracy check
mean(pred == test$Survived)

# odds ratio
exp(coef(model))

# probability curve for fare
model_2 = glm(Survived ~ Fare, data = titanic, family = binomial)
Fare_seq = seq(min(titanic$Fare,na.rm = TRUE), max(titanic$Fare, na.rm = TRUE), length.out = 100)
pred_prob = predict(model_2, newdata = data.frame(Fare = Fare_seq), type = "response")

plot(Fare_seq, 
     pred_prob, 
     type = 'l',
     lwd = 3,
     xlab = "Fare",
     ylab = "Predicted Survival Probability",
     main = "Logistic Regression Probability Curve"
     )
