/*****************************************************************************/
-- Q1: What are the top 5 brands by receipts scanned among users 21 and over?

-- Assumptions:
--- "Receipts scanned" = count of unique receipt IDs
--- Age is calculated accurately from BIRTH_DATE
--- RANK() is used to reflect true ranking order and include all ties without inflating position counts

-- CTE for calulating total number of receipts scanned among users 21 and over for each brand
WITH Receipt_CNT_BY_Brand AS(
	SELECT 
	  P.brand,
	  COUNT(DISTINCT T.receipt_id) AS cnt
	FROM transactions T
	LEFT JOIN users U 
	ON U.id = t.user_id
	LEFT JOIN products P ON P.barcode = T.barcode
	WHERE 
	  U.birth_date IS NOT NULL AND
	  (
	    (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date)) -
	    CASE 
	      WHEN EXTRACT(MONTH FROM CURRENT_DATE) < EXTRACT(MONTH FROM birth_date) 
	           OR (EXTRACT(MONTH FROM CURRENT_DATE) = EXTRACT(MONTH FROM birth_date) 
	               AND EXTRACT(DAY FROM CURRENT_DATE) < EXTRACT(DAY FROM birth_date)) 
	      THEN 1 ELSE 0 
	    END
	  ) >= 21
	GROUP BY P.brand
	ORDER BY cnt DESC)
SELECT * FROM
	(SELECT *,
		 RANK() OVER(ORDER BY CNT DESC) AS RNK
	   FROM Receipt_CNT_BY_Brand)
WHERE RNK <= 5;

/* Findings and Conclusions:
 * The top scanned brand for users aged 21+ was "Unknown" (58 receipts), highlighting significant gaps in barcode-to-product mapping.
 * Identifiable brands with highest engagement were Dove and Nerds Candy (3 receipts each).
 * Several popular brands (Sour Patch Kids, Great Value, Meijer, Coca-Cola, Trident, Hershey’s)- 
 * - had moderate and equal engagement (2 receipts each).*/
