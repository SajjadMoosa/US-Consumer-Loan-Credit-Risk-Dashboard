# US Consumer Loan Credit Risk & Portfolio Analytics Dashboard

Advanced portfolio project using **MySQL + Power BI** to analyze synthetic consumer-loan applications, underwriting decisions, risk bands, late/charge-off indicators, expected loss, geography, and acquisition channels.

> **Data disclaimer:** all records are synthetic. This is an educational portfolio demo, not real consumer credit data, a validated risk model, lending advice, or a tool for real credit decisions. Risk probability and expected loss are illustrative.

## Dataset
- 12,000 rows, 34 columns
- Application dates across 2024–2025
- USD values and US state abbreviations
- `Data_Dictionary.csv` describes every field

## Tech stack
MySQL 8.x, MySQL Workbench, Power BI Desktop, SQL views, DAX, GitHub.

## Repository structure
```text
US-Consumer-Loan-Credit-Risk/
├── data/
│   ├── US_Consumer_Loan_Credit_Risk_Dataset.csv
│   └── Data_Dictionary.csv
├── sql/
│   ├── 01_create_database_and_table.sql
│   ├── 02_import_csv.sql
│   ├── 03_validation_and_quality_checks.sql
│   ├── 04_create_analytics_views.sql
│   └── 05_business_analysis_queries.sql
├── powerbi/       # add your completed .pbix file here
├── screenshots/   # add screenshots of report pages here
├── insights/
│   └── Business_Insights.md
└── README.md
```

## Step-by-step setup
1. Download the project ZIP and extract it.
2. Open MySQL Workbench and connect to your local MySQL server.
3. Open `01_create_database_and_table.sql` and click the lightning-bolt Execute button.
4. In Schemas, expand `us_consumer_credit_risk`, right-click **Tables** or the schema, and choose **Table Data Import Wizard**.
5. Select `US_Consumer_Loan_Credit_Risk_Dataset.csv`; import into `consumer_loan_applications`; confirm all column mappings.
6. Run `03_validation_and_quality_checks.sql`. The row count should be 12,000.
7. Run `04_create_analytics_views.sql` and `05_business_analysis_queries.sql`.
8. Open Power BI Desktop → **Get Data** → **MySQL database**. Server: `localhost`; Database: `us_consumer_credit_risk`. Enter your MySQL username/password.
9. Import `consumer_loan_applications` and optionally the `vw_` SQL views.
10. Build the pages listed below, then save as `US_Consumer_Loan_Credit_Risk_Dashboard.pbix`.

## Recommended 8 Power BI pages
1. **Executive Risk Overview** — applications, approval rate, approved exposure, expected loss, late/charge-off rate, average credit score.
2. **Credit Risk Segmentation** — volume, exposure, expected loss, and late/charge-off rate by risk band A–E.
3. **Underwriting & Approval** — approved vs rejected, approval rate by credit score band, DTI and income.
4. **Delinquency & Loan Performance** — loan status mix, delinquency days, late/charge-off indicators.
5. **Portfolio Exposure & Expected Loss** — exposure and expected loss by loan purpose, product, and term.
6. **Geographic Risk** — applications, exposure, expected loss by state.
7. **Customer Credit Profile** — credit score, DTI, utilization, prior delinquencies, inquiries, employment tenure.
8. **Channel & Monthly Trends** — acquisition-channel comparisons and monthly application/approval/exposure trends.

## Suggested slicers
Application Date, State, Risk Band, Loan Purpose, Loan Product, Acquisition Channel, Employment Type, Application Decision, Loan Status.

## Core DAX measures
Assume your imported table is named `consumer_loan_applications`.

```DAX
Total Applications = DISTINCTCOUNT(consumer_loan_applications[Application_ID])

Approved Applications =
CALCULATE([Total Applications], consumer_loan_applications[Application_Decision] = "Approved")

Rejected Applications =
CALCULATE([Total Applications], consumer_loan_applications[Application_Decision] = "Rejected")

Approval Rate % = DIVIDE([Approved Applications], [Total Applications], 0)

Approved Exposure =
CALCULATE(SUM(consumer_loan_applications[Loan_Amount]),
    consumer_loan_applications[Application_Decision] = "Approved")

Total Expected Loss =
CALCULATE(SUM(consumer_loan_applications[Expected_Loss]),
    consumer_loan_applications[Application_Decision] = "Approved")

Late or Charge-Off Applications =
CALCULATE([Total Applications], consumer_loan_applications[Default_Flag] = 1,
    consumer_loan_applications[Application_Decision] = "Approved")

Late or Charge-Off Rate % =
DIVIDE([Late or Charge-Off Applications], [Approved Applications], 0)

Average Credit Score = AVERAGE(consumer_loan_applications[Credit_Score])
Average DTI % = AVERAGE(consumer_loan_applications[DTI_Ratio])
Average Interest Rate % = AVERAGE(consumer_loan_applications[Interest_Rate_Pct])
Average Risk Probability % = AVERAGE(consumer_loan_applications[Risk_Probability])
```

Format the rate measures as Percentage. `DTI_Ratio` and `Risk_Probability` are decimals, so percentage formatting is appropriate.

## Business questions
- Which risk bands contribute the most exposure and expected loss?
- How does approval rate vary by credit score and DTI?
- Which loan purposes and products carry the greatest exposure?
- Which states show elevated synthetic late/charge-off indicators?
- How do applications and approvals change by month?
- Which acquisition channels bring the most applications and what risk profile do they show?

See `insights/Business_Insights.md` for a calculated synthetic-data snapshot and suggested management actions.
