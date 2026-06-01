setwd('C:/Users/NEERAV/OneDrive/Desktop/CODSOFT')


advert = read.csv('advertising.csv')

# train test split
set.seed(123)

index = sample(1:nrow(advert), 0.8*nrow(advert))
train = advert[index,]
test = advert[-index,]


# Building model
mlm = lm(Sales ~ TV + Radio, data = train)

summary(mlm)

# predictions
prediction = predict(mlm, newdata = test)

# model evaluation
RMSE = sqrt(mean((test$Sales - prediction)^2))

MAE = mean(abs(test$Sales - prediction))

# plot of actual results vs predictions
plot(test$Sales, prediction, xlab = "Actual Sales", ylab = "Predicted Sales", main = "Actual vs Predicted Sales")
abline(0,1, col = "red", lwd = 2)

par(mfrow = c(2,2))
plot(mlm)



