SELECT
  DATE(block_time) AS date,
  COUNT(*) AS daily_transactions
FROM polygon.transactions
WHERE
  success = TRUE
  AND block_time BETWEEN TRY_CAST('2025-01-01' AS TIMESTAMP) AND TRY_CAST('2025-06-30' AS TIMESTAMP)
GROUP BY
  DATE(block_time)
ORDER BY
  date;