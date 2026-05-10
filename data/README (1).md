# Loan Default Prediction & Risk Classification System with Inflation Risk Analysis

## Project Overview

This project analyzes **304,590 real SBA 7(a) government loan records** to predict loan defaults, classify borrower risk, and assess inflation impact on the lending market. It combines machine learning, SQL analytics, and an Excel VBA dashboard to deliver a complete end-to-end loan risk intelligence system.

The project is designed to mirror real-world workflows used in investment banking, securitization analysis, and financial risk management.

---

## Key Findings

| #   | Finding                                                                                                         |
| --- | --------------------------------------------------------------------------------------------------------------- |
| 1   | Overall default rate is **5.85%** — 17,823 loans defaulted out of 304,590                                       |
| 2   | Total money lost to defaults: **$743 million** — average loss per default: **$41,722**                          |
| 3   | Bigger loans are SAFER — loans over $750K default at only **3.54%** vs **8.39%** for loans under $50K           |
| 4   | Startups default at **7.53%**, nearly 2x the rate of established businesses (3.79%)                             |
| 5   | Geographic location is the #1 predictor — DC (10.56%), NY (9.60%), FL (7.92%) are highest risk                  |
| 6   | TD Bank is the biggest systemic risk at **15.72% default rate** across 13,713 loans, nearly 3x industry average |
| 7   | **2023 was the worst year** — 9.75% default rate during the Federal Reserve aggressive rate hike cycle          |
| 8   | XGBoost ML model achieved **AUC of 0.6743**, best at identifying future defaulters                              |
| 9   | Inflation correlation is **-0.3560** — rate hikes cause a short-term spike then a long-term drop in defaults    |
| 10  | Only **40.6%** of loan pool qualifies as Investment Grade (AAA) for securitization deals                        |

## Data Source

The dataset used in this project is sourced from the **U.S. Small Business Administration (SBA) FOIA dataset**, which contains real approved SBA 7(a) and 504 loan records.

**Download the dataset here:**
[https://data.sba.gov/dataset/7-a-504-foia](https://data.sba.gov/dataset/7-a-504-foia)

> Note: Raw data files are not included in this repository due to file size (145MB+). Download the dataset from the link above and place it in the `data/raw/` folder before running the notebooks.

---

## Tech Stack

| Category        | Tools Used                                      |
| --------------- | ----------------------------------------------- |
| Language        | Python 3.9+, SQL                                |
| ML Libraries    | XGBoost, Scikit-learn, imbalanced-learn (SMOTE) |
| Data Processing | Pandas, NumPy                                   |
| Visualization   | Matplotlib, Seaborn                             |
| Database        | PostgreSQL                                      |
| Dashboard       | Microsoft Excel, VBA                            |
| Notebook        | Jupyter Notebook                                |

---

## Machine Learning Pipeline

Four models were trained and evaluated:

| Model               | AUC Score         |
| ------------------- | ----------------- |
| Logistic Regression | Baseline          |
| Decision Tree       | -                 |
| Random Forest       | -                 |
| **XGBoost**         | **0.6743 (Best)** |

**Key steps in the pipeline:**

- Data cleaning and feature engineering on 304,590 records
- SMOTE applied to handle class imbalance between default and non-default loans
- Feature importance analysis — geographic location (19%) and startup status (17%) are the strongest predictors
- Final model saved as `xgboost_loan_default.pkl`

---

## Risk Classification Engine

Every borrower is scored across 5 risk factors:

1. Loan amount
2. Interest rate
3. Business age
4. Jobs supported
5. SBA guarantee percentage

**Risk categories and automated decisions:**

| Risk Category | Loans   | Default Rate | Avg Loan | Decision | Pool Grade             |
| ------------- | ------- | ------------ | -------- | -------- | ---------------------- |
| Low Risk      | 123,681 | 5.18%        | $468,784 | APPROVE  | AAA - Investment Grade |
| Medium Risk   | 138,069 | 5.87%        | $576,687 | REVIEW   | BBB - Substandard      |
| High Risk     | 42,840  | 7.72%        | $621,214 | REJECT   | CCC - High Risk        |

**Automated interest rate recommendations:**

- Low Risk: **7.02%** with APPROVE decision
- Medium Risk: **9.13%** with REVIEW decision
- High Risk: **11.91%** with REJECT decision

---

## SQL Analytics

The `sql/loan_risk_analysis.sql` file contains **10 analytical queries** covering:

1. Overall default rate summary
2. Industry-level default analysis
3. Loan size vs risk segmentation
4. Bank risk ranking and systemic risk flags
5. State-level geographic concentration risk
6. Business age impact on default rates
7. Securitization pool quality stratification
8. Yearly default trend analysis
9. Interest rate pattern analysis
10. Average loss per default by category

---

## Excel VBA Dashboard

The `LoanRisk_Dashboard.xlsm` file contains a **7-sheet interactive dashboard** with a one-click VBA refresh macro:

| Sheet                | Description                                            |
| -------------------- | ------------------------------------------------------ |
| Executive Summary    | KPI panel, risk category summary, top 10 key findings  |
| Default Analysis     | Default rates by loan size, industry, and business age |
| Bank Risk            | Bank-level default rates and systemic risk flags       |
| Securitization Pool  | Pool stratification by investment grade (AAA/BBB/CCC)  |
| State Risk           | Geographic risk concentration by US state              |
| Business Categories  | Default analysis by industry and business type         |
| Yearly Default Trend | Year-over-year default trend with Fed rate overlay     |

---

## Inflation Risk Analysis

- Integrated **Federal Reserve interest rate data from 2000 to 2026**
- Quantified a **-0.3560 correlation** between Fed rate cycles and loan default rates
- Identified **2023 as the peak stress year** (9.75% default rate) during the aggressive rate hike cycle
- **2024 stabilized at 5.10%** as rate hikes slowed

---

## How to Run

**1. Clone the repository**

```bash
git clone https://github.com/kanchankataria/Loan-Default-Prediction-and-Risk-Classification-System.git
cd Loan-Default-Prediction-and-Risk-Classification-System
```

**2. Install required libraries**

```bash
pip install pandas numpy scikit-learn xgboost imbalanced-learn matplotlib seaborn openpyxl jupyter
```

**3. Download the dataset**

Download from [https://data.sba.gov/dataset/7-a-504-foia](https://data.sba.gov/dataset/7-a-504-foia) and place files in `data/raw/`

**4. Run the notebooks in order**

```bash
jupyter notebook data/explore_data.ipynb   # Step 1: Data cleaning and EDA
jupyter notebook data/dashboard.ipynb      # Step 2: ML pipeline and risk scoring
```

**5. Open the Excel Dashboard**

Open `outputs/LoanRisk_Dashboard.xlsm` in Microsoft Excel and click **Enable Content** to activate the VBA refresh macro.

---

## Author

**Kanchan Kataria**

- GitHub: [kanchankataria](https://github.com/kanchankataria)

---

## License

This project is for educational and portfolio purposes. The dataset is publicly available from the U.S. Small Business Administration.
