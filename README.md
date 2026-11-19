# 🛍️ Olist Brazilian E-Commerce — End-to-End Data Analysis & Power BI Project

## 📌 Project Overview
This project delivers an end-to-end data analysis solution for the *Olist Brazilian E-Commerce* dataset across the full analytics pipeline—from data cleaning and statistical exploration to interactive Power BI dashboards. By analyzing transactional, pricing, freight, payment, review, and regional records, the project evaluates revenue and shipping performance, customer distribution, category trends, and key statistical drivers influencing freight value.

---

## 🛠 Technical Stack & Analytical Workflow

* Excel (Data Cleaning & Initial Validation): Inspected and cleaned raw multi-table records, handled missing values, duplicates, and formatting inconsistencies, and performed initial statistical and distribution checks prior to database ingestion.
* SQL (Data Cleaning, KPIs & Statistical Analysis): Authored analytical queries to clean and standardize data, compute core KPIs (Total Price, Total Freight Value, Total Payment Value, Total Payment Installments, Median Price, and Median Freight Value), and run statistical aggregations and segmented comparisons.
* *Python (NumPy, Pandas, Matplotlib, Seaborn):* Performed data cleaning, wrangling, and statistical profiling (central tendency, medians vs. totals/averages, dispersion, and category breakdowns) in Pandas and NumPy, paired with exploratory visualizations in Matplotlib and Seaborn.
* Power BI (Interactive Dashboards & Statistical Insights): Built a 2-page dark-themed interactive dashboard featuring KPI cards, gauge targets, flow visuals, pie/bar breakdowns, interactive slicers, and *Key Influencers* analysis.

---

## 📊 Key Findings & Business Insights

### 1. Executive & Customer Overview (Page 1)
* Core Revenue & Freight KPIs: Total Price reached $13.59M (vs. $15.00M target), Total Freight Value reached $2.25M (vs. $2.50M target), Total Payment Value reached $16.01M (surpassing the $16.00M target), and Total Payment Installments reached 296K.
* Statistical Central Tendency: Median Price stands at $74.99 and Median Freight Value stands at $16.26, providing robust baseline benchmarks alongside cumulative totals under skewed e-commerce distributions.
* Customer Review Distribution: Top rating (5) accounts for 57.78% of reviews, followed by 19.29% for rating 4, 11.51% for rating 1, and 8.24% for rating 3, with the smallest share for rating 2.
* Geographic Concentration:
São Paulo leads customer volume with 16K, followed by Rio de Janeiro (7K), Belo Horizonte (3K), Brasília (2K), Curitiba (2K), Campinas (1K), and Porto Alegre (1K).

### 2. Category Pricing, Freight & Key Influencers (Page 2)
* Freight Value by Category: Categories such as pcs (42), moveis_colchao_e_est... (39), moveis_quarto (38), and eletrodomesticos_2 (36) sit at the top of median freight value.
* Price by Category: pcs leads median price at 1100, followed by portateis_casa_forno_... (587), agro_industria_e_com... (259), and eletrodomesticos_2 (226).
* Key Influencers Analysis: Average Total Freight Value shows notable upward shifts when product_weight_g exceeds 11350 (+47.54), when product_category_name is moveis_escritorio (+31.53), when product_length_cm is greater than 51 (+16.74), or when product_weight_g falls between 5850 and 11350 (+14.94).

---

## 📷 Dashboard Previews

| Page 1: Executive & Customer Overview |
| :---: |
<img width="1340" height="743" alt="Screenshot 2026-11-19 173002" src="https://github.com/user-attachments/assets/07d85485-661d-4d18-a835-e993aca69276" />

| Page 2: Category Pricing, Freight & Key Influencers |
| :---: |
<img width="1336" height="746" alt="Screenshot 2026-11-19 173026" src="https://github.com/user-attachments/assets/bf9caece-8062-4981-8eec-80126e8780cd" />

---

## 📁 Repository Structure

```text
├── excel/                      # Cleaned workbooks & initial validation sheets
├── sql/                        # Data cleaning, KPI & statistical SQL scripts
├── python/                     # EDA, data cleaning & statistical analysis scripts/notebooks
├── powerbi/                    # Interactive Power BI dashboard file (.pbix)
└── README.md                   # Project documentation

Strategic Recommendations
1. Freight & Packaging Optimization: Audit shipping rates and packaging dimensions/weights for heavy and oversized categories (such as moveis_escritorio, moveis_colchao_e_est..., and items with product_weight_g > 11350 or product_length_cm > 51) to control freight cost escalation.  
2. Regional Logistics & Fulfillment: Focus inventory positioning and delivery speed in high-demand hubs like São Paulo and Rio de Janeiro to protect conversion and sustain high review scores.  
3. Median-Informed Pricing & Margin Review: Pair median price and freight benchmarks ($74.99 and $16.26) with category-level margins so high-freight or high-ticket categories maintain healthy profitability.
