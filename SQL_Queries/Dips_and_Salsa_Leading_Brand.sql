/****************************************************************/
-- Q3: Which is the leading brand in the Dips & Salsa category?
-- Assumptions:
--- "Leading brand" = brand with the highest total quantity purchased (FINAL_QUANTITY).
--- Tiebreakers: if there's a tie in quantity, rank by number of distinct receipts scanned, then number of distinct customers 
--- who purchased the item.

SELECT 
  P.brand,
  COUNT(DISTINCT T.receipt_id) AS receipt_cnt,
  COUNT(DISTINCT T.user_id) AS cust_cnt,
  SUM(t.final_quantity) AS qt
FROM products P
LEFT JOIN transactions T
ON P.barcode = T.barcode
WHERE P.category_2 = 'Dips & Salsa'
GROUP BY P.brand
ORDER BY qt DESC, receipt_cnt DESC, cust_cnt DESC
LIMIT 1;

/* Conclusion: TOSTITOS is the leading brand in the Dips & Salsa category.
 * Total Quantity Purchased: 76 units
 * Receipt Count: 36
 * Unique Customers: 35
 * These figures clearly place TOSTITOS at the top, outperforming all other brands in both volume and breadth of engagement.*/