SELECT
  DATE(block_time) AS date,
  COUNT(DISTINCT signer_address) AS active_wallets
FROM aptos.signatures
WHERE
  tx_success = TRUE
  AND block_time BETWEEN TRY_CAST('2025-01-01' AS TIMESTAMP) AND TRY_CAST('2025-06-30' AS TIMESTAMP)
GROUP BY
  DATE(block_time)
ORDER BY
  date