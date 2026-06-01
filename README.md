# CodSoft Data Science Internship — Tasks

This repository contains R-based solutions for the Data Science internship tasks assigned by **CodSoft**. All three tasks involve end-to-end machine learning workflows — data cleaning, model building, prediction, and evaluation.

---

## 📁 Repository Structure

```
├── Task_1.R               # Titanic Survival Prediction
├── Task_2.R               # Movie Rating Prediction
├── Task_3.R               # Sales Prediction
├── Titanic-Dataset.csv    # Dataset for Task 1
├── movie-rating.csv       # Dataset for Task 2
├── advertising.csv        # Dataset for Task 3
└── README.md
```

---

## Task 1 — Titanic Survival Prediction

**File:** `Task_1.R`  
**Dataset:** `Titanic-Dataset.csv`

### Objective
Predict whether a passenger aboard the Titanic survived or not, based on demographic and ticket information.

### Approach
- **Model:** Logistic Regression (`glm` with `family = binomial`)
- **Features used:** Passenger class (`Pclass`), Sex, Age, Fare, Siblings/Spouses aboard (`SibSp`), Parents/Children aboard (`Parch`)
- **Data Cleaning:** Missing `Age` values imputed with the median; categorical variables converted to factors
- **Train/Test Split:** 80/20

### Evaluation
- Confusion matrix (result table)
- Classification accuracy
- Odds ratios for feature interpretation
- Logistic probability curve for `Fare`

---

## Task 2 — Movie Rating Prediction

**File:** `Task_2.R`  
**Dataset:** `movie-rating.csv`

### Objective
Predict the rating of a movie based on features like genre, director, and cast using regression techniques.

### Approach
- **Model:** Random Forest Regression (`randomForest`, 500 trees)
- **Features used:** Year, Duration, Votes, Genre, Director, Actor 1, Actor 2, Actor 3
- **Data Cleaning:** Stripped formatting characters from `Year`, `Duration`, and `Votes`; removed rows with missing or blank critical fields
- **Train/Test Split:** 80/20 using `caret::createDataPartition`

### Libraries
`dplyr`, `randomForest`, `caret`

### Evaluation
- RMSE (Root Mean Squared Error)
- MAE (Mean Absolute Error)
- R² (Coefficient of Determination)
- Actual vs. Predicted scatter plot
- Variable Importance Plot

---

## Task 3 — Sales Prediction

**File:** `Task_3.R`  
**Dataset:** `advertising.csv`

### Objective
Forecast product sales based on advertising expenditure across different media channels.

### Approach
- **Model:** Multiple Linear Regression (`lm`)
- **Features used:** TV advertising spend, Radio advertising spend
- **Train/Test Split:** 80/20

### Evaluation
- RMSE
- MAE
- Actual vs. Predicted scatter plot
- Regression diagnostic plots (Residuals vs Fitted, Q-Q, Scale-Location, Leverage)

> **Note:** This task was originally specified for Python, but has been implemented in **R**.

---

## How to Run

1. Clone this repository.
2. Open any `.R` file in **RStudio**.
3. Update the `setwd(...)` path at the top of the file to match your local directory.
4. Install any missing packages using `install.packages("package_name")`.
5. Run the script.

---

## Requirements

| Package        | Used In         |
|----------------|-----------------|
| Base R         | Task 1, Task 3  |
| `dplyr`        | Task 2          |
| `randomForest` | Task 2          |
| `caret`        | Task 2          |

---

## Internship
**Organization:** CodSoft  
**Domain:** Data Science
