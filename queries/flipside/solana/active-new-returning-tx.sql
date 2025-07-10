WITH daily_metrics AS (
  SELECT 
    DATE_TRUNC('day', block_timestamp_hour) AS date,
    SUM(unique_initiator_count) AS daily_active_accounts,
    SUM(transaction_count) AS total_transactions
  FROM crosschain.stats.ez_core_metrics_hourly
  WHERE blockchain = 'solana'
  AND block_timestamp_hour >= '2025-01-01'
  GROUP BY 1
),

new_wallets AS (
  SELECT 
    DATE_TRUNC('day', first_tx_date) AS date,
    COUNT(DISTINCT signer) AS new_wallets
  FROM solana.core.ez_signers
  WHERE first_tx_date >= '2025-01-01'
  GROUP BY 1
)

SELECT 
  d.date,
  d.daily_active_accounts,
  COALESCE(nw.new_wallets, 0) AS new_wallets_per_day,
  d.daily_active_accounts - COALESCE(nw.new_wallets, 0) AS returning_accounts_per_day,
  d.total_transactions / NULLIF(d.daily_active_accounts, 0) AS avg_tx_per_active_account
FROM daily_metrics d
LEFT JOIN new_wallets nw ON d.date = nw.date
ORDER BY date DESC;