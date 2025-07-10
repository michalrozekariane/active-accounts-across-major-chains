WITH first_seen_wallets AS (
  SELECT
    sender_address,
    MIN(DATE_TRUNC('day', block_time)) AS first_seen_date
  FROM starknet.transactions
  WHERE
    finality_status = 'ACCEPTED_ON_L2'
  GROUP BY
    sender_address
)
SELECT
  first_seen_date AS date,
  COUNT(*) AS new_wallets
FROM first_seen_wallets
WHERE
  first_seen_date BETWEEN DATE(TRY_CAST('2025-01-01' AS TIMESTAMP)) AND DATE(TRY_CAST('2025-06-27' AS TIMESTAMP))
GROUP BY
  1
ORDER BY
  date