WITH LatestPayChange AS (
    SELECT 
        BusinessEntityID,
        MAX(RateChangeDate) AS LastPayChangeDate
    FROM humanresources_employeepayhistory
    GROUP BY BusinessEntityID
),
CurrentDepartment AS (
    SELECT 
        edh.BusinessEntityID,
        d.Name AS Department
    FROM humanresources_employeedepartmenthistory edh
    JOIN humanresources_department d 
        ON edh.DepartmentID = d.DepartmentID
    WHERE edh.EndDate IS NULL
)
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    e.HireDate,
    lpc.LastPayChangeDate,
    cd.Department
FROM LatestPayChange lpc
JOIN humanresources_employee e 
    ON e.BusinessEntityID = lpc.BusinessEntityID
LEFT JOIN CurrentDepartment cd 
    ON e.BusinessEntityID = cd.BusinessEntityID
WHERE lpc.LastPayChangeDate < DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY lpc.LastPayChangeDate;