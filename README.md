# Customer Shopping Behavior Analysis

## 📊 Project Overview

**Customer Shopping Behavior Analysis** is an end-to-end data analytics project that analyzes customer purchasing patterns, product performance, subscription behavior, discounts, shipping preferences, customer segments, and revenue contribution.

The project demonstrates a complete analytics workflow:

**Raw Dataset → Python EDA & Data Preparation → PostgreSQL SQL Analysis → Power BI Dashboard → Business Insights**

The project uses a customer shopping behavior dataset containing **3,900 customer purchase records** and **18 original attributes**.

---

## 🎯 Business Problem

An e-commerce business wants to understand how customers behave across products, categories, demographics, subscriptions, discounts, shipping methods, and purchase frequency.

The analysis is designed to answer questions such as:

- Which customer groups generate the most revenue?
- Do subscribed customers spend more than non-subscribers?
- Which products receive the highest ratings?
- Which products are most frequently purchased?
- Which products have the highest discount usage?
- How does spending vary across shipping methods?
- How can customers be segmented based on previous purchases?
- Which age groups contribute the most revenue?
- Which products perform best within each category?

---

## 🎯 Project Objectives

1. Clean and prepare raw customer shopping data.
2. Perform exploratory data analysis using Python.
3. Handle missing review ratings.
4. Create useful analytical features such as age groups and purchase-frequency days.
5. Load the prepared data into PostgreSQL.
6. Answer business questions using SQL.
7. Build an interactive Power BI dashboard.
8. Identify meaningful customer and product behavior patterns.
9. Present the analysis in a portfolio-ready format.

---

## 🗂️ Dataset

The original dataset contains **3,900 records** and the following 18 columns:

| Column | Description |
|---|---|
| Customer ID | Unique customer identifier |
| Age | Customer age |
| Gender | Customer gender |
| Item Purchased | Product purchased |
| Category | Product category |
| Purchase Amount (USD) | Purchase value |
| Location | Customer location |
| Size | Product size |
| Color | Product color |
| Season | Purchase season |
| Review Rating | Customer review rating |
| Subscription Status | Whether the customer is subscribed |
| Shipping Type | Shipping method selected |
| Discount Applied | Whether a discount was applied |
| Promo Code Used | Whether a promotional code was used |
| Previous Purchases | Number of previous purchases |
| Payment Method | Payment method |
| Frequency of Purchases | Customer purchase frequency |

### Data quality observations

The raw dataset contains missing values in **Review Rating**. The Python workflow handles these missing ratings by filling them with the **median rating within each product category**.

The analysis also identifies that `Promo Code Used` and `Discount Applied` carry the same information in the supplied dataset, so `Promo Code Used` is removed during preparation to avoid redundant information.

---

# 🛠️ Tech Stack

### Python
- Pandas
- NumPy
- Matplotlib
- Jupyter Notebook

### Database
- PostgreSQL
- SQL

### Visualization
- Microsoft Power BI

### Other
- Git / GitHub
- CSV

---

# 🔄 Project Workflow

```text
                    ┌─────────────────────┐
                    │   Raw CSV Dataset   │
                    └──────────┬──────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │ Python Data Cleaning │
                    │ & Feature Engineering│
                    └──────────┬──────────┘
                               │
                  ┌────────────┴────────────┐
                  ▼                         ▼
        ┌─────────────────┐       ┌─────────────────┐
        │ PostgreSQL      │       │ Power BI        │
        │ SQL Analysis    │       │ Dashboard       │
        └────────┬────────┘       └────────┬────────┘
                 │                         │
                 └────────────┬────────────┘
                              ▼
                    ┌─────────────────────┐
                    │ Business Insights   │
                    └─────────────────────┘
```

---

# 🐍 1. Python — Data Preparation & EDA

The Python notebook performs the initial exploration and preparation of the dataset.

### Main steps

#### Data loading

```python
df = pd.read_csv('customer_shopping_behavior.csv')
```

### Initial exploration

The notebook uses:

```python
df.head()
df.info()
df.describe()
df.isnull().sum()
```

to understand:

- Dataset structure
- Data types
- Statistical summaries
- Missing values

### Missing-value treatment

Missing `Review Rating` values are filled using the median rating of the corresponding category:

```python
df['Review Rating'] = df.groupby('Category')['Review Rating'].transform(
    lambda x: x.fillna(x.median())
)
```

### Column standardization

