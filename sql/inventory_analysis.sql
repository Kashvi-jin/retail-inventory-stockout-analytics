-- Retail Inventory & Stockout Intelligence
-- SQL Analysis

USE retail_inventory;


-- 1. Product replenishment gap
-- Identifies products where total units sold exceed total units ordered.

SELECT
    `Product ID`,
    SUM(`Units Sold`) AS total_sold,
    SUM(`Units Ordered`) AS total_ordered,
    SUM(`Units Sold`) - SUM(`Units Ordered`) AS order_gap
FROM inventory
GROUP BY `Product ID`
ORDER BY order_gap DESC
LIMIT 10;


-- 2. Replenishment gap as a percentage of sales
-- Normalizes the gap to compare products fairly.

SELECT
    `Product ID`,
    SUM(`Units Sold`) AS total_sold,
    SUM(`Units Ordered`) AS total_ordered,
    SUM(`Units Sold`) - SUM(`Units Ordered`) AS order_gap,
    ROUND(
        (SUM(`Units Sold`) - SUM(`Units Ordered`))
        * 100.0 / SUM(`Units Sold`),
        2
    ) AS gap_pct_of_sales
FROM inventory
GROUP BY `Product ID`
ORDER BY gap_pct_of_sales DESC
LIMIT 10;


-- 3. Monthly sales and replenishment trend
-- Shows how demand and ordering change over time.

SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Date`, '%Y-%m-%d'),
        '%Y-%m'
    ) AS month,
    SUM(`Units Sold`) AS total_units_sold,
    SUM(`Units Ordered`) AS total_units_ordered
FROM inventory
GROUP BY month
ORDER BY month;


-- 4. Top 3 products within each category
-- Uses a CTE and window function to rank products by demand.

WITH product_sales AS (
    SELECT
        Category,
        `Product ID`,
        SUM(`Units Sold`) AS total_units_sold
    FROM inventory
    GROUP BY Category, `Product ID`
),
ranked_products AS (
    SELECT
        Category,
        `Product ID`,
        total_units_sold,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY total_units_sold DESC
        ) AS product_rank
    FROM product_sales
)
SELECT
    Category,
    `Product ID`,
    total_units_sold,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY Category, product_rank;