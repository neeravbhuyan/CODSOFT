setwd('C:/Users/NEERAV/OneDrive/Desktop/CODSOFT') #set working directory to file path
titanic = read.csv('Titanic-Dataset.csv') #import dataset into R

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
"""
Since our response variable is binary(either survived or not survived), we use logistic regression to compute probability whether a passenger survided the wreck
or not.
"""

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
"""
The model is accurate almost 79% of the time. This was due to the fact the the training data was comparatively less.
"""
# odds ratio
exp(coef(model))
"""
Provided the odds of surviving to not surviving for passengers of different class, sex, no. of relatives onboard, etc...
"""
