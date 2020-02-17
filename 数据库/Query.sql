SELECT ProjectName AS ��Ŀ����, EmployeeName AS Ա������,
FishedHours AS ʵ�ʹ�ʱ
FROM Employee AS E, Project AS P, Assignment AS A
WHERE E.EmployeeID =A.EmployeeID AND P.ProjectID=A.ProjectID
ORDER BY P.ProjectID, A.EmployeeID;

SELECT E.EmployeeID AS Ա�����, EmployeeName AS Ա������,
SUM(FishedHours) AS ����ܹ�ʱ
FROM Employee AS E, Assignment AS A
WHERE E.EmployeeID =A.EmployeeID
GROUP BY E.EmployeeID, EmployeeName
ORDER BY E.EmployeeID;

SELECT ProjectName AS ��Ŀ����, (EstimateHours * Cost) AS Ԥ�Ƴɱ�,
SUM(FishedHours *Cost) AS ʵ�ʳɱ�
FROM Project, Assignment
WHERE Project.ProjectID=Assignment.ProjectID
GROUP BY ProjectName, EstimateHours, Cost;

CREATE VIEW ContactView AS
SELECT EmployeeID AS Ա�����, EmployeeName AS Ա������, Phone AS �绰,
Email AS ����
FROM Employee;
SELECT *
FROM ContactView
ORDER BY Ա�����;

SELECT ProjectName AS ��Ŀ����, EstimateHours AS Ԥ�ڹ�ʱ,
SUM(FishedHours ) AS ʵ�ʹ�ʱ
FROM Project AS P, Assignment AS A
WHERE P.ProjectID=A.ProjectID AND SUM(FishedHours ) > EstimateHours
GROUP BY ProjectName;

CREATE VIEW ProjectFishedHours AS
SELECT ProjectName AS ��Ŀ����, EstimateHours AS Ԥ�ڹ�ʱ,
SUM(FishedHours ) AS ʵ�ʹ�ʱ
FROM Project AS P, Assignment AS A
WHERE P.ProjectID=A.ProjectID
GROUP BY ProjectName,EstimateHours;
SELECT *
FROM ProjectFishedHours
WHERE ʵ�ʹ�ʱ > Ԥ�ڹ�ʱ
ORDER BY ��Ŀ����;

