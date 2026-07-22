--	Rank all customers based on total charges.

select 
	customerid,
	totalcharges,
	rank() over(order by totalcharges desc) as charge_rnk
	from customer_churn
	order by charge_rnk



--	Rank all customers based on monthly charges.
select 
	customerid,
	monthlycharges,
	rank() over(order by monthlycharges desc) as monthly_rnk
	from customer_churn
	order by monthly_rnk


--Rank all customers based on customer lifetime value.
select 
	customerid,
	customerlifetimevalue,
	rank() over(order by customerlifetimevalue desc) as clv_rnk
	from customer_churn
	order by clv_rnk



--Identify the top 10 highest-paying customers.
select 
	customerid,
	max(totalcharges) as highest_paying_customers
	from customer_churn
	group by customerid
	order by highest_paying_customers desc
	limit 10;

--	Identify the bottom 10 lowest-paying customers.
select 
	customerid,
	min(totalcharges) as highest_paying_customers
	from customer_churn
	group by customerid
	order by highest_paying_customers asc
	limit 10;
	
--Rank customers within each contract type by revenue.
SELECT 
    customerid,
    contract,
    totalcharges AS revenue,
    RANK() OVER (
        PARTITION BY contract 
        ORDER BY totalcharges DESC
    ) AS revenue_rank
FROM customer_churn
ORDER BY contract, revenue_rank;

--Rank customers within each internet service by revenue.
SELECT 
    customerid,
    internetservice,
    totalcharges AS revenue,
    RANK() OVER (
        PARTITION BY internetservice 
        ORDER BY totalcharges DESC
    ) AS revenue_rank
FROM customer_churn
ORDER BY internetservice, revenue_rank;

select * from customer_churn

78.	Rank payment methods based on total revenue generated.
79.	Rank contract types based on churn rate.
80.	Rank internet service types based on churn rate.


--	Calculate the running total of revenue.
select
	customerid,
	totalcharges as revenue,
	sum(totalcharges) over(order by customerid) as runing_total_revenue
	from customer_churn
	order by customerid
	
--Calculate the cumulative number of customers.
select
	customerid,
	count(*) over(order by customerid) as cumulative_customers
	from customer_churn
	order by customerid
	
--	Calculate the moving average of monthly charges.

--	Compare each customer's monthly charge with the previous customer
select 
	customerid,
	monthlycharges,
	lag(monthlycharges) over (order by  customerid) as prev_cust_chrge
	from customer_churn
	order by customerid
.
--	Compare each customer's total charge with the next customer.
select 
	customerid,
	totalcharges,
	lead(totalcharges) over (order by customerid) as next_cust_chrge
	from customer_churn
	order by customerid

--	Identify customers paying more than the average within their contract type.
select 
	contract,
	customerid,
	totalcharges
	from customer_churn
	where totalcharges > (select avg(totalcharges) from customer_churn)
	order by totalcharges desc




87.	Identify customers staying longer than the average tenure within their contract type.
88.	Identify customers paying above the average within their internet service type.
89.	Find customers with the maximum tenure in each contract type.
90.	Find customers with the minimum tenure in each contract type.

--	Create customer segments using CASE statements.
SELECT
    customerid,
    totalcharges,
    CASE
        WHEN totalcharges < 1000 THEN 'Low Value'
        WHEN totalcharges BETWEEN 1000 AND 3000 THEN 'Medium Value'
        ELSE 'High Value'
    END AS customer_segment
FROM customer_churn
ORDER BY totalcharges DESC;

--	Create customer risk categories using CASE statements.


--Create revenue categories using CASE statements.
select 
	customerid,
	totalcharges,
	case 
	 when totalcharges < 1000 then 'bronze'
	 when totalcharges between 1000 and 3000 then 'silver'
	 when totalcharges > 3000 then 	'Gold'
	 else 	'Premium'
	 end as revenue_categories
	 from customer_churn
	 order by totalcharges

94.	Create loyalty categories using CASE statements.
95.	Create profitability categories using CASE statements.

--	Find customers contributing to the top 20% of total revenue.
SELECT
    customerid,
    totalcharges
FROM customer_churn
ORDER BY totalcharges DESC
LIMIT (
    SELECT CEIL(COUNT(*) * 0.20)
    FROM customer_churn
);

--find the customers who together generate the first 80% of total revenue
WITH customer_revenue AS (
    SELECT
        customerid,
        totalcharges,
        SUM(totalcharges) OVER (
            ORDER BY totalcharges DESC
        ) AS cumulative_revenue,
        SUM(totalcharges) OVER () AS total_revenue
    FROM customer_churn
)
SELECT
    customerid,
    totalcharges,
    ROUND(
        (cumulative_revenue * 100.0 / total_revenue)::numeric,
        2
    ) AS cumulative_revenue_percentage
FROM customer_revenue
WHERE cumulative_revenue <= total_revenue * 0.80
ORDER BY totalcharges DESC;

--	Calculate the revenue contribution percentage of each contract type.
SELECT
    contract,
    SUM(totalcharges) AS revenue,
    ROUND(
        (SUM(totalcharges) * 100.0 / SUM(SUM(totalcharges)) OVER ())::numeric,
        2
    ) AS revenue_percentage
FROM customer_churn
GROUP BY contract
ORDER BY revenue_percentage DESC;
98.	Calculate the revenue contribution percentage of each internet service type.
99.	Calculate the revenue contribution percentage of each payment method.
100.	Identify customers contributing the highest revenue within each customer segment
