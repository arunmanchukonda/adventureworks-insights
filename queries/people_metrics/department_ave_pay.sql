WITH CurrentDepartments AS (
    SELECT 
        BusinessEntityID, 
        DepartmentID
    FROM humanresources_employeedepartmenthistory
    WHERE EndDate IS NULL
),
LatestPayRates AS (
    SELECT 
        eph.BusinessEntityID,
        eph.Rate,
        eph.RateChangeDate
    FROM humanresources_employeepayhistory eph
    INNER JOIN (
        SELECT 
            BusinessEntityID, 
            MAX(RateChangeDate) AS LatestChange
        FROM humanresources_employeepayhistory
        GROUP BY BusinessEntityID
    ) latest ON eph.BusinessEntityID = latest.BusinessEntityID 
             AND eph.RateChangeDate = latest.LatestChange
)
SELECT 
    d.Name AS Department,
    AVG(lpr.Rate) AS DepartmentAverageRate
FROM LatestPayRates lpr
JOIN CurrentDepartments cd 
    ON lpr.BusinessEntityID = cd.BusinessEntityID
JOIN humanresources_department d 
    ON cd.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY DepartmentAverageRate DESC;