Column names are converted to lowercase and spaces are replaced with underscores.

The purchase amount column is renamed to:

```text
purchase_amount
```

### Feature Engineering

#### Age Group

Customers are divided into four groups using age quartiles:

- Young Adult
- Adult
- Middle-aged
- Senior

#### Purchase Frequency in Days

The categorical purchase frequencies are converted into approximate day values:

| Frequency | Days |
|---|---:|
| Weekly | 7 |
| Fortnightly | 14 |
| Bi-Weekly | 14 |
| Monthly | 30 |
| Quarterly | 90 |
| Every 3 Months | 90 |
| Annually | 365 |

### Redundant column removal

The notebook checks whether:

```text
Discount Applied
```

and

```text
Promo Code Used
```

contain the same information. Since they match in the supplied dataset, `Promo Code Used` is removed.

---

# 🗄️ 2. PostgreSQL — SQL Analysis

The prepared dataset is loaded into PostgreSQL as the `customer` table.

The SQL analysis contains **10 business questions**.

### Q1 — Revenue by Gender

Compare total revenue generated by male and female customers.

### Q2 — Discount Users Above Average Spend

Identify customers who used a discount but still spent more than the overall average purchase amount.

### Q3 — Top Products by Average Rating

Find the five products with the highest average review rating.

### Q4 — Express vs Standard Shipping

Compare average purchase amounts between Express and Standard shipping.

### Q5 — Subscriber vs Non-Subscriber Spending

Compare:

- Average spending
- Total revenue

between subscribed and non-subscribed customers.

### Q6 — Products with Highest Discount Usage

Find the five products with the highest percentage of purchases where a discount was applied.

### Q7 — Customer Segmentation

Segment customers according to previous purchases:

```text
1 previous purchase      → New
2–10 previous purchases  → Returning
11+ previous purchases   → Loyal
```

### Q8 — Top 3 Products in Each Category

Use a window function to identify the three most purchased products within every category.

### Q9 — Repeat Buyers and Subscription

Analyze subscription status among customers with more than five previous purchases.

### Q10 — Revenue by Age Group

Calculate revenue contribution from each age group.

---

# 📊 3. Power BI Dashboard

The Power BI dashboard provides an interactive view of customer behavior.

### Dashboard title

**Customer Behavior Analysis Dashboard**

### KPI Cards

The dashboard contains KPI cards for:

- Average Rating
- Average Purchase Value
- Customers
- Sales

### Interactive Filters / Slicers

Users can filter the dashboard by:

- Subscription Status
- Gender
- Category
- Shipping Type

### Visualizations

The dashboard includes:

#### Subscription Analysis
A donut chart showing the distribution of subscribed and non-subscribed customers.

#### Revenue by Category
A column chart comparing revenue generated by:

- Clothing
- Accessories
- Footwear
- Outerwear

#### Sales by Category
A category-level comparison of sales/purchase amounts.

#### Revenue by Age Group
A bar chart showing revenue contribution across age groups.

#### Purchase Frequency by Age Group
A comparison of purchasing activity across age groups.

---

# 📌 Dashboard Snapshot

The supplied dashboard screenshot shows the **Footwear category selected**, so the KPI values displayed there represent the filtered Footwear view rather than the entire dataset.

For example, the screenshot shows:

- Customers: **599**
- Sales: **36K**
- Average Purchase Value: **60.26**
- Average Rating: **3.79**
- Subscription distribution: **28.55% Yes / 71.45% No**

The dashboard can be interacted with through its slicers to change the filter context.

---

# 📈 Overall Dataset Metrics

Based on the supplied raw dataset:

| Metric | Value |
|---|---:|
| Total Records | 3,900 |
| Unique Customers | 3,900 |
| Total Revenue | $233,081 |
| Average Purchase Amount | $59.76 |
| Average Review Rating | 3.75 |

### Revenue by Category

| Category | Revenue |
|---|---:|
| Clothing | $104,264 |
| Accessories | $74,200 |
| Footwear | $36,093 |
| Outerwear | $18,524 |

### Subscription Overview

| Subscription Status | Customers | Revenue |
|---|---:|---:|
| No | 2,847 | $170,436 |
| Yes | 1,053 | $62,645 |

These figures describe the supplied dataset as a whole; Power BI visuals may show different values when slicers are applied.

---

# 🔍 Key Analytical Observations

The analysis reveals several useful patterns in the supplied dataset:

