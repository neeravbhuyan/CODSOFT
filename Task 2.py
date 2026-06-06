import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder


movies = pd.read_csv(
    r"C:\Users\NEERAV\OneDrive\Desktop\CODSOFT\movie-rating.csv",
    encoding="latin1",
)

# Data cleaning
movies.columns = movies.columns.str.strip().str.replace(" ", ".")

movies_clean = movies.copy()
movies_clean["Year"] = pd.to_numeric(
    movies_clean["Year"].astype(str).str.replace(r"[()]", "", regex=True),
    errors="coerce",
)
movies_clean["Duration"] = pd.to_numeric(
    movies_clean["Duration"].astype(str).str.replace(" min", "", regex=False),
    errors="coerce",
)
movies_clean["Votes"] = pd.to_numeric(
    movies_clean["Votes"].astype(str).str.replace(",", "", regex=False),
    errors="coerce",
)
movies_clean["Rating"] = pd.to_numeric(movies_clean["Rating"], errors="coerce")

movies_clean = movies_clean.dropna(subset=["Rating", "Duration", "Votes"])
movies_clean = movies_clean[
    (movies_clean["Director"].astype(str).str.strip() != "")
    & (movies_clean["Actor.1"].astype(str).str.strip() != "")
    & (movies_clean["Genre"].astype(str).str.strip() != "")
]

features = ["Year", "Duration", "Votes", "Genre", "Director", "Actor.1", "Actor.2", "Actor.3"]
target = "Rating"

x = movies_clean[features]
y = movies_clean[target]

# Train-test split
x_train, x_test, y_train, y_test = train_test_split(
    x,
    y,
    train_size=0.8,
    random_state=123,
)

numeric_features = ["Year", "Duration", "Votes"]
categorical_features = ["Genre", "Director", "Actor.1", "Actor.2", "Actor.3"]

preprocessor = ColumnTransformer(
    transformers=[
        ("numeric", "passthrough", numeric_features),
        ("categorical", OneHotEncoder(handle_unknown="ignore"), categorical_features),
    ]
)

# Defining Random Forest model
rf_model = Pipeline(
    steps=[
        ("preprocessor", preprocessor),
        ("model", RandomForestRegressor(n_estimators=500, random_state=123)),
    ]
)

rf_model.fit(x_train, y_train)
print(rf_model)

# Prediction
pred = rf_model.predict(x_test)

# Evaluation of errors
rmse = np.sqrt(mean_squared_error(y_test, pred))
mae = mean_absolute_error(y_test, pred)
r2 = r2_score(y_test, pred)

print("RMSE:", rmse)
print("MAE:", mae)
print("R2:", r2)

plt.figure()
plt.scatter(y_test, pred)
plt.xlabel("Actual Rating")
plt.ylabel("Predicted Rating")
plt.title("Actual vs Predicted")
plt.axline((0, 0), slope=1, color="red", linewidth=2)

# Variable importance plot
encoded_feature_names = rf_model.named_steps["preprocessor"].get_feature_names_out()
importances = rf_model.named_steps["model"].feature_importances_
importance_table = pd.Series(importances, index=encoded_feature_names).sort_values(ascending=False)

plt.figure(figsize=(10, 6))
importance_table.head(15).sort_values().plot(kind="barh")
plt.xlabel("Importance")
plt.title("Top 15 Variable Importances")
plt.tight_layout()
plt.show()