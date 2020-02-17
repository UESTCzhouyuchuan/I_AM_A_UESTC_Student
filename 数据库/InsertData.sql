/***** Department 表数据插入***********************/
INSERT INTO Department VALUES('A01', '人力资源',NULL, 'A 区-100', '8535-6102');
INSERT INTO Department VALUES('A02','法律部', NULL, 'A 区-108', '8535-6108');
INSERT INTO Department VALUES('A03','会计部', NULL, 'A 区-201', '8535-6112');
INSERT INTO Department VALUES('A04','财务部', NULL, 'A 区-205', '8535-6123');
INSERT INTO Department VALUES('A05','行政部', NULL, 'A 区-301', '8535-6138');
INSERT INTO Department VALUES('A06','生产部', NULL, 'B 区-101', '8535-6152');
INSERT INTO Department VALUES('A07','市场部', NULL, 'B 区-201', '8535-6158');
INSERT INTO Department VALUES('A08','IT 部', NULL, 'C 区-101', '8535-6162');
/***** Employee 表数据插入*************************/
INSERT INTO Employee(employeename,gender,department,degree,birthday,phone,email)
VALUES(
'潘振', '男','A07', '本科', '1985-12-10','139********','PZ@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'张志', '男','A02', '研究生', '1973-06-23','139********','ZZ@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'刘鸿', '女','A03', '本科', '1976-02-17','139********','LH@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'廖宇', '男','A04', '本科', '1989-11-13','139********','LY@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'刘梦', '女','A05', '其他', '1987-05-19','139********','LM@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'朱静', '女','A08', '本科', '1978-08-30','139********','ZJ@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'谢剑', '男','A03', '研究生', '1990-02-11','139********','XJ@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'丁成', '男','A06', '本科', '1982-09-23','139********','DC@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'严刚', '男','A07','本科', '1988-11-18','139********','YG@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'杨盛', '男','A06','本科', '1975-06-09','139********','YS@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'王伦', '男','A01', '本科', '1968-07-30','139********','WL@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'汪润', '女','A04', '本科', '1965-11-19','139********','WR@ABC.com');
/***** Project 表数据插入******************************/
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'新产品推荐', 'A07',220, '2014-03-12', '2014-05-08');
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'第 2 季度经营分析', 'A04',150, '2014-06-05', '2014-07-10' );
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'上年度增值税上报', 'A03', 80, '2014-02-12', '2014-03-01');
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'产品市场分析', 'A07', 135, '2014-03-20', '2014-05-15');
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'产品定型测试', 'A06', 185, '2014-05-12', '2014-07-15');
/***** Assignment 表数据插入**************************/
INSERT INTO Assignment VALUES(15,50, 50,50);
INSERT INTO Assignment VALUES(15,52, 100,50);
INSERT INTO Assignment VALUES(16,53, 60,50);
INSERT INTO Assignment VALUES(16,55, 80,50);
INSERT INTO Assignment VALUES(17,56 ,45,50);
INSERT INTO Assignment VALUES(17,57, 75,50);
INSERT INTO Assignment VALUES(18,58, 55,60);
INSERT INTO Assignment VALUES(18,59, 70,60);
INSERT INTO Assignment VALUES(19,50, 70,60);
INSERT INTO Assignment VALUES(19,60, 30,60);
/****************************************************************************/




