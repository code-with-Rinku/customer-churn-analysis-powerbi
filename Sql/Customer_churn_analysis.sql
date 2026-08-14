use db_churn 
select * from churn_data;

--Churn Rate by Gender
SELECT 
    Gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    CONVERT(
        DECIMAL(5,2),
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
    ) AS Churn_Rate
FROM churn_data
GROUP BY Gender;

--Which payment method has the highest churn rate?

select PaymentMethod,count(PaymentMethod)as count_PaymentMethod,cast(round(sum(Case when Churn='Yes' then 1 else 0 end)*100.0/count(*),2) as decimal(5,2))as churn_rate
from churn_data
group by PaymentMethod ;

--Total revenue contributed by churned and non-churned customer

select Churn,count(Churn) as customer_count ,
round(sum(TotalCharges)*100.0/(select sum(TotalCharges) from churn_data),2) as total_revenue from churn_data
group by Churn;
--Are senior citizens more likely to leave than younger customers?
select SeniorCitizen,count(*) as count_coustomer,
sum(case when Churn='Yes' then 1 else 0 end) as churn_customer,
concat(round(sum(case when Churn='Yes' then 1 else 0 end)*100.0/count(*),2),'%') as churn_rate
from churn_data
group by SeniorCitizen;
--Which contract type has the highest churn rate?
select Contract,
cast(round(sum(Case when Churn='Yes' then 1 else 0 end)*100.0/count(*),2) as decimal(5,2)) as churn_rate
from churn_data
group by Contract;
---- What percentage of customers belong to each contract type?
select contract,count (contract) as contract_count,
round(count(contract)*100.0/(select count(* )from churn_data),2) as percentage
from churn_data
group by Contract;
--churn rate based on customer type
select 
Case
when tenure <=12 then 'New customer'
when tenure <=24 then 'medium term customer'
else 'Long term customer'
end as customer_type,
count(*) as total_customer,
sum(case when Churn='Yes' then 1 else 0 end )*100.0/count(*) as churn_rate
from churn_data
group by Case
when tenure <=12 then 'New customer'
when tenure <=24 then 'medium term customer'
else 'Long term customer'
 end;
 --"Does providing technical support reduce churn?"
SELECT
   TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn_data
GROUP BY TechSupport;
-- Compare average monthly charges between churned and non-churned customers for each internet service.
select InternetService,Churn,
avg(MonthlyCharges) as avg_month_charge
from churn_data
group by InternetService,Churn
order by InternetService,Churn;
--Among churned customers, which internet service is most common?

SELECT InternetService,
COUNT(*) AS churned_customers
FROM churn_data
WHERE Churn = 'Yes'
GROUP BY InternetService
ORDER BY churned_customers DESC;
--. Find the top 5 customers who paid the highest total charges.
select top 5 customerID,
TotalCharges
from churn_data
order by TotalCharges desc;

