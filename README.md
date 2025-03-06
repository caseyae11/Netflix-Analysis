# Netflix Top 10 Analysis

## 📌 Project Overview
This project analyzes the **Netflix Daily Top 10 in the United States**, exploring trends in content rankings, viewership scores, and the impact of release dates on performance. Using data visualization and statistical techniques, this analysis aims to understand:
- 🔥 How frequently certain titles appear in the Top 10.
- 🎬 The difference in popularity between Movies vs. TV Shows.
- 📈 The relationship between Viewership Scores, Rank, and Days in Top 10.
- 🗓️ How release dates and seasons affect a show's performance.  

---

## ⚙️ Technologies Used
- **R** → Data analysis and visualization.
- **ggplot2** → Creating data visualizations.
- **dplyr** → Data manipulation and aggregation.
- **tidyverse** → Organizing and processing datasets.

---

## 🚀 Features
- ✅ **Data Cleaning & Preprocessing** → Renames columns, converts dates, and handles missing values.
- 📊 **Exploratory Data Analysis (EDA)** → Histograms, scatter plots, and box plots for understanding trends.
- 📈 **Trend Analysis** → Identifies **seasonal patterns** and viewership changes over time.
- 🎭 **Movies vs. TV Shows** → Compares performance metrics using bar charts and box plots
- 🏆 **Netflix Exclusivity Impact** → Evaluates whether Netflix Originals perform better than non-exclusives.

---

## 🛠 How to Run

```bash
# 1️⃣ Clone the Repository
git clone https://github.com/YOUR-USERNAME/Netflix-Analysis.git
cd Netflix-Analysis
# 2️⃣ Install Required R Packages
install.packages(c("ggplot2", "dplyr", "tidyverse"))
# 3️⃣ Load Dataset
# Ensure the dataset file 'netflix daily top 10.csv' is placed in the project directory.
# 4️⃣ Run the Analysis
source("Netflix_Analysis.R")
