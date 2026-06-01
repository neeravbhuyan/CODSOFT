library(dplyr)
library(randomForest)
library(caret)
setwd('C:/Users/NEERAV/OneDrive/Desktop/CODSOFT')

movies <- read.csv("movie-rating.csv", fileEncoding = "latin1")

# Data cleaning
names(movies) <- make.names(names(movies))

movies_clean <- movies %>%
  mutate(
    Year = as.numeric(gsub("[()]", "", Year)),
    Duration = as.numeric(gsub(" min", "", Duration)),
    Votes = as.numeric(gsub(",", "", Votes)),
    Rating = as.numeric(Rating)
  ) %>%
  filter(
    !is.na(Rating),
    !is.na(Duration),
    !is.na(Votes),
    trimws(Director) != "",
    trimws(Actor.1) != "",
    trimws(Genre) != ""
  )

# Train-test split
set.seed(123)

train_index <- createDataPartition(movies_clean$Rating, p = 0.8, list = FALSE)

train_data <- movies_clean[train_index, ]
test_data  <- movies_clean[-train_index, ]

# Defining Random Forest model
rf_model <- randomForest(
  Rating ~ Year + Duration + Votes + Genre + Director + Actor.1+ Actor.2 + Actor.3,
  data = train_data,
  ntree = 500,
  importance = TRUE
)

print(rf_model)

# prediction
pred <- predict(rf_model, newdata = test_data)

# evaluation of errors
RMSE <- sqrt(mean((test_data$Rating - pred)^2))
MAE <- mean(abs(test_data$Rating - pred))
R2 <- cor(test_data$Rating, pred)^2

RMSE
MAE
R2

plot(test_data$Rating, pred,
     xlab = "Actual Rating",
     ylab = "Predicted Rating",
     main = "Actual vs Predicted")

abline(0,1, col = "red", lwd = 2)

# Variable importance plot
varImpPlot(rf_model)
