WITH DateSeries AS (
    SELECT
        GETDATE() AS check_date,
        0 AS iteration,
        CAST(DATEPART(MILLISECOND, SYSDATETIME()) AS INT) * 
        CAST(DATEPART(SECOND, SYSDATETIME()) AS INT) AS seed
    UNION ALL
    SELECT
        DATEADD(day, 
                2 + ABS(CHECKSUM(CAST(check_date AS VARCHAR) + CAST(iteration AS VARCHAR) + CAST(seed AS VARCHAR))) % 6,
                check_date), 
        iteration + 1,
        seed
    FROM
        DateSeries
    WHERE
        iteration < 100
)
SELECT
    check_date,
	seed
FROM
    DateSeries
OPTION (MAXRECURSION 0);

