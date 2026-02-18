--Create table
CREATE TABLE superstore (
    ship_mode VARCHAR(50),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC
);

-- Preview dataset to understand structure and validate data import
SELECT * FROM superstore;

-->First, check discount values
SELECT DISTINCT discount
FROM superstore;

-->Count Orders Per Discount
SELECT 
    discount,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY discount
ORDER BY total_orders DESC;

-->Average Profit Per Discount
SELECT 
    discount,
    ROUND(AVG(profit), 2) AS avg_profit
FROM superstore
GROUP BY discount
ORDER BY avg_profit DESC;


-- Overall Profit Margin
SELECT 
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percent
FROM superstore;



-->Region + Category Analysis, Which categories perform well in each region?
SELECT category,
		region,
		ROUND(SUM(sales),2) as total_sales,
		ROUND(sum(profit),2) as total_profit
FROM superstore
GROUP BY category,region
ORDER BY category, total_profit DESC;

-->Which sub-category is causing Furniture loss in Central?
SELECT category,
		region, sub_category,
				ROUND(sum(profit),2) as total_profit
FROM superstore
GROUP BY category,region,sub_category
HAVING sum(profit) < 0
ORDER BY category, region,total_profit DESC;

-->Top 3 loss-making sub-categories in each region.
SELECT *
FROM (
    SELECT 
        region,
        sub_category,
        ROUND(SUM(profit),2) AS total_profit,
        RANK() OVER (PARTITION BY region ORDER BY SUM(profit)) AS loss_rank
    FROM superstore
    GROUP BY region, sub_category
) ranked_data
WHERE loss_rank <= 3
ORDER BY region, loss_rank;

--> Is discount causing these sub-category losses?
SELECT 
    region,
    sub_category,
    discount,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
WHERE sub_category IN ('Tables','Machines','Furnishings')
GROUP BY region, sub_category, discount
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

-->Top 5 most dangerous discount–subcategory combinations overall.
SELECT 
    sub_category,
    discount,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category, discount
HAVING SUM(profit) < 0
ORDER BY total_profit ASC
LIMIT 5;

-->What % of total company loss is coming from high discounts (>= 0.5)?
SELECT 
    ROUND(SUM(profit),2) AS total_company_profit
FROM superstore;

SELECT 
    ROUND(SUM(profit),2) AS high_discount_profit
FROM superstore
WHERE discount >= 0.5;

SELECT 
    ROUND(SUM(profit),2) AS profit_if_discount_capped_30
FROM superstore
WHERE discount <= 0.3;

SELECT 
    ROUND(SUM(profit),2) AS profit_if_remove_70_plus
FROM superstore
WHERE discount < 0.7;

-->At what discount level does each sub-category start becoming unprofitable?
WITH discount_analysis AS (
    SELECT 
        sub_category,
        discount,
        ROUND(AVG(profit),2) AS avg_profit
    FROM superstore
    GROUP BY sub_category, discount
)
SELECT *
FROM discount_analysis
WHERE avg_profit < 0
ORDER BY sub_category, discount;

--> What if we apply different caps per sub-category?
SELECT 
    ROUND(SUM(
        CASE 
            WHEN sub_category IN ('Tables','Storage','Supplies') 
                 AND discount > 0.1 THEN 0
            WHEN sub_category IN ('Machines','Bookcases','Chairs','Phones') 
                 AND discount > 0.3 THEN 0
            WHEN sub_category = 'Appliances' 
                 AND discount > 0.5 THEN 0
            ELSE profit
        END
    ),2) AS profit_with_smart_caps
FROM superstore;

-- Maximum safe discount per sub-category (where avg_profit > 0)
WITH profit_check AS (
    SELECT 
        sub_category,
        discount,
        ROUND(AVG(profit),2) AS avg_profit
    FROM superstore
    GROUP BY sub_category, discount
)
SELECT 
    sub_category,
    MAX(discount) AS max_safe_discount
FROM profit_check
WHERE avg_profit > 0
GROUP BY sub_category
ORDER BY sub_category;

--> Now simulate profit using these calculated safe caps dynamically instead of hardcoding.
WITH profit_check AS (
    SELECT 
        sub_category,
        discount,
        AVG(profit) AS avg_profit
    FROM superstore
    GROUP BY sub_category, discount
),
safe_caps AS (
    SELECT 
        sub_category,
        MAX(discount) AS max_safe_discount
    FROM profit_check
    WHERE avg_profit > 0
    GROUP BY sub_category
)
SELECT 
    ROUND(SUM(
        CASE 
            WHEN s.discount <= sc.max_safe_discount THEN s.profit
            ELSE 0
        END
    ),2) AS optimized_profit
FROM superstore s
JOIN safe_caps sc
ON s.sub_category = sc.sub_category;


-- Executive Summary Metrics
SELECT 
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_percent,
    COUNT(*) AS total_orders
FROM superstore;



























