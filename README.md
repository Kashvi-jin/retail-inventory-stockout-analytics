# Retail Inventory & Stockout Risk Intelligence

An end-to-end **Data Analytics & Business Intelligence** project that analyzes retail sales, inventory, demand forecasts, and replenishment patterns to identify inventory pressure and product-level priorities.

The project uses **Python for data cleaning and exploratory analysis, MySQL for business-focused SQL analysis, and Tableau for interactive dashboarding**.

> **Dataset Note:** The dataset used in this project is synthetic and does not represent data from a specific real-world retailer.

---

## 📌 Business Problem

Retailers need to maintain sufficient inventory to meet customer demand while avoiding unnecessary inventory buildup.

The objective of this project is to analyze store-product level data and answer key business questions such as:

- Where is demand concentrated across categories and products?
- How do sales and replenishment orders change over time?
- Which categories show relatively higher inventory pressure?
- Which products are the strongest sellers within each category?
- Which products may require further replenishment review?
- How can these insights be presented through an interactive dashboard?

---

## 🎯 Project Objective

The project follows an end-to-end analytics workflow:

**Raw Data → Data Cleaning → Exploratory Analysis → SQL Analysis → Tableau Dashboard → Business Insights**

The analysis focuses on understanding **demand, inventory coverage, replenishment patterns, and product performance** rather than building a machine learning model.

---

## 🗂️ Dataset

The dataset contains store-product-date level retail observations with 15 original fields:

| Column | Description |
|---|---|
| Date | Observation date |
| Store ID | Store identifier |
| Product ID | Product identifier |
| Category | Product category |
| Region | Store region |
| Inventory Level | Recorded inventory level |
| Units Sold | Units sold |
| Units Ordered | Units ordered for replenishment |
| Demand Forecast | Forecasted demand |
| Price | Product price |
| Discount | Applied discount |
| Weather Condition | Weather condition |
| Holiday/Promotion | Holiday or promotion indicator |
| Competitor Pricing | Competitor price |
| Seasonality | Seasonal classification |

After data cleaning, the final analysis contains **72,427 observations**.

---

# 🔎 Data Cleaning & Preparation

Python and Pandas were used to prepare the dataset for analysis.

### Cleaning steps

- Inspected dataset structure, columns, and data types
- Checked for missing values
- Checked for duplicate records
- Converted `Date` into a proper datetime format
- Identified invalid negative values in `Demand Forecast`
- Removed observations where `Demand Forecast < 0`
- Created an `Inventory Coverage` metric for inventory-pressure analysis

### Data Quality

The original dataset contained:

- **73,100 observations**
- **15 columns**

After removing invalid negative demand forecast observations:

- **72,427 observations**
- **16 fields**, including the derived `Inventory Coverage` metric

---

# 📊 Inventory Coverage

A key metric used in the project is:

```text
Inventory Coverage = Inventory Level / Demand Forecast