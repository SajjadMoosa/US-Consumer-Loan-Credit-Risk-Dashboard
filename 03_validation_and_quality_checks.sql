USE us_consumer_credit_risk;
SELECT COUNT(*) AS total_applications, MIN(Application_Date) AS first_date, MAX(Application_Date) AS last_date FROM consumer_loan_applications;
SELECT Application_ID, COUNT(*) FROM consumer_loan_applications GROUP BY Application_ID HAVING COUNT(*)>1;
SELECT SUM(Application_ID IS NULL) AS missing_id, SUM(Customer_ID IS NULL) AS missing_customer, SUM(Application_Date IS NULL) AS missing_date,
 SUM(Credit_Score IS NULL) AS missing_score, SUM(Loan_Amount IS NULL) AS missing_amount FROM consumer_loan_applications;
SELECT SUM(Credit_Score NOT BETWEEN 300 AND 850) AS invalid_score, SUM(DTI_Ratio NOT BETWEEN 0 AND 1) AS invalid_dti,
 SUM(Revolving_Utilization NOT BETWEEN 0 AND 1) AS invalid_utilization, SUM(Loan_Amount<=0) AS invalid_loan_amount
FROM consumer_loan_applications;
SELECT Application_Decision, Loan_Status, COUNT(*) AS applications FROM consumer_loan_applications GROUP BY Application_Decision,Loan_Status ORDER BY applications DESC;
