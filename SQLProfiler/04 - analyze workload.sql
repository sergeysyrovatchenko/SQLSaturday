SELECT RowNumber
     , PlanCost = IIF(ExecutionPlan IS NULL, NULL, ExecutionPlan.value('sum(//*:StmtSimple/@StatementSubTreeCost)', 'DECIMAL(36,5)'))
     , EventClass = e.[name]
     , TextData
     , ApplicationName
     , CPU
     , Reads
     , Writes
     , DurationMS = CAST(Duration / 1000. AS DECIMAL(36,3))
     , [Rows] = RowCounts
     , StartTime
     , EndTime
     , SPID
     , NTUserName
     , LoginName
     , ExecutionPlan
FROM (
    SELECT *, ExecutionPlan = IIF(
                    LAG(EventClass) OVER (ORDER BY RowNumber) = 122,
                    CAST(LAG(TextData) OVER (ORDER BY RowNumber) AS XML),
                    NULL
                )
    FROM tempdb.dbo.xxx
) t
LEFT JOIN sys.trace_events e ON e.trace_event_id = t.EventClass
WHERE EventClass != 122
ORDER BY RowNumber

------------------------------------------------------

SELECT TextData
     , Duration = CAST(Duration / 1000000. AS DECIMAL(16,4))
     , CPU = CAST(CPU / 1000. AS DECIMAL(16,4))
     , Reads
     , RowCounts
FROM tempdb.dbo.xxx
WHERE Duration IS NOT NULL
ORDER BY Duration DESC
--ORDER BY Reads DESC

SELECT Query = SUBSTRING(TextData, 0, 25)
     , Executions = COUNT_BIG(*)
     , Duration = CAST(SUM(Duration) / 1000000. AS DECIMAL(16,4))
     , CPU = CAST(SUM(CPU) / 1000. AS DECIMAL(16,4))
     , Reads = SUM(Reads)
FROM tempdb.dbo.xxx
WHERE Duration IS NOT NULL
GROUP BY SUBSTRING(TextData, 0, 25)
ORDER BY SUM(Duration) DESC
--ORDER BY SUM(Reads) DESC
--ORDER BY COUNT_BIG(*) DESC

------------------------------------------------------

SELECT 'Before'
     , Executions = COUNT_BIG(*)
     , Duration = CAST(SUM(Duration) / 1000000. AS DECIMAL(16,4))
     , CPU = CAST(SUM(CPU) / 1000. AS DECIMAL(16,4))
     , Reads = SUM(Reads)
FROM tempdb.dbo.xxx

UNION ALL

SELECT 'After'
     , Executions = COUNT_BIG(*)
     , Duration = CAST(SUM(Duration) / 1000000. AS DECIMAL(16,4))
     , CPU = CAST(SUM(CPU) / 1000. AS DECIMAL(16,4))
     , Reads = SUM(Reads)
FROM tempdb.dbo.xxx2