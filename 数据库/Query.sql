SELECT ProjectName AS 项目名称, EmployeeName AS 员工姓名,
FishedHours AS 实际工时
FROM Employee AS E, Project AS P, Assignment AS A
WHERE E.EmployeeID =A.EmployeeID AND P.ProjectID=A.ProjectID
ORDER BY P.ProjectID, A.EmployeeID;

SELECT E.EmployeeID AS 员工编号, EmployeeName AS 员工姓名,
SUM(FishedHours) AS 完成总工时
FROM Employee AS E, Assignment AS A
WHERE E.EmployeeID =A.EmployeeID
GROUP BY E.EmployeeID, EmployeeName
ORDER BY E.EmployeeID;

SELECT ProjectName AS 项目名称, (EstimateHours * Cost) AS 预计成本,
SUM(FishedHours *Cost) AS 实际成本
FROM Project, Assignment
WHERE Project.ProjectID=Assignment.ProjectID
GROUP BY ProjectName, EstimateHours, Cost;

CREATE VIEW ContactView AS
SELECT EmployeeID AS 员工编号, EmployeeName AS 员工姓名, Phone AS 电话,
Email AS 邮箱
FROM Employee;
SELECT *
FROM ContactView
ORDER BY 员工编号;

SELECT ProjectName AS 项目名称, EstimateHours AS 预期工时,
SUM(FishedHours ) AS 实际工时
FROM Project AS P, Assignment AS A
WHERE P.ProjectID=A.ProjectID AND SUM(FishedHours ) > EstimateHours
GROUP BY ProjectName;

CREATE VIEW ProjectFishedHours AS
SELECT ProjectName AS 项目名称, EstimateHours AS 预期工时,
SUM(FishedHours ) AS 实际工时
FROM Project AS P, Assignment AS A
WHERE P.ProjectID=A.ProjectID
GROUP BY ProjectName,EstimateHours;
SELECT *
FROM ProjectFishedHours
WHERE 实际工时 > 预期工时
ORDER BY 项目名称;

