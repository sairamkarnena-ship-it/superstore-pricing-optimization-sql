# 📊 Superstore Pricing Optimization Using SQL

## 📌 Project Overview

This project analyzes the impact of discount strategies on profitability
using the Superstore dataset.

The objective was to:

-   Identify profit leakage due to discounting\
-   Detect loss-making product categories and regions\
-   Analyze discount sensitivity per sub-category\
-   Design a data-driven discount optimization strategy\
-   Simulate different pricing policies using SQL

This project focuses on **business decision modeling using SQL**, not
just basic aggregation.

------------------------------------------------------------------------

## 🗂 Dataset

**Dataset:** Superstore Sales Dataset\
**Rows:** \~9,994

### Key Columns:

-   Ship Mode\
-   Segment\
-   Country\
-   City\
-   State\
-   Region\
-   Category\
-   Sub-Category\
-   Sales\
-   Quantity\
-   Discount\
-   Profit

------------------------------------------------------------------------

## 🛠 SQL Techniques Used

-   Aggregations (SUM, AVG, COUNT)
-   GROUP BY & HAVING
-   Window Functions (RANK with PARTITION BY)
-   Common Table Expressions (CTE)
-   CASE statements
-   Scenario simulation
-   Multi-dimensional analysis
-   Profit optimization modeling

------------------------------------------------------------------------

## 🔎 Key Analysis Performed

### 1️⃣ Discount Impact Analysis

-   Identified that profit declines significantly beyond 30% discount.
-   High discounts (≥ 50%) generated substantial cumulative losses.
-   70% and 80% discounts were especially destructive.

### 2️⃣ Region + Category Performance

-   Analyzed profitability by region and category.
-   Detected underperforming region-category combinations.
-   Identified structural weaknesses in specific regions.

### 3️⃣ Loss Root Cause Detection

-   Used window functions to find top 3 loss-making sub-categories per
    region.
-   Detected recurring loss drivers such as Tables and Machines.
-   Connected high discounts directly to sub-category losses.

### 4️⃣ Dangerous Discount--Subcategory Combinations

Identified combinations causing the highest total losses across the
company.

### 5️⃣ Scenario Modeling

Simulated multiple pricing strategies to evaluate profitability impact.

------------------------------------------------------------------------

## 📈 Business Insights

-   Majority of sub-categories are only safe up to 20% discount.
-   Tables, Storage, and Supplies are highly discount-sensitive.
-   Machines and Copiers tolerate moderate discounts.
-   Aggressive discounting strategy was structurally reducing
    profitability.
-   Dynamic sub-category specific caps significantly improved projected
    profit.

------------------------------------------------------------------------

## 🧠 Final Recommendation

Implement a **dynamic, sub-category based discount cap strategy**
derived from historical profitability thresholds.

This approach: - Increases profitability - Minimizes unnecessary
losses - Avoids blanket pricing policies - Supports data-driven pricing
decisions

------------------------------------------------------------------------

## 👨‍💻 Tools Used

-   PostgreSQL\
-   pgAdmin 4\
-   SQL

------------------------------------------------------------------------

## 📌 Author

**Sairam Karnena**\
Aspiring Data Analyst \| SQL & Business Analytics Enthusiast
