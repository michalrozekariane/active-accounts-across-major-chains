WITH first_tx AS (
  SELECT
    signer_address,
    MIN(block_date) AS first_date
  FROM aptos.signatures
  WHERE
    tx_success = TRUE
  GROUP BY
    signer_address
), daily_new_wallets AS (
  SELECT
    first_date AS date,
    COUNT(*) AS new_wallets
  FROM first_tx
  WHERE
    first_date BETWEEN CAST('2025-01-01' AS TIMESTAMP) AND CAST('2025-06-30' AS TIMESTAMP)
  GROUP BY
    first_date
)
SELECT
  date,
  new_wallets
FROM daily_new_wallets
ORDER BY
  date