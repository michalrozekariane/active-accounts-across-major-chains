WITH first_tx AS (
  SELECT
    "from" AS wallet_address,
    MIN(TRY_CAST(block_time AS DATE)) AS first_seen_date
  FROM base.transactions
  WHERE success = TRUE
  GROUP BY "from"
)
SELECT
  first_seen_date AS date,
  COUNT(*) AS new_wallets
FROM first_tx
WHERE first_seen_date BETWEEN TRY_CAST('2025-01-01' AS DATE) AND TRY_CAST('2025-06-30' AS DATE)
GROUP BY first_seen_date
ORDER BY first_seen_date;