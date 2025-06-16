WITH PayHistory AS (
    SELECT 
        eph.BusinessEntityID,
        eph.RateChangeDate,
        eph.Rate,
        d.Name AS Department
    FROM humanresources_employeepayhistory eph
    JOIN humanresources_employeedepartmenthistory edh 
        ON eph.BusinessEntityID = edh.BusinessEntityID
           AND eph.RateChangeDate BETWEEN edh.StartDate AND IFNULL(edh.EndDate, CURDATE())
    JOIN humanresources_department d 
        ON edh.DepartmentID = d.DepartmentID
)
SELECT 
    ph.BusinessEntityID,
    ph.Department,
    ph.RateChangeDate,
    ph.Rate
FROM PayHistory ph
ORDER BY ph.BusinessEntityID, ph.RateChangeDate;