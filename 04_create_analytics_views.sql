USE us_consumer_credit_risk;
CREATE OR REPLACE VIEW vw_credit_risk_overview AS
SELECT COUNT(*) Total_Applications, SUM(Application_Decision='Approved') Approved_Applications,
 ROUND(100*SUM(Application_Decision='Approved')/NULLIF(COUNT(*),0),2) Approval_Rate_Pct,
 SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure,
 SUM(Expected_Loss) Illustrative_Expected_Loss,
 ROUND(100*SUM(Default_Flag)/NULLIF(SUM(Application_Decision='Approved'),0),2) Late_Or_ChargeOff_Rate_Pct,
 ROUND(AVG(Credit_Score),1) Avg_Credit_Score, ROUND(AVG(DTI_Ratio)*100,2) Avg_DTI_Pct
FROM consumer_loan_applications;
CREATE OR REPLACE VIEW vw_risk_band_performance AS
SELECT Risk_Band, COUNT(*) Applications, SUM(Application_Decision='Approved') Approved_Applications,
 ROUND(AVG(Risk_Probability)*100,2) Avg_Risk_Probability_Pct,
 SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure,
 SUM(Expected_Loss) Expected_Loss, ROUND(100*SUM(Default_Flag)/NULLIF(SUM(Application_Decision='Approved'),0),2) Late_Or_ChargeOff_Rate_Pct
FROM consumer_loan_applications GROUP BY Risk_Band;
CREATE OR REPLACE VIEW vw_monthly_credit_trends AS
SELECT DATE_FORMAT(Application_Date,'%Y-%m') Application_Month, COUNT(*) Applications,
 SUM(Application_Decision='Approved') Approvals,
 ROUND(100*SUM(Application_Decision='Approved')/NULLIF(COUNT(*),0),2) Approval_Rate_Pct,
 SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure,
 SUM(Expected_Loss) Expected_Loss
FROM consumer_loan_applications GROUP BY DATE_FORMAT(Application_Date,'%Y-%m');
CREATE OR REPLACE VIEW vw_state_risk_analysis AS
SELECT State, COUNT(*) Applications, SUM(Application_Decision='Approved') Approvals,
 ROUND(100*SUM(Default_Flag)/NULLIF(SUM(Application_Decision='Approved'),0),2) Late_Or_ChargeOff_Rate_Pct,
 SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure, SUM(Expected_Loss) Expected_Loss
FROM consumer_loan_applications GROUP BY State;
CREATE OR REPLACE VIEW vw_channel_performance AS
SELECT Acquisition_Channel, COUNT(*) Applications, SUM(Application_Decision='Approved') Approvals,
 ROUND(100*SUM(Application_Decision='Approved')/NULLIF(COUNT(*),0),2) Approval_Rate_Pct,
 SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure,
 SUM(Expected_Loss) Expected_Loss, ROUND(AVG(Risk_Probability)*100,2) Avg_Risk_Probability_Pct
FROM consumer_loan_applications GROUP BY Acquisition_Channel;
CREATE OR REPLACE VIEW vw_loan_purpose_risk AS
SELECT Loan_Purpose, COUNT(*) Applications, SUM(Application_Decision='Approved') Approvals,
 ROUND(100*SUM(Default_Flag)/NULLIF(SUM(Application_Decision='Approved'),0),2) Late_Or_ChargeOff_Rate_Pct,
 SUM(CASE WHEN Application_Decision='Approved' THEN Loan_Amount ELSE 0 END) Approved_Exposure,
 SUM(Expected_Loss) Expected_Loss, ROUND(AVG(Interest_Rate_Pct),2) Avg_Interest_Rate_Pct
FROM consumer_loan_applications GROUP BY Loan_Purpose;
