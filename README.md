**Zomato Gold Data Exploration Using SQL**
This project explores user behavior and sales trends using SQL on a simulated Zomato-style dataset containing user signups, sales transactions, product details, and Gold membership enrollments. The analysis answers 12 business questions to uncover spending patterns, product popularity, user loyalty, and membership value.

**Key Features & Insights:**
Joined multiple normalized tables (sales, product, users, goldusers_signup) to derive meaningful insights.

Used advanced SQL window functions such as RANK(), ROW_NUMBER() for time-based analysis and ranking customer behavior.

Identified first/last purchases, repeat behavior, and spend timelines in relation to membership.

Implemented subqueries and CTEs for layered logic in answering complex business scenarios.

Core Questions Answered:
Total amount spent by each customer.

Number of unique dates visited by each customer.

First product purchased by every customer.

Most frequently purchased item across all users.

Favorite item for each customer.

First purchase after becoming a Gold member.

Last purchase before becoming a Gold member.

Total spend before becoming a Gold member.

[Question skipped – no Q9 in provided code.]

Zomato points earned in the first year of Gold membership.

Ranking of transactions by customer.

Ranking only during Gold membership and marking others as 'NA'.

## Key Focus Areas
- Customer segmentation based on order frequency and value
- Popular cuisine and restaurant performance
- Revenue and order trends over time
- Top customers and order size analysis

## Techniques Used
- SELECT, WHERE, GROUP BY, HAVING
- INNER JOIN, LEFT JOIN
- CTE's
- Subqueries
- Aggregation (SUM, AVG, COUNT)

## Tools
- MySQL
- SQL IDE (my sql workbench)
