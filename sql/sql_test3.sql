WITH BalanceHistory AS (
    SELECT [from] AS acc, tdate, -amount AS balance_change
    FROM transfers
    UNION ALL
    SELECT [to] AS acc, tdate, amount AS balance_change
    FROM transfers
), CumulativeBalance AS (
    SELECT
        acc,
        tdate,
        SUM(balance_change) OVER (PARTITION BY acc ORDER BY tdate, balance_change) AS balance
    FROM
        BalanceHistory
), PartitionedBalance AS (
    SELECT
        acc,
        tdate,
        balance,
        LAG(balance) OVER (PARTITION BY acc ORDER BY tdate, balance) AS prev_balance,
        LEAD(tdate) OVER (PARTITION BY acc ORDER BY tdate, balance) AS next_tdate
    FROM
        CumulativeBalance
), FinalBalancePeriods AS (
    SELECT
        acc,
        tdate AS dt_from,
        COALESCE(next_tdate, '3000-01-01') AS dt_to,
        balance
    FROM
        PartitionedBalance
    WHERE
        prev_balance IS DISTINCT FROM balance OR prev_balance IS NULL
)
SELECT
    acc,
    dt_from,
    dt_to,
    balance
FROM
    FinalBalancePeriods
ORDER BY
    acc, dt_from;