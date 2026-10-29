USE us_consumer_credit_risk;
-- Recommended: MySQL Workbench > Schemas > us_consumer_credit_risk > right-click Tables > Table Data Import Wizard.
-- Select US_Consumer_Loan_Credit_Risk_Dataset.csv and import into consumer_loan_applications.
-- Map all 34 headers to the matching columns and finish the wizard.
-- Validate the import with 03_validation_and_quality_checks.sql.
-- Optional LOAD DATA LOCAL INFILE example (edit path and enable LOCAL INFILE first):
-- LOAD DATA LOCAL INFILE 'C:/Users/YourName/Downloads/US_Consumer_Loan_Credit_Risk_Dataset.csv'
-- INTO TABLE consumer_loan_applications CHARACTER SET utf8mb4
-- FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
-- LINES TERMINATED BY '\\n' IGNORE 1 LINES;
