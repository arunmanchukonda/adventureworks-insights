SELECT 
    YEAR(e.HireDate) AS HireYear,
    COUNT(*) AS NewHires,
    d.Name as Department
FROM humanresources_employee as e
join humanresources_employeedepartmenthistory as edh on edh.BusinessEntityID = e.BusinessEntityID
join humanresources_department as d on edh.DepartmentID = d.DepartmentID
GROUP BY Department, YEAR(HireDate)
ORDER BY HireYear;