- **Clothing** contributes the largest share of total revenue among the four product categories.
- **Accessories** is the second-largest category by revenue.
- **Footwear** contributes approximately $36K in revenue.
- The dataset contains substantially more **non-subscribed customers** than subscribed customers.
- The average purchase amount is close to **$60**.
- **Express shipping** has a higher average purchase amount than Standard shipping in the supplied data.
- The age-group analysis shows differences in revenue contribution and purchase activity across customer segments.
- Product-level analysis can be used to identify highly rated products and products with high discount usage.

These observations are descriptive of the supplied dataset and are not intended to imply causation.

---

# 🧠 Skills Demonstrated

This project demonstrates practical skills in:

### Python
- Data loading
- Data inspection
- Exploratory Data Analysis
- Missing-value handling
- Group-based imputation
- Feature engineering
- Data transformation
- Pandas
- NumPy
- Matplotlib

### SQL
- SELECT
- WHERE
- GROUP BY
- ORDER BY
- Aggregate functions
- CASE statements
- Subqueries
- CTEs
- Window functions
- `ROW_NUMBER()`
- Filtering with aggregate-derived metrics

### Power BI
- Data visualization
- KPI cards
- Slicers
- Interactive filtering
- Category analysis
- Customer segmentation
- Age-group analysis
- Dashboard design

### Data Analytics
- Data cleaning
- Business-question formulation
- Customer segmentation
- Revenue analysis
- Product analysis
- Customer behavior analysis
- Business insight generation

---

# 📁 Project Structure

```text
Customer-Shopping-Behavior-Analysis/
│
├── customer_shopping_behavior.csv
│
├── Customer_shopping_behavior_analysis.ipynb
│
├── customer_behavior_analysis.sql
│
├── Customer_Behavior_Analysis.pbix
│
│
└── README.md
```

---

# ⚙️ How to Run the Project

## 1. Clone the repository

```bash
git clone <your-repository-url>
cd Customer-Shopping-Behavior-Analysis
```

## 2. Install Python dependencies

```bash
pip install pandas numpy matplotlib sqlalchemy psycopg2-binary
```

## 3. Run the Python notebook

Open:

```text
Customer_shopping_behavior_analysis.ipynb
```

Run the notebook from top to bottom.

The notebook will:

1. Load the CSV.
2. Inspect the data.
3. Handle missing review ratings.
4. Standardize column names.
5. Create age groups.
6. Convert purchase frequency into day values.
7. Remove redundant information.
8. Load the prepared dataset into PostgreSQL.

## 4. PostgreSQL

Create a PostgreSQL database and configure the connection details in the notebook.

Then execute:

```text
customer_behavior_analysis.sql
```

to reproduce the SQL analysis.

## 5. Power BI

Open:

```text
Customer_Behavior_Analysis.pbix
```

Refresh the data if required and interact with the slicers to explore the dashboard.

---

# ⚠️ Implementation Notes

Two small source-file issues should be checked before running the project from scratch:

1. In the SQL file, the Q9 query references `previous_purchses`; the dataset column is `previous_purchases`.
2. In the notebook's PostgreSQL connection code, the database variable is defined as `database`, but the connection string references `databse`.

These are execution-level issues in the supplied files and should be corrected before reproducing the full workflow.

**Security note:** do not commit database passwords or other credentials to GitHub. Use environment variables or a local configuration file excluded through `.gitignore`.

---

# 💼 Resume Project Description

**Customer Shopping Behavior Analysis | Python, PostgreSQL, Power BI**

> Developed an end-to-end customer shopping behavior analytics project using Python, PostgreSQL, and Power BI. Cleaned and transformed 3,900 customer purchase records, handled missing review ratings, engineered customer age and purchase-frequency features, and performed SQL-based analysis using CTEs, subqueries, CASE statements, and window functions. Built an interactive Power BI dashboard to analyze revenue, customer segments, subscription behavior, product performance, shipping preferences, and purchasing patterns.

---

# 👨‍💻 Author

**Adnan Khan**

Data Analyst | Python | SQL | Power BI | Excel

---

## ⭐ Project Highlights

```text
3,900+ Records
      ↓
Python Data Cleaning
      ↓
Feature Engineering
      ↓
PostgreSQL Analysis
      ↓
10 Business Questions
      ↓
Power BI Dashboard
      ↓
Customer & Revenue Insights
```

> This project demonstrates an end-to-end data analytics workflow from raw customer data to business-focused reporting and visualization.
