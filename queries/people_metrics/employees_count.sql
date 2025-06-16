select count(e.LoginID) as EmployeeID, d.Name as Department 
from humanresources_employeedepartmenthistory as h

join humanresources_employee as e on e.BusinessEntityID = h.BusinessEntityID
join humanresources_department as d on d.DepartmentID = h.DepartmentID
where h.EndDate is null 


group by d.name