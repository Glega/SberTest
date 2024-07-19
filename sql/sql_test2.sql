WITH sales_data AS (
    SELECT 
        e.id AS employee_id,
        e.name,
        COUNT(s.id) AS sales_c,
        SUM(s.price) AS sales_s
    FROM 
        employee e
    LEFT JOIN 
        sales s ON e.id = s.employee_id
    GROUP BY 
        e.id, e.name
),
ranked_sales AS (
    SELECT 
        employee_id,
        name,
        sales_c,
        RANK() OVER (ORDER BY sales_c DESC) AS sales_rank_c,
        sales_s,
        RANK() OVER (ORDER BY sales_s DESC) AS sales_rank_s
    FROM 
        sales_data 
)
SELECT 
    employee_id AS id,
    name,
    sales_c,
    sales_rank_c,
    sales_s,
    sales_rank_s
FROM 
    ranked_sales
ORDER BY 
    sales_rank_c, sales_rank_s;