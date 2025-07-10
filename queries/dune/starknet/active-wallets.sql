SELECT
  DATE_TRUNC('day', block_time) AS date,
  COUNT(DISTINCT sender_address) AS total_active_wallets
FROM starknet.transactions
WHERE
  finality_status = 'ACCEPTED_ON_L2'
  AND DATE_TRUNC('day', block_time) BETWEEN DATE(CAST('2025-01-01' AS TIMESTAMP)) AND DATE(CAST('2025-06-27' AS TIMESTAMP))
GROUP BY
  1
ORDER BY
  date