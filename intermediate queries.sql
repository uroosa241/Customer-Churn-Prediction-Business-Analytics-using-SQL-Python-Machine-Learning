--What is the churn rate for each contract type?

SELECT 
    contract,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY contract
ORDER BY churn_rate DESC;
	



select * from customer_churn

--What is the churn rate by gender?

SELECT 
    gender,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
    ROUND(
        COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY gender
ORDER BY churn_rate DESC;



--	What is the churn rate by senior citizen status?

select 
	seniorcitizen,
	count(*) as total_customers,
	Round(
	count(*) filter (where churn = 'Yes') * 100 / count(*),2) as churn_rate
	from customer_churn
	group by seniorcitizen
	order by churn_rate desc
	)
--	What is the churn rate by payment method?


alter table customer_churn
rename column "PaymentMethod" to paymentmethod
select 
	paymentmethod,
	count(*) as total_customers,
	Round(
	count(*) filter (where churn = 'Yes') * 100 / count(*),2
	) as churn_rate
from customer_churn
group by paymentmethod
order by churn_rate desc

35.	What is the churn rate by internet service type?
36.	What is the churn rate by phone service?
37.	What is the churn rate by multiple lines?
38.	What is the churn rate by online security?
39.	What is the churn rate by online backup?
40.	What is the churn rate by device protection?
41.	What is the churn rate by tech support?
42.	What is the churn rate by streaming TV?
43.	What is the churn rate by streaming movies?
44.	Which contract type has the highest churn rate?
45.	Which payment method has the highest churn rate?
46.	Which internet service has the highest churn rate?

--	Which gender generates the highest revenue?
select 
	gender,
	max(totalcharges) as highest_revenue
	from customer_churn
	group by gender
	



48.	Which contract type generates the highest revenue?
49.	Which payment method generates the highest revenue?
50.	Which internet service generates the highest revenue?

--	What is the average monthly charge by contract type?
select 
	contract,
	avg(monthlycharges) as avg_monthly_charges
	from customer_churn
	group by contract
	order by avg_monthly_charges desc


52.	What is the average monthly charge by internet service?
53.	What is the average monthly charge for churned and non-churned customers?
54.	What is the average tenure by contract type?
55.	What is the average tenure for churned customers?
56.	What is the average tenure for retained customers?

--	Which customers have monthly charges above the overall average?
SELECT 
    customerid,
    monthlycharges
FROM customer_churn
WHERE monthlycharges > (
    SELECT AVG(monthlycharges)
    FROM customer_churn
)
ORDER BY monthlycharges DESC;

--	Which customers have total charges above the overall average?
select 
	customerid,
	totalcharges
	from customer_churn
	where totalcharges > (
select avg(monthlycharges) from customer_churn)
order by monthlycharges desc
	)


59.	Which customers have tenure above the overall average?

--	Which customers have the highest lifetime value?

select * from customer_churn

alter table customer_churn
rename column "CustomerLifetimeValue" to customerlifetimevalue

select 
	customerid,
	max(customerlifetimevalue) as customerlifetimevalue
	from customer_churn
	group by customerid
	
61.	Which customers have the highest service count?
62.	Which customers are classified as high-risk customers?
63.	Which tenure group has the highest churn rate?
64.	Which charge group has the highest churn rate?
65.	Which service count group has the highest churn rate?
66.	Which customer segment contributes the most revenue?
67.	Which customer segment contributes the least revenue?
68.	Which payment method has the lowest churn rate?
69.	Which contract type retains customers the longest?


select * from customer_churn

--	Which internet service has the highest average monthly charges?

select 
	internetservice,
	avg(monthlycharges) as avg_monthlycharges
	from customer_churn
	group by internetservice
	order by avg_monthlycharges desc

________________________________________
