CREATE DATABASE IF NOT EXISTS us_consumer_credit_risk;
USE us_consumer_credit_risk;
DROP TABLE IF EXISTS consumer_loan_applications;
CREATE TABLE consumer_loan_applications (
 Application_ID VARCHAR(20) PRIMARY KEY, Customer_ID VARCHAR(20) NOT NULL, Application_Date DATE NOT NULL,
 State CHAR(2), Age TINYINT, Employment_Years DECIMAL(5,1), Employment_Type VARCHAR(30), Annual_Income DECIMAL(12,2),
 Home_Ownership VARCHAR(20), Loan_Purpose VARCHAR(50), Loan_Product VARCHAR(50), Acquisition_Channel VARCHAR(30),
 Credit_Score SMALLINT, DTI_Ratio DECIMAL(6,4), Delinquencies_2Y TINYINT, Inquiries_6M TINYINT, Open_Accounts TINYINT,
 Revolving_Balance DECIMAL(12,2), Revolving_Utilization DECIMAL(6,4), Installment_Accounts TINYINT,
 Credit_History_Years DECIMAL(5,1), Loan_Amount DECIMAL(12,2), Term_Months SMALLINT, Interest_Rate_Pct DECIMAL(5,2),
 Monthly_Payment DECIMAL(12,2), Risk_Probability DECIMAL(6,4), Risk_Band CHAR(1), Application_Decision VARCHAR(20),
 Loan_Status VARCHAR(30), Default_Flag TINYINT, Delinquency_Days SMALLINT, Origination_Fee DECIMAL(12,2), Expected_Loss DECIMAL(12,2),
 INDEX idx_date(Application_Date), INDEX idx_risk(Risk_Band), INDEX idx_status(Loan_Status), INDEX idx_state(State), INDEX idx_customer(Customer_ID)
);
