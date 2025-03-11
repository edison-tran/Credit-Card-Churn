--Calcualting The Churn Rate Per Age Group
SELECT 
    CASE WHEN Customer_Age BETWEEN 26 AND 41 THEN '26-41'
	WHEN Customer_Age BETWEEN 42 AND 57 THEN '42-57'
	WHEN Customer_Age BETWEEN 58 AND 74 THEN '58-74'
    END AS Age_Group,
    AVG(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1.0 ELSE 0.0 END) AS Churn_Rate
FROM [dbo].[BankChurners$]
GROUP BY 
    CASE WHEN Customer_Age BETWEEN 26 AND 41 THEN '26-41'
	WHEN Customer_Age BETWEEN 42 AND 57 THEN '42-57'
	WHEN Customer_Age BETWEEN 58 AND 74 THEN '58-74'
    END
ORDER BY Age_Group

-- Determining Churn Rate Based on Tenure
WITH TenureGroups AS (
    SELECT 
        CLIENTNUM,
        Attrition_Flag,
        Total_Trans_Amt,
        CASE 
            WHEN Months_on_book <= 12 THEN '0-12 months'
            WHEN Months_on_book <= 24 THEN '13-24 months'
            WHEN Months_on_book <= 36 THEN '25-36 months'
            WHEN Months_on_book <= 48 THEN '37-48 months'
            ELSE '48+ months'
        END AS Tenure_Group
    FROM [dbo].[BankChurners$]
)
SELECT 
    Tenure_Group,
	ROUND(CAST(AVG(Total_Trans_Amt) AS FLOAT), 2) AS Avg_Trans_Amt,
    CAST(AVG(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1.0 ELSE 0.0 END) AS FLOAT) AS Churn_Rate
FROM TenureGroups
GROUP BY Tenure_Group
ORDER BY Tenure_Group

-- Churn Rate Among 10% of Spenders By Education Level
SELECT 
    Education_Level,
	ROUND(AVG(Credit_Limit), 2) AS Credit_Limit,
    CAST(
        AVG(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1.0 ELSE 0.0 END) 
    AS FLOAT) AS Churn_Rate_Top_10_Percent
FROM (
    SELECT 
        CLIENTNUM,
        Education_Level,
		Credit_Limit,
        Attrition_Flag,
        PERCENT_RANK() OVER (PARTITION BY Education_Level ORDER BY Total_Trans_Amt DESC) AS spend_percentile
    FROM [dbo].[BankChurners$]
) AS sub
WHERE spend_percentile <= 0.1
GROUP BY Education_Level
HAVING COUNT(*) > 0

-- Exploring Activity Levels Grouped By Income In Terms of Spending And Utilization
WITH IncomeAvg AS (
    SELECT 
        Income_Category, 
        AVG(Months_Inactive_12_mon) AS Avg_Inactivity
    FROM [dbo].[BankChurners$]
    GROUP BY Income_Category
)
SELECT 
    c.Income_Category,
    CASE 
        WHEN c.Months_Inactive_12_mon > ia.Avg_Inactivity THEN 'Above Average Inactivity'
        ELSE 'Below Average Inactivity'
    END AS Inactivity_Group,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(c.Total_Trans_Amt), 2) AS Avg_Trans_Amt,
    ROUND(AVG(c.Avg_Utilization_Ratio), 2) AS Avg_Utilization
FROM [dbo].[BankChurners$] c
JOIN IncomeAvg ia 
    ON c.Income_Category = ia.Income_Category
GROUP BY 
    c.Income_Category,
    CASE 
        WHEN c.Months_Inactive_12_mon > ia.Avg_Inactivity THEN 'Above Average Inactivity'
        ELSE 'Below Average Inactivity'
    END
ORDER BY c.Income_Category, Inactivity_Group

--Determine Transaction Behaviours Among Card Categories
WITH CardAvg AS (
    SELECT 
        Card_Category, 
        AVG(Total_Trans_Amt) AS Avg_Trans_Amt
    FROM [dbo].[BankChurners$]
    GROUP BY Card_Category
)
SELECT 
    c.Card_Category,
    CASE 
        WHEN c.Total_Trans_Amt >= ca.Avg_Trans_Amt THEN 'High Spender'
        ELSE 'Low Spender'
    END AS Spending_Group,
    COUNT(*) AS Customer_Count,
    SUM(CASE WHEN c.Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Closed_Accounts,
    ROUND(AVG(c.Total_Trans_Amt), 2) AS Avg_Trans_Amt
FROM [dbo].[BankChurners$] c
JOIN CardAvg ca 
    ON c.Card_Category = ca.Card_Category
GROUP BY 
    c.Card_Category,
    CASE 
        WHEN c.Total_Trans_Amt >= ca.Avg_Trans_Amt THEN 'High Spender'
        ELSE 'Low Spender'
    END
ORDER BY c.Card_Category, Spending_Group

-- Analysis of Age Groups In Terms of Spending and Relationships
WITH AgeGroups AS (
  SELECT 
      Attrition_Flag,
      Customer_Age,
      Total_Trans_Amt,
      Total_Relationship_Count,
      CASE 
          WHEN Customer_Age < 30 THEN 'Under 30'
          WHEN Customer_Age BETWEEN 30 AND 50 THEN '30-50'
          ELSE 'Over 50'
      END AS Age_Group
  FROM [dbo].[BankChurners$]
)
SELECT 
    Age_Group,
    Attrition_Flag,
    ROUND(AVG(Total_Trans_Amt), 2) AS Avg_Transaction_Amount,
    ROUND(AVG(Total_Relationship_Count), 2) AS Avg_Relationship_Count,
    COUNT(*) AS Customer_Count
FROM AgeGroups
GROUP BY Age_Group, Attrition_Flag
ORDER BY Age_Group, Attrition_Flag

-- Analysing Average Credit Limit Per Gender
WITH GenderCreditAvg AS (
    SELECT 
        Gender,
        AVG(Credit_Limit) AS Avg_Credit_Limit
    FROM [dbo].[BankChurners$]
    GROUP BY Gender
)
SELECT
    c.Gender,
    CASE 
        WHEN c.Credit_Limit > gca.Avg_Credit_Limit THEN 'Above Average Credit Limit'
        ELSE 'Below Average Credit Limit'
    END AS Credit_Group,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(c.Total_Trans_Amt), 2) AS Avg_Trans_Amt,
    ROUND(AVG(c.Avg_Utilization_Ratio), 2) AS Avg_Utilization
FROM [dbo].[BankChurners$] c
JOIN GenderCreditAvg gca 
    ON c.Gender = gca.Gender
GROUP BY 
    c.Gender,
    CASE 
        WHEN c.Credit_Limit > gca.Avg_Credit_Limit THEN 'Above Average Credit Limit'
        ELSE 'Below Average Credit Limit'
    END
ORDER BY c.Gender, Credit_Group

