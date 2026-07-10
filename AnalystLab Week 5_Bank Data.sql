SELECT COUNT(*) AS total_rows FROM dbo.bank;

SELECT TOP 10 * 
FROM dbo.bank;

-- Column names and data types
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bank';

-- To assess missing values in the dataset
-- True NULLs across all columns
SELECT 
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_nulls,
    SUM(CASE WHEN job IS NULL THEN 1 ELSE 0 END) AS job_nulls,
    SUM(CASE WHEN balance IS NULL THEN 1 ELSE 0 END) AS balance_nulls,
    SUM(CASE WHEN deposit IS NULL THEN 1 ELSE 0 END) AS deposit_nulls
FROM dbo.bank;

-- "Unknown" values in categorical columns
SELECT
    SUM(CASE WHEN job = 'unknown' THEN 1 ELSE 0 END) AS job_unknown,
    SUM(CASE WHEN education = 'unknown' THEN 1 ELSE 0 END) AS education_unknown,
    SUM(CASE WHEN contact = 'unknown' THEN 1 ELSE 0 END) AS contact_unknown,
    SUM(CASE WHEN poutcome = 'unknown' THEN 1 ELSE 0 END) AS poutcome_unknown
FROM dbo.bank;

-- Numeric Columns. Summary Statistics
SELECT
    AVG(age*1.0) AS avg_age, MIN(age) AS min_age, MAX(age) AS max_age,
    AVG(balance*1.0) AS avg_balance, MIN(balance) AS min_balance, MAX(balance) AS max_balance,
    AVG(duration*1.0) AS avg_duration, MIN(duration) AS min_duration, MAX(duration) AS max_duration,
    AVG(campaign*1.0) AS avg_campaign, MAX(campaign) AS max_campaign
FROM dbo.bank;

-- Standard deviation
SELECT 
    STDEV(age) AS stdev_age,
    STDEV(balance) AS stdev_balance,
    STDEV(duration) AS stdev_duration
FROM dbo.bank;

-- Target variable distribution
SELECT 
    deposit, 
    COUNT(*) AS count_customers,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dbo.bank) AS DECIMAL(5,2)) AS pct
FROM dbo.bank
GROUP BY deposit;


-- Subscription rate by job
SELECT 
    job,
    COUNT(*) AS total,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS subscription_rate_pct
FROM dbo.bank
GROUP BY job
ORDER BY subscription_rate_pct DESC;

-- Subsciption rate by education
SELECT 
    education,
    COUNT(*) AS total,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS subscription_rate_pct
FROM dbo.bank
GROUP BY education
ORDER BY subscription_rate_pct DESC;


--Subscription by marital status
SELECT 
    marital,
    COUNT(*) AS total,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS subscription_rate_pct
FROM dbo.bank
GROUP BY marital
ORDER BY subscription_rate_pct DESC;

--Subscription rate by age group
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS subscription_rate_pct
FROM dbo.bank
GROUP BY 
    CASE 
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END
ORDER BY age_group;

--Subscription rate by previous campaign outcome
SELECT 
    poutcome,
    COUNT(*) AS total,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS subscription_rate_pct
FROM dbo.bank
GROUP BY poutcome
ORDER BY subscription_rate_pct DESC;

--Subscription Rate by contact method
SELECT 
    contact,
    COUNT(*) AS total,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS subscription_rate_pct
FROM dbo.bank
GROUP BY contact
ORDER BY subscription_rate_pct DESC;

--Subscription rate by month
SELECT 
    month,
    COUNT(*) AS total,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS subscription_rate_pct
FROM dbo.bank
GROUP BY month
ORDER BY subscription_rate_pct DESC;

--Effect of number of campaign contacts
SELECT 
    campaign,
    COUNT(*) AS total,
    SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) AS subscribed,
    CAST(SUM(CASE WHEN deposit = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS subscription_rate_pct
FROM dbo.bank
GROUP BY campaign
ORDER BY campaign;

--Average balance of subscribers vs non-subscribers
SELECT 
    deposit,
    AVG(balance*1.0) AS avg_balance,
    AVG(duration*1.0) AS avg_call_duration
FROM dbo.bank
GROUP BY deposit;