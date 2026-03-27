# 🛒 Blinkit Sales Analysis — End-to-End Data Analytics Project

> A complete, multi-tool data analytics project on Blinkit's grocery sales data — covering SQL, Python EDA, Excel dashboarding, and Power BI reporting.

![Blinkit](https://img.shields.io/badge/Domain-Grocery%20%7C%20Quick%20Commerce-yellow?style=flat-square)
![Tools](https://img.shields.io/badge/Tools-SQL%20%7C%20Python%20%7C%20Excel%20%7C%20Power%20BI-blue?style=flat-square)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat-square)

---

## 📌 Project Overview

This project performs a **comprehensive analysis of Blinkit's sales performance, customer satisfaction, and inventory distribution** to identify key business insights and optimization opportunities.

The analysis spans the **full data analytics pipeline** — from raw data cleaning to interactive dashboards — using four industry-standard tools:

| Tool | Purpose |
|------|---------|
| **SQL (PostgreSQL)** | Data cleaning, transformation, and business KPI queries |
| **Python (Jupyter Notebook)** | Exploratory Data Analysis (EDA) and statistical charting |
| **Microsoft Excel** | Interactive KPI dashboard with slicers and charts |
| **Power BI** | Professional business intelligence dashboard |

---

## 🎯 Business Requirements & KPIs

### Primary KPIs
| KPI | Result |
|-----|--------|
| **Total Sales** | $1.20 Million |
| **Average Sales per Transaction** | $140.99 |
| **Number of Items** | 8,523 |
| **Average Customer Rating** | 3.97 / 5.0 |

### Granular Analysis Requirements

1. **Total Sales by Fat Content** — Impact of low fat vs. regular items on revenue
2. **Total Sales by Item Type** — Performance across 16 product categories
3. **Fat Content by Outlet for Total Sales** — Cross-segmented comparison across tiers
4. **Total Sales by Outlet Establishment Year** — Effect of outlet age on performance
5. **Percentage of Sales by Outlet Size** — Correlation between outlet size and revenue
6. **Sales by Outlet Location** — Geographic distribution (Tier 1, 2, 3)
7. **All Metrics by Outlet Type** — Full breakdown across Grocery Store and Supermarket types

---

## 📂 Repository Structure

```
blinkit-end-to-end-analytics/
|
|-- data/
|   |-- Blinkit_sales_data_Cleaned.csv      <- Cleaned dataset (8,523 rows)
|
|-- sql/
|   |-- blinkit_SQL_data.sql                <- Data cleaning + all 7 KPI queries
|
|-- python/
|   |-- EDA_With_Python.ipynb               <- Full EDA notebook with visualizations
|
|-- excel/
|   |-- BlinkIT_Grocery_Data.xlsx           <- Excel dashboard with slicers & charts
|
|-- powerbi/
|   |-- Blinkit_dashboard.pbix              <- Power BI report file
|   |-- Blinkit_dashboard.pdf               <- Exported PDF of the dashboard
|
|-- presentation/
|   |-- Blinkit_Analysis.pptx               <- Project brief & business requirements
|
|-- screenshots/
|   |-- powerbi_dashboard.png               <- Power BI dashboard preview
|   |-- excel_dashboard.png                 <- Excel dashboard preview
|
|-- README.md
```

---

## 🔧 Tools & Workflow

### 1. 🗄️ SQL — Data Cleaning & KPI Queries

**File:** `sql/blinkit_SQL_data.sql`

**What was done:**

✔ Created raw and cleaned tables in PostgreSQL  
✔ Standardized the `ItemFatContent` column (`LF` → `Low Fat`, `reg` → `Regular`)  
✔ Cast columns to correct data types (INT, FLOAT)  
✔ Imputed null values in `ItemWeight` using **average grouping by item type**  
✔ Ran all 7 business KPI queries covering sales, ratings, item counts, and outlet breakdowns

**Sample queries include:**
```sql
-- Total Sales
SELECT CAST(SUM(totalsales)/1000000.0 AS DECIMAL(10,2)) AS total_sales_millions
FROM blinkit_sales;

-- Sales by Outlet Type
SELECT outlettype, SUM(totalsales), AVG(totalsales), COUNT(*), AVG(rating)
FROM blinkit_sales GROUP BY outlettype ORDER BY 2 DESC;
```

---

### 2. 🐍 Python — Exploratory Data Analysis

**File:** `python/EDA_With_Python.ipynb`

**What was done:**

✔ Loaded and inspected the cleaned dataset  
✔ Performed univariate and bivariate analysis  
✔ Generated distribution plots, bar charts, and correlation visuals  
✔ Identified patterns in sales by fat content, item type, outlet size, and location

**Libraries used:** `pandas`, `numpy`, `matplotlib`, `seaborn`

---

### 3. 📊 Excel — Interactive Dashboard

**File:** `excel/BlinkIT Grocery Data.xlsx`

**What was done:**

✔ Built a full KPI dashboard with dynamic slicers (Fat Content, Item Type, Outlet Size)  
✔ Charts: Donut (fat content split), Bar (item types), Line (establishment year), Stacked Bar (outlet location by fat)  
✔ KPI cards for Total Sales, Average Sales, Number of Items, Average Rating  
✔ Dashboard mirrors the Power BI layout for consistency

---

### 4. 📈 Power BI — Business Intelligence Dashboard

**File:** `powerbi/Blinkit_dashboard.pbix`

**What was done:**

✔ Connected to the cleaned CSV data source  
✔ Built interactive visuals with cross-filtering enabled  
✔ Created DAX measures for all KPIs  
✔ Filter panel with Outlet Location Type and Outlet Size slicers  
✔ Published-ready layout with Blinkit branding

---

## 📊 Key Findings

| Insight | Detail |
|--------|--------|
| **Low Fat dominates sales** | 64.6% of total sales ($0.78M) vs. Regular at 35.4% ($0.43M) |
| **Top categories** | Fruits & Vegetables ($178K) and Snack Foods ($175K) lead by revenue |
| **Outlet size sweet spot** | Medium-sized outlets contribute the most to total sales |
| **Tier 3 leads geographically** | Tier 3 locations generate the highest total sales |
| **Supermarket Type1 is #1** | $787.5K in sales — far ahead of all other outlet types |
| **Consistent ratings** | Average rating of 3.97 across all fat content types and outlet sizes |
| **Sales peak in 2018** | Outlets established in 2018 show the highest sales peak in the trend |

---

## 🚀 How to Run

### SQL
1. Import `Blinkit_sales_data_Cleaned.csv` into your PostgreSQL/DuckDB instance  
2. Run `blinkit_SQL_data.sql` in order: table creation → cleaning → KPI queries

### Python
1. Install dependencies:
   ```bash
   pip install pandas numpy matplotlib seaborn jupyter
   ```
2. Launch the notebook:
   ```bash
   jupyter notebook EDA_With_Python.ipynb
   ```

### Power BI
1. Open `Blinkit_dashboard.pbix` in Power BI Desktop
2. Update the data source path to point to your local CSV file
3. Refresh the data and explore the dashboard

### Excel
1. Open `BlinkIT Grocery Data.xlsx` in Microsoft Excel
2. Use the slicers on the Dashboard tab to filter the visuals interactively

---

## 📸 Dashboard Previews

### 📊 Power BI Dashboard
![Power BI Dashboard](powerbi/powerbi_dashboard.png)
> Interactive filter panel · KPI cards · Donut (fat content) · Bar chart (item types) · Outlet type breakdown table

---

### 📗 Excel Dashboard
![Excel Dashboard](excel/excel_dashboard.png)
> Dynamic slicers · Pie & bar charts · Line trend · KPI cards — no Power BI license required

---

## 📁 Dataset

- **Source:** Blinkit Grocery Sales Dataset
- **Rows:** 8,523 transactions
- **Columns:** 12 (Item Fat Content, Item Type, Outlet Type, Outlet Size, Outlet Location, Sales, Rating, etc.)
- **Cleaning applied:** Null imputation, column standardization, type casting

---

👤 AuthorVaibhav Verma 

MCA Candidate | Data Analyst 
LinkedIn: linkedin.com/in/hey-vaibhav-verma 
GitHub: github.com/vaibhavverma200421 P
ortfolio: vaibhavverma200421.github.io/My-portfolio 
Email: vaibhavvermaaa123@gmail.com 
Location: Gurugram, Haryana, India

---

## ⭐ If you found this useful, give it a star!

> *This project was built as an end-to-end data analytics portfolio piece demonstrating proficiency across SQL, Python, Excel, and Power BI.*
