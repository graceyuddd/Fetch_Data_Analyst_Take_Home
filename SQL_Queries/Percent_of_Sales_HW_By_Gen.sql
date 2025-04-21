/****************************************************************/
-- Q2: What is the percentage of sales in the Health & Wellness category by generation?

-- Assumptions:
--- Interpreting this as: “Of all Health & Wellness sales, what share did each generation contribute?”
--- Generations are derived from BIRTH_DATE based on standard definitions.
--- A sale is counted if CATEGORY_1 = 'Health & Wellness'.
--- Final_sale is treated as unit price; Sales = final_sale × final_quantity.
--- NULL final_sale is treated as 0.

SELECT
	  CASE
	    WHEN birth_date IS NULL THEN 'Unknown'
	    WHEN birth_date BETWEEN DATE '1928-01-01' AND DATE '1945-12-31' THEN 'Silent Generation'
	    WHEN birth_date BETWEEN DATE '1946-01-01' AND DATE '1964-12-31' THEN 'Baby Boomer'
	    WHEN birth_date BETWEEN DATE '1965-01-01' AND DATE '1980-12-31' THEN 'Gen X'
	    WHEN birth_date BETWEEN DATE '1981-01-01' AND DATE '1996-12-31' THEN 'Millennial'
	    WHEN birth_date BETWEEN DATE '1997-01-01' AND DATE '2012-12-31' THEN 'Gen Z'
	    WHEN birth_date >= DATE '2013-01-01' THEN 'Gen Alpha'
	    ELSE 'Other'
	    END AS generation
	  , SUM(final_quantity) tot_quantity
	  , SUM(final_sale*final_quantity) tot_sale
	  , count(DISTINCT receipt_id) receipt_cnt
	  , COUNT(DISTINCT user_id) AS user_count
	  , ROUND(SUM(final_sale * final_quantity) * 100.0 / SUM(SUM(final_sale * final_quantity)) OVER (), 2) AS pct_of_total_hw_sales
	FROM transactions T
	LEFT JOIN users U 
	ON U.id = t.user_id
	LEFT JOIN products P ON P.barcode = T.barcode
	WHERE P.category_1='Health & Wellness'
	GROUP BY generation
	ORDER BY pct_of_total_hw_sales DESC;

/* Conclusion
 * The analysis revealed a major data gap affecting our generational insights. 
 * Specifically, out of over 3,000 customers who made purchases in the Health & Wellness category,
 * only 17 customers could be accurately matched to demographic data in the User table.
 * As a result, approximately 99.5% of the Health & Wellness sales are attributed to customers whose demographic details are unknown. 
 * This significantly limits our ability to perform accurate generational analysis or 
 * draw reliable conclusions about purchasing behavior across generations.
 * Among the limited known data, Baby Boomers (0.2%) show slightly higher purchasing activity, 
 * followed by Millennials (0.14%) and then Gen X (0.13%), but given the tiny sample size (17 users), this insight has minimal reliability.
 */
