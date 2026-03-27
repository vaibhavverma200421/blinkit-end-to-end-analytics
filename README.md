# blinkit-end-to-end-analytics
This project performs a comprehensive analysis of Blinkit's sales performance, customer satisfaction, and inventory distribution to identify key business insights and optimization opportunities.
📌 Project Overview
This project performs a comprehensive analysis of Blinkit's sales performance, customer satisfaction, and inventory distribution to identify key business insights and optimization opportunities.
The analysis spans the full data analytics pipeline — from raw data cleaning to interactive dashboards — using four industry-standard tools:
ToolPurposeSQL (PostgreSQL)Data cleaning, transformation, and business KPI queriesPython (Jupyter Notebook)Exploratory Data Analysis (EDA) and statistical chartingMicrosoft ExcelInteractive KPI dashboard with slicers and chartsPower BIProfessional business intelligence dashboard

🎯 Business Requirements & KPIs
Primary KPIs
KPIResultTotal Sales$1.20 MillionAverage Sales per Transaction$140.99Number of Items8,523Average Customer Rating3.97 / 5.0
Granular Analysis Requirements

Total Sales by Fat Content — Impact of low fat vs. regular items on revenue
Total Sales by Item Type — Performance across 16 product categories
Fat Content by Outlet for Total Sales — Cross-segmented comparison across tiers
Total Sales by Outlet Establishment Year — Effect of outlet age on performance
Percentage of Sales by Outlet Size — Correlation between outlet size and revenue
Sales by Outlet Location — Geographic distribution (Tier 1, 2, 3)
All Metrics by Outlet Type — Full breakdown across Grocery Store and Supermarket types


📂 Repository Structure
blinkit-analysis/
│
├── data/
│   └── Blinkit_sales_data_Cleaned.csv       # Cleaned dataset (8,523 rows)
│
├── sql/
│   └── blinkit_SQL_data.sql                 # Data cleaning + all KPI queries
│
├── python/
│   └── EDA_With_Python.ipynb                # Full EDA notebook with visualizations
│
├── excel/
│   └── (BlinkIT Grocery Data.xlsx)          # Excel dashboard with slicers
│
├── powerbi/
│   └── Blinkit_dashboard.pbix               # Power BI report file
│   └── Blinkit_dashboard.pdf                # PDF export of dashboard
│
├── presentation/
│   └── Blinkit_Analysis.pptx                # Project brief & requirements deck
│
└── README.md

🔧 Tools & Workflow
1. 🗄️ SQL — Data Cleaning & KPI Queries
File: sql/blinkit_SQL_data.sql
What was done:

Created raw and cleaned tables in PostgreSQL
Standardized the ItemFatContent column (e.g., LF → Low Fat, reg → Regular)
Cast columns to correct data types (INT, FLOAT)
Imputed null values in ItemWeight using average grouping by item type
Ran all 7 business KPI queries covering sales, ratings, item counts, and outlet breakdowns

Sample queries include:
sql-- Total Sales
SELECT CAST(SUM(totalsales)/1000000.0 AS DECIMAL(10,2)) AS total_sales_millions
FROM blinkit_sales;

-- Sales by Outlet Type
SELECT outlettype, SUM(totalsales), AVG(totalsales), COUNT(*), AVG(rating)
FROM blinkit_sales GROUP BY outlettype ORDER BY 2 DESC;

2. 🐍 Python — Exploratory Data Analysis
File: python/EDA_With_Python.ipynb
What was done:

Loaded and inspected the cleaned dataset
Performed univariate and bivariate analysis
Generated distribution plots, bar charts, and correlation visuals
Identified patterns in sales by fat content, item type, outlet size, and location

Libraries used: pandas, numpy, matplotlib, seaborn

3. 📊 Excel — Interactive Dashboard
File: excel/BlinkIT Grocery Data.xlsx
What was done:

Built a full KPI dashboard with dynamic slicers (Fat Content, Item Type, Outlet Size)
Charts include: Donut chart (fat content), Bar chart (item types), Line chart (establishment year), Stacked bar (outlet location by fat)
KPI cards for Total Sales, Average Sales, Number of Items, Average Rating
Dashboard mirrors the Power BI layout for consistency


4. 📈 Power BI — Business Intelligence Dashboard
File: powerbi/Blinkit_dashboard.pbix
What was done:

Connected to the cleaned CSV data source
Built interactive visuals with cross-filtering
Created DAX measures for KPIs
Filter panel with Outlet Location Type and Outlet Size slicers
Published-ready layout with Blinkit branding


📊 Key Findings
InsightDetailLow Fat dominates sales64.6% of total sales ($0.78M) vs. Regular at 35.4% ($0.43M)Top categoriesFruits & Vegetables ($178K) and Snack Foods ($175K) lead by revenueOutlet size sweet spotMedium-sized outlets contribute the most to total salesTier 3 leads geographicallyTier 3 locations generate the highest total salesSupermarket Type1 is #1$787.5K in sales — far ahead of all other outlet typesConsistent ratingsAverage rating of 3.97 across all fat content types and outlet sizesSales peak in 2018Outlets established in 2018 show the highest sales peak in the trend

🚀 How to Run
SQL

Import Blinkit_sales_data_Cleaned.csv into your PostgreSQL/DuckDB instance
Run blinkit_SQL_data.sql in order (table creation → cleaning → KPI queries)

Python

Install dependencies:

bash   pip install pandas numpy matplotlib seaborn jupyter

Launch the notebook:

bash   jupyter notebook EDA_With_Python.ipynb
Power BI

Open Blinkit_dashboard.pbix in Power BI Desktop
Update the data source path to point to your local CSV file
Refresh the data and explore the dashboard

Excel

Open BlinkIT Grocery Data.xlsx in Microsoft Excel
Use the slicers on the Dashboard tab to filter the visuals interactively


📸 Dashboard Previews

Power BI Dashboard

The Power BI dashboard features an interactive filter panel, KPI cards, donut chart for fat content split, bar chart for item types, and outlet type breakdown table.

Excel Dashboard

The Excel dashboard replicates all visuals with native Excel charts and slicers, making it accessible without a Power BI license.
(Add screenshots to a /screenshots folder and link them here for best impact.)

📁 Dataset

Source: Blinkit Grocery Sales Dataset
Rows: 8,523 transactions
Columns: 12 (Item Fat Content, Item Type, Outlet Type, Outlet Size, Outlet Location, Sales, Rating, etc.)
Cleaning applied: Null imputation, column standardization, type casting


👤 Author

Vaibhav Verma 
MCA Candidate | Data Analyst 


LinkedIn: linkedin.com/in/hey-vaibhav-verma 


GitHub: github.com/vaibhavverma200421 


Portfolio: vaibhavverma200421.github.io/My-portfolio


⭐ If you found this useful, give it a star!

This project was built as an end-to-end data analytics portfolio piece demonstrating proficiency across SQL, Python, Excel, and Power BI.
