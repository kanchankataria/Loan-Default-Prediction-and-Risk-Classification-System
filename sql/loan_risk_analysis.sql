SELECT COUNT(*) FROM business_loans;

-- ============================================================
-- QUERY 1: Overall Default Rate
-- ============================================================
SELECT
    COUNT(*)                                AS total_loans,
    SUM(defaulted)                          AS total_defaults,
    ROUND(AVG(defaulted::NUMERIC)*100, 2)  AS default_rate_pct,
    ROUND(SUM(NULLIF(grosschargeoffamount,0)::NUMERIC), 2) 
                                            AS total_loss_amount,
    ROUND(AVG(NULLIF(grosschargeoffamount,0)::NUMERIC), 2) 
                                            AS avg_loss_per_default
FROM business_loans;

-- ============================================================
-- QUERY 2: Default Rate by Industry (Top 15)
-- ============================================================
SELECT
    naicsdescription                     AS industry,
    COUNT(*)                             AS total_loans,
    SUM(defaulted)                       AS total_defaults,
    ROUND(AVG(defaulted::NUMERIC)*100,2) AS default_rate_pct,
    ROUND(AVG(grossapproval),0)          AS avg_loan_amount
FROM business_loans
GROUP BY naicsdescription
HAVING COUNT(*) >= 100
ORDER BY default_rate_pct DESC
LIMIT 15;

-- ============================================================
-- QUERY 3: Default Rate by State (Top 10)
-- ============================================================
SELECT
    borrstate                            AS state,
    COUNT(*)                             AS total_loans,
    SUM(defaulted)                       AS total_defaults,
    ROUND(AVG(defaulted::NUMERIC)*100,2) AS default_rate_pct,
    ROUND(SUM(grossapproval),0)          AS total_exposure
FROM business_loans
GROUP BY borrstate
ORDER BY default_rate_pct DESC
LIMIT 10;

-- ============================================================
-- QUERY 4: Risk Category Summary
-- ============================================================

SELECT
    risk_category,
    COUNT(*)                                AS total_loans,
    SUM(defaulted)                          AS total_defaults,
    ROUND(AVG(defaulted::NUMERIC)*100, 2)  AS default_rate_pct,
    ROUND(AVG(grossapproval)::NUMERIC, 0)  AS avg_loan_amount,
    ROUND(AVG(recommended_rate::NUMERIC),2) AS avg_recommended_rate,
    decision
FROM business_loans
GROUP BY risk_category, decision
ORDER BY default_rate_pct DESC;

-- ============================================================
-- QUERY 5: Yearly Default Trend
-- ============================================================
SELECT
    approvalfy                           AS year,
    COUNT(*)                             AS total_loans,
    SUM(defaulted)                       AS total_defaults,
    ROUND(AVG(defaulted::NUMERIC)*100,2) AS default_rate_pct,
    ROUND(SUM(grossapproval),0)          AS total_loan_volume
FROM business_loans
WHERE approvalfy >= 2000
GROUP BY approvalfy
ORDER BY default_rate_pct DESC;

-- ============================================================
-- QUERY 6: Bank Risk Analysis (Top 10)
-- ============================================================
SELECT
    bankname,
    COUNT(*)                             AS total_loans,
    SUM(defaulted)                       AS total_defaults,
    ROUND(AVG(defaulted::NUMERIC)*100,2) AS default_rate_pct,
    ROUND(AVG(grossapproval),0)          AS avg_loan_amount
FROM business_loans
GROUP BY bankname
HAVING COUNT(*) >= 100
ORDER BY default_rate_pct DESC
LIMIT 10;

-- ============================================================
-- QUERY 7: Business Age vs Default
-- ============================================================
SELECT
    businessage,
    COUNT(*)                             AS total_loans,
    SUM(defaulted)                       AS total_defaults,
    ROUND(AVG(defaulted::NUMERIC)*100,2) AS default_rate_pct
FROM business_loans
GROUP BY businessage
ORDER BY default_rate_pct DESC;

-- ============================================================
-- QUERY 8: Loan Size Buckets
-- ============================================================
SELECT
    CASE
        WHEN grossapproval < 50000   THEN '1. Under $50K'
        WHEN grossapproval < 150000  THEN '2. $50K-$150K'
        WHEN grossapproval < 350000  THEN '3. $150K-$350K'
        WHEN grossapproval < 750000  THEN '4. $350K-$750K'
        ELSE                              '5. Over $750K'
    END                                  AS loan_size_bucket,
    COUNT(*)                             AS total_loans,
    SUM(defaulted)                       AS total_defaults,
    ROUND(AVG(defaulted::NUMERIC)*100,2) AS default_rate_pct,
    ROUND(AVG(grossapproval),0)          AS avg_loan_amount
FROM business_loans
GROUP BY loan_size_bucket
ORDER BY loan_size_bucket;

-- ============================================================
-- QUERY 9: Securitization Pool Assessment
-- ============================================================
SELECT
    CASE
        WHEN risk_category = 'Low Risk'
            THEN 'AAA - Investment Grade'
        WHEN risk_category = 'Medium Risk'
            THEN 'BBB - Substandard'
        ELSE    'CCC - High Risk'
    END                                  AS pool_grade,
    COUNT(*)                             AS loan_count,
    ROUND(COUNT(*)*100.0/SUM(COUNT(*))
          OVER(),1)                      AS pct_of_pool,
    ROUND(AVG(grossapproval),0)          AS avg_loan_size,
    ROUND(AVG(defaulted::NUMERIC)*100,2) AS default_rate_pct
FROM business_loans
GROUP BY pool_grade
ORDER BY pool_grade;

-- ============================================================
-- QUERY 10: Interest Rate Recommendation Summary
-- ============================================================

SELECT
    risk_category,
    decision,
    COUNT(*)                                        AS total_loans,
    ROUND(MIN(recommended_rate::NUMERIC), 2)        AS min_rate,
    ROUND(AVG(recommended_rate::NUMERIC), 2)        AS avg_rate,
    ROUND(MAX(recommended_rate::NUMERIC), 2)        AS max_rate,
    ROUND(AVG(defaulted::NUMERIC)*100, 2)           AS actual_default_rate
FROM business_loans
GROUP BY risk_category, decision
ORDER BY avg_rate;
