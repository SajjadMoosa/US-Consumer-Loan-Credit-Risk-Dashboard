USE us_consumer_credit_risk;
-- Executive KPIs
SELECT COUNT(*) Total_Applications, SUM(Application_Decision='Approved') Approved_Applications,
 ROUND(100*SUM(Application_Decision='Approved')/COUNT(*),2) Approval_Rate_Pct,
 SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure,
 SUM(Expected_Loss) Illustrative_Expected_Loss,
 ROUND(100*SUM(Default_Flag)/NULLIF(SUM(Application_Decision='Approved'),0),2) Late_Or_ChargeOff_Rate_Pct
FROM consumer_loan_applications;
-- Risk band performance
SELECT Risk_Band, COUNT(*) Applications, ROUND(AVG(Risk_Probability)*100,2) Avg_Risk_Pct,
 SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure, SUM(Expected_Loss) Expected_Loss
FROM consumer_loan_applications GROUP BY Risk_Band ORDER BY Risk_Band;
-- Monthly trend
SELECT DATE_FORMAT(Application_Date,'%Y-%m') Month, COUNT(*) Applications, SUM(Application_Decision='Approved') Approvals,
 ROUND(100*SUM(Application_Decision='Approved')/COUNT(*),2) Approval_Rate_Pct
FROM consumer_loan_applications GROUP BY DATE_FORMAT(Application_Date,'%Y-%m') ORDER BY Month;
-- Loan purpose exposure and loss
SELECT Loan_Purpose, COUNT(*) Applications, SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure,
 SUM(Expected_Loss) Expected_Loss FROM consumer_loan_applications GROUP BY Loan_Purpose ORDER BY Expected_Loss DESC;
-- Acquisition channel
SELECT Acquisition_Channel, COUNT(*) Applications, ROUND(100*SUM(Application_Decision='Approved')/COUNT(*),2) Approval_Rate_Pct,
 ROUND(AVG(Risk_Probability)*100,2) Avg_Risk_Pct, SUM(Expected_Loss) Expected_Loss
FROM consumer_loan_applications GROUP BY Acquisition_Channel ORDER BY Applications DESC;
-- State risk
SELECT State, COUNT(*) Applications, SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure,
 SUM(Expected_Loss) Expected_Loss, ROUND(100*SUM(Default_Flag)/NULLIF(SUM(Application_Decision='Approved'),0),2) Late_Or_ChargeOff_Rate_Pct
FROM consumer_loan_applications GROUP BY State ORDER BY Expected_Loss DESC;
-- Credit score and DTI cohort (descriptive monitoring only)
SELECT CASE WHEN Credit_Score<620 THEN '<620' WHEN Credit_Score<680 THEN '620-679' WHEN Credit_Score<740 THEN '680-739' ELSE '740+' END Credit_Score_Band,
 CASE WHEN DTI_Ratio<.20 THEN '<20%' WHEN DTI_Ratio<.36 THEN '20-35.9%' WHEN DTI_Ratio<.50 THEN '36-49.9%' ELSE '50%+' END DTI_Band,
 COUNT(*) Applications, ROUND(AVG(Risk_Probability)*100,2) Avg_Risk_Pct, SUM(Expected_Loss) Expected_Loss
FROM consumer_loan_applications GROUP BY Credit_Score_Band,DTI_Band ORDER BY Credit_Score_Band,DTI_Band;
