/***** Department �����ݲ���***********************/
INSERT INTO Department VALUES('A01', '������Դ',NULL, 'A ��-100', '8535-6102');
INSERT INTO Department VALUES('A02','���ɲ�', NULL, 'A ��-108', '8535-6108');
INSERT INTO Department VALUES('A03','��Ʋ�', NULL, 'A ��-201', '8535-6112');
INSERT INTO Department VALUES('A04','����', NULL, 'A ��-205', '8535-6123');
INSERT INTO Department VALUES('A05','������', NULL, 'A ��-301', '8535-6138');
INSERT INTO Department VALUES('A06','������', NULL, 'B ��-101', '8535-6152');
INSERT INTO Department VALUES('A07','�г���', NULL, 'B ��-201', '8535-6158');
INSERT INTO Department VALUES('A08','IT ��', NULL, 'C ��-101', '8535-6162');
/***** Employee �����ݲ���*************************/
INSERT INTO Employee(employeename,gender,department,degree,birthday,phone,email)
VALUES(
'����', '��','A07', '����', '1985-12-10','139********','PZ@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'��־', '��','A02', '�о���', '1973-06-23','139********','ZZ@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'����', 'Ů','A03', '����', '1976-02-17','139********','LH@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'����', '��','A04', '����', '1989-11-13','139********','LY@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'����', 'Ů','A05', '����', '1987-05-19','139********','LM@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'�쾲', 'Ů','A08', '����', '1978-08-30','139********','ZJ@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'л��', '��','A03', '�о���', '1990-02-11','139********','XJ@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'����', '��','A06', '����', '1982-09-23','139********','DC@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'�ϸ�', '��','A07','����', '1988-11-18','139********','YG@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'��ʢ', '��','A06','����', '1975-06-09','139********','YS@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'����', '��','A01', '����', '1968-07-30','139********','WL@ABC.com');
INSERT INTO Employee (employeename,gender,department,degree,birthday,phone,
email) VALUES(
'����', 'Ů','A04', '����', '1965-11-19','139********','WR@ABC.com');
/***** Project �����ݲ���******************************/
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'�²�Ʒ�Ƽ�', 'A07',220, '2014-03-12', '2014-05-08');
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'�� 2 ���Ⱦ�Ӫ����', 'A04',150, '2014-06-05', '2014-07-10' );
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'�������ֵ˰�ϱ�', 'A03', 80, '2014-02-12', '2014-03-01');
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'��Ʒ�г�����', 'A07', 135, '2014-03-20', '2014-05-15');
INSERT INTO Project (projectname,department,estimatehours,startdate,enddate)
VALUES(
'��Ʒ���Ͳ���', 'A06', 185, '2014-05-12', '2014-07-15');
/***** Assignment �����ݲ���**************************/
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




