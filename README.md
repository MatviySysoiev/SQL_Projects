# SQL Engineering & Data Analytics Portfolio

A comprehensive portfolio showcasing data engineering, complex data cleaning pipelines, and exploratory data analysis (EDA) using **SQL Server (T-SQL)** and **MySQL**.

## 🛠️ Tech Stack & Tools
* **Dialects:** T-SQL (SQL Server), MySQL
* **Key Skills:** Data Architecture, Data Cleaning, ETL Staging, Window Functions, Advanced CTEs, Stored Procedures, Conditional Logic

---

## 📂 Project Structure & Core Features

### 1. Data Cleaning Pipeline (`Data Cleaning. Practice.sql`)
A complete, step-by-step ETL staging pipeline designed to transform a raw, unformatted dataset into a production-ready clean table.
* **Duplicate Management:** Implemented an automated deduplication process utilizing `ROW_NUMBER()` over partition windows combined with secondary staging tables to safely delete duplicate entries.
* **Data Standardization:** Normalized data inconsistencies using string manipulation functions (`TRIM`, `TRAILING`), fuzzy text matching (`LIKE 'Crypto%'`), and dynamic type casting (`STR_TO_DATE`).
* **Null & Missing Value Imputation:** Fixed structural deficiencies by designing self-joins (`INNER JOIN` on matching attributes) to populate blank fields dynamically from relative records.

### 2. Exploratory Data Analysis (`Exploring Data. Practice.sql`)
Advanced business intelligence and analytical querying to extract historical trends and insights from metrics.
* **Rolling Aggregations:** Engineered time-series analysis queries using multi-layered Common Table Expressions (CTEs) combined with rolling window sums (`SUM() OVER(PARTITION BY... )`).
* **Dynamic Ranking:** Developed top-tier performance tracking matrices utilizing dense ranking systems (`DENSE_RANK() OVER()`) filtered through conditional subqueries.

### 3. Business Logic & Automation (`Stored Procedures. Practice.sql`)
Database modularity and automation scripts designed for safe execution, data manipulation, and administrative workflows.
* **Stored Procedures:** Formulated flexible routines with dynamic entry parameters (`IN` / `OUT`) for employee and departmental accounting.
* **Conditional Control Flow:** Built internal logic modules using declarative syntax (`IF-ELSEIF-ELSE`) to map dynamic classification thresholds directly inside database schemas.

### 4. General Queries (`General Practice.sql`)
* A collection of foundational and intermediate queries demonstrating core SQL proficiency, including multi-table joins, custom aggregations, and advanced sorting.