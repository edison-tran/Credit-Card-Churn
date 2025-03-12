# Credit Card Churn Analysis
**Tools Used: Excel, MS SQL Server, Tableau**

[Dataset Used](https://www.kaggle.com/datasets/sakshigoyal7/credit-card-customers/data)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/CreditCardChurn_17417959876420/Dashboard1)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/CreditCardChurnDashboard2/Dashboard2)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/CreditCardChurnDashboard3/Dashboard3)

## Introduction
In today’s competitive financial services landscape, retaining valuable customers is more critical and challenging than ever.
Credit card companies, in particular, face significant costs in acquiring new customers while managing the risk of attrition
among their existing customer base. This project focuses on analyzing customer churn using a comprehensive dataset from a
leading credit card company. By analysing various customer dimensions, namely, demographic attributes, financial behavior,
and engagement metrics, this allows for key drivers behind customer attrition to be unveiled. The insights derived will help
inform targeted retention strategies and optimize overall customer value.

## Motivation and Objective
Customer churn represents a considerable challenge for credit card companies. However, churn is not driven by a single factor; 
it's connected through variables such as customer age, tenure, income, spending behavior, credit utilization, and product engagement.
Through further inquiring, this project looks to answer these questions that closely relate to customer churn:

Demographic Impact: How do age, gender, and education level influence churn?

Financial Behavior: What is the relationship between spending behavior (e.g., total transaction amount) and churn?

Engagement Metrics: How do customer engagement indicators, such as contact frequency and inactivity duration, relate to attrition?

Product Utilization: Are there differences in churn among various card categories, and how does credit utilization play a role?

Customer Tenure: Does the length of the customer relationship correlate with reduced churn, and how do spending patterns evolve over time?

## Approach
### Data Extraction & Transformation (SQL)
Data Querying:
To start, advanced SQL queries are created in order to aggregate and segment the dataset. This includes:

Grouping customers by age, tenure, income, education level, and card category.
Calculating key metrics such as average transaction amounts, credit limits, credit utilization, and relationship counts.
Utilizing Common Table Expressions (CTEs), subqueries, and window functions (including PERCENT_RANK) to derive deeper insights.

Churn Calculation:
A dedicated calculation converts the Attrition_Flag into a binary indicator, which is then aggregated (using AVG or SUM/COUNT) to derive the churn rate. This churn metric is integrated into multiple queries to understand its relationship with various factors.

### Visualization (Tableau)
Calculated Fields:
In Tableau, we create calculated fields (e.g., “Is Attrited” and “Churn Rate”) that transform our SQL-derived metrics into interactive visual elements.

Dashboard Creation:
A suite of visualizations is designed to answer critical questions such as:

How does churn vary across age groups, income levels, and customer tenure?

What is the relationship between credit limit and marital status with churn?

Which customer segments, defined by demographic and financial variables, contribute most to attrition?


## Results
The analysis revealed several actionable insights:

Demographics: Middle aged customers tend to exhibit a higher churn rate, while customers in certain education and income brackets show a stronger loyalty profile.

Financial Behavior: High-spending customers within lower income categories are less likely to churn, suggesting that premium customers benefit from enhanced engagement strategies.

Engagement Patterns: Customers with above average inactivity and lower contact frequencies are at a higher risk of attrition, indicating that proactive communication could improve retention.

These findings, visualized through interactive dashboards, provide clear, data-driven direction for refining customer retention strategies.

## Conclusion
This project demonstrates how combining SQL data analysis and advanced Tableau visualizations can uncover deep insights into customer churn. By analyzing diverse dimensions,
demographics, financial behavior, product engagement, etc., providing a comprehensive view of the factors that drive customer attrition was successful. The insights derived
from this analysis allow for credit card companies to implement targeted retention strategies, ultimately reducing churn and enhancing overall profitability.

As businesses continue to navigate a competitive landscape, data driven decision making remains essential. This project not only addresses a critical business challenge but
also showcases the power of integrating data extraction and visualization to drive strategic outcomes.
