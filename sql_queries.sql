-- ============================================
-- Customer Shopping Behavior Analysis - SQL Queries
-- ============================================

-- 1. Revenue by Gender
SELECT Gender, ROUND(SUM(`Purchase Amount (USD)`), 2) AS revenue
FROM customer_shopping
GROUP BY Gender;

-- 2. Customers who spent above average AND received a discount
SELECT `Customer ID`, `Purchase Amount (USD)`
FROM customer_shopping
WHERE `Discount Applied` = 'Yes' 
  AND `Purchase Amount (USD)` >= (
      SELECT AVG(`Purchase Amount (USD)`) 
      FROM customer_shopping
  );

-- 3. Top 5 products with highest average review rating
SELECT `Item Purchased`, ROUND(AVG(`Review Rating`), 2) AS avg_rating
FROM customer_shopping
GROUP BY `Item Purchased`
ORDER BY avg_rating DESC
LIMIT 5;

-- 4. Average purchase amount: Standard vs Express shipping
SELECT `Shipping Type`, ROUND(AVG(`Purchase Amount (USD)`), 2) AS avg_purchase_amount
FROM customer_shopping
WHERE `Shipping Type` IN ('Standard', 'Express')
GROUP BY `Shipping Type`;

-- 5. Average spend and total revenue: Subscribers vs Non-subscribers
SELECT `Subscription Status`, 
       COUNT(*) AS total_customers,
       ROUND(AVG(`Purchase Amount (USD)`), 2) AS avg_spend,
       ROUND(SUM(`Purchase Amount (USD)`), 2) AS total_revenue
FROM customer_shopping
GROUP BY `Subscription Status`;

-- 6. Top 5 products with highest percentage of discounted purchases
SELECT `Item Purchased`,
       COUNT(*) AS total_purchases,
       SUM(CASE WHEN `Discount Applied` = 'Yes' THEN 1 ELSE 0 END) AS discounted_purchases,
       ROUND(
           SUM(CASE WHEN `Discount Applied` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
           2
       ) AS discount_percentage
FROM customer_shopping
GROUP BY `Item Purchased`
ORDER BY discount_percentage DESC
LIMIT 5;

-- 7. Customer segmentation: New, Returning, Loyal (based on previous purchase count)
SELECT 
    CASE 
        WHEN `Previous Purchase Count` <= 10 THEN 'New'
        WHEN `Previous Purchase Count` BETWEEN 11 AND 30 THEN 'Returning'
        ELSE 'Loyal'
    END AS customer_segment,
    COUNT(*) AS customer_count
FROM customer_shopping
GROUP BY customer_segment
ORDER BY customer_count DESC;

-- 8. Top 3 most purchased products within each category (window function)
SELECT category, item_purchased, purchase_count, ranking
FROM (
    SELECT 
        `Category` AS category,
        `Item Purchased` AS item_purchased,
        COUNT(*) AS purchase_count,
        RANK() OVER (PARTITION BY `Category` ORDER BY COUNT(*) DESC) AS ranking
    FROM customer_shopping
    GROUP BY `Category`, `Item Purchased`
) AS ranked_products
WHERE ranking <= 3
ORDER BY category, ranking;

-- 9. Subscription rate: Repeat buyers (5+ previous purchases) vs Non-repeat buyers
SELECT 
    CASE 
        WHEN `Previous Purchase Count` > 5 THEN 'Repeat Buyer'
        ELSE 'Non-Repeat Buyer'
    END AS buyer_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN `Subscription Status` = 'Yes' THEN 1 ELSE 0 END) AS subscribed_count,
    ROUND(
        SUM(CASE WHEN `Subscription Status` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS subscription_rate_pct
FROM customer_shopping
GROUP BY buyer_type;

-- 10. Revenue contribution by age group
SELECT 
    CASE 
        WHEN `Age` < 25 THEN 'Young Adult'
        WHEN `Age` BETWEEN 25 AND 40 THEN 'Adult'
        WHEN `Age` BETWEEN 41 AND 55 THEN 'Middle-aged'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS total_customers,
    ROUND(SUM(`Purchase Amount (USD)`), 2) AS total_revenue,
    ROUND(
        SUM(`Purchase Amount (USD)`) * 100.0 / (SELECT SUM(`Purchase Amount (USD)`) FROM customer_shopping), 
        2
    ) AS revenue_contribution_pct
FROM customer_shopping
GROUP BY age_group
ORDER BY total_revenue DESC;
