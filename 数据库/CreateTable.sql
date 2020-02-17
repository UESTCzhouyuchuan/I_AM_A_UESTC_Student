CREATE TABLE Department (
	DepartmentCode char(3) NOT NULL,
	DepartmentName varchar(30) NOT NULL,
	DepartmentIntro varchar(200) NULL,
	DepartmentAddr varchar(50) NULL,
	DepartmentTel varchar(20) NULL,
	CONSTRAINT Department_PK PRIMARY KEY (DepartmentCode)
);
CREATE TABLE Employee (
	EmployeeID serial NOT NULL,
	EmployeeName varchar(10) NOT NULL,
	Gender char(2) NOT NULL DEFAULT '男',
	Department char(3) NOT NULL,
	Degree char(6) NULL CHECK (Degree IN ('本科','研究生','其他')),
	BirthDay date NULL,
	Phone char(11) NULL,
	Email varchar(20) NOT NULL UNIQUE,
	CONSTRAINT Employee_PK PRIMARY KEY (EmployeeID),
	CONSTRAINT EMP_DEPART_FK FOREIGN KEY (Department)
	REFERENCES Department (DepartmentCode)
	ON UPDATE CASCADE
);
CREATE TABLE Project (
	ProjectID serial NOT NULL,
	ProjectName varchar(50) NOT NULL,
	Department char(3) NOT NULL,
	EstimateHours int NOT NULL,
	StartDate date NULL,
	EndDate date NULL,
	CONSTRAINT Project_PK PRIMARY KEY (ProjectID),
	CONSTRAINT PROJ_DEPART_FK FOREIGN KEY (Department)
	REFERENCES Department (DepartmentCode)
	ON UPDATE CASCADE
);
CREATE TABLE Assignment (
	ProjectID int NOT NULL,
	EmployeeID int NOT NULL,
	FishedHours int NOT NULL,
	Cost int NOT NULL,
	CONSTRAINT Assignment_PK PRIMARY KEY (ProjectID, EmployeeID),
	CONSTRAINT ASSIGN_PROJ_FK FOREIGN KEY (ProjectID)
	REFERENCES Project (ProjectID)
	ON UPDATE NO ACTION
	ON DELETE CASCADE,
	CONSTRAINT ASSIGN_EMP_FK FOREIGN KEY (EmployeeID)
	REFERENCES Employee (EmployeeID)
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
);