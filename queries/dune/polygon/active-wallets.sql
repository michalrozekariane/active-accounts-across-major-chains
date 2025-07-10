SELECT
  TRY_CAST(block_time AS DATE) AS date,
  COUNT(DISTINCT "from") AS active_wallets
FROM polygon.transactions
WHERE
  success = TRUE
  AND block_time BETWEEN TRY_CAST('2025-01-01' AS DATE) AND TRY_CAST('2025-06-30' AS DATE)
GROUP BY
  TRY_CAST(block_time AS DATE)
ORDER BY
  date;