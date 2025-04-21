# Fetch Data Analyst Take-Home Assessment

## Part I: Explore the Data

🗂️ Please refer to the notebook:  
📓 👉 [Fetch DA Take Home - EDA.ipynb](./Exploratory%20Data%20Analysis/Fetch%20DA%20Take%20Home%20-%20EDA.ipynb)

---

### 📊 Exploratory Data Analysis Reports

Download and open these HTML files locally to view the full interactive reports:

- 👉 [User EDA Report](./Exploratory%20Data%20Analysis/Users_EDA_Analysis_Report.html)
- 👉 [Product EDA Report](./Exploratory%20Data%20Analysis/Products_EDA_Analysis_Report.html)
- 👉 [Transaction EDA Report](./Exploratory%20Data%20Analysis/Transactions_EDA_Analysis_Report.html)

> ⚠️ **Note**: GitHub does not render interactive HTML files in-browser. Please download and open them locally to explore the full reports.

---

### 🔍 Data Quality Issues

While the dataset is quite rich, I observed several data quality issues during initial exploration:

#### **Users dataset**
- `STATE`, `GENDER`, `BIRTH_DATE`, and especially `LANGUAGE` have missing values — with `LANGUAGE` missing in over 30% of records. This limits user segmentation or demographic-level analysis.

#### **Transactions dataset**
- `FINAL_QUANTITY` included both numeric values and the string `'zero'`, suggesting inconsistent data entry or ingestion. I cleaned this column by converting all values to numeric and replaced `0` with `1` based on the business assumption that if a user scanned a receipt, they most likely purchased at least one unit.
- `FINAL_SALE` is missing in 25% of rows, and both `FINAL_SALE` and `FINAL_QUANTITY` are highly skewed — which may require transformation or outlier handling in downstream analysis.
- `BARCODE` is missing in about 11.5% of transactions, which could affect joins with the Products table.

#### **Products dataset**
- `CATEGORY_4` is missing in 92% of records, limiting its usefulness for product segmentation.
- `MANUFACTURER` and `BRAND` each have about 27% missing data and include placeholder entries like `"PLACEHOLDER MANUFACTURER"` and `"BRAND NEEDS REVIEW"` that appear to be temporary or unfinalized.

---

### 🧠 Fields That Are Challenging to Understand

A few fields stood out as particularly ambiguous during the cleaning and exploration process:

#### `FINAL_QUANTITY` (Transactions)
Initially confusing due to the presence of the string `'zero'` and numeric zeros. It was unclear whether 0 meant “not purchased” or was a placeholder. Based on the receipt-scanning business context, I assumed these values reflected actual purchases and standardized them to `1`.

#### `CATEGORY_1–4` (Products)
The product category fields seem to follow a hierarchical structure, but their depth and usage vary significantly across rows. Some records only populate `CATEGORY_1` and `CATEGORY_2`, while others go down to `CATEGORY_4`. Without a defined taxonomy or documentation, it’s difficult to assess the consistency or analytical value of these fields.

#### `BRAND` and `MANUFACTURER`
Some entries contain placeholders or unclear names, raising questions about data completeness and whether these fields are finalized or ready for analysis.

---


## Part II: Provide SQL Queries

📁 Please refer to the full query scripts in: 
   👉 [`SQL_Queries`](./SQL_Queries/)  
including comments on key assumptions and step‑by‑step logic for each business question.



---


## Part III: Slack Message with Stakeholders

### 📢 Summary of Findings

Hi team! I wanted to share a quick update from my initial analysis of the datasets:

#### 🔍 Key Data Quality Issues
- **Missing Demographics:** Nearly **99.5%** of Health & Wellness sales couldn’t be linked to user demographics. Only **17 out of ~3,000 customers** had matching records in Users Dataset, limiting our ability to analyze generational trends or segment customers effectively.
- **User Data Missing Values:** Fields like `LANGUAGE` (missing ~30%) and `BIRTH_DATE` (missing ~4%) show significant gaps.
- **Inconsistent Quantity Values:** The `FINAL_QUANTITY` field in the Transactions dataset contained mixed types (e.g., the string `'zero'`).  
  Based on the receipt-scanning context, I standardized all zeros to **1**, assuming these reflect actual purchases.  
  _(Happy to revisit this assumption if needed.)_

#### 📈 Interesting Trend
- **TOSTITOS** emerged as the top brand in the **Dips & Salsa** category, leading in both quantity sold and customer reach.  
  This points to strong brand preference and could inform targeted promotions or brand partnerships through Fetch.

#### ✅ Next Steps
- I recommend reviewing our **data collection practices** and taking a closer look at the **user-transaction-product mapping processes** to address the large gaps in demographic coverage. Improving data completeness will significantly enhance our ability to surface meaningful, actionable insights.


Let me know if you'd like to dive deeper into any of these findings or explore additional angles!
