-- Create Table "emp"
create table emp(
	empno int not null
	,ename varchar(50) not null
	,job varchar(50) not null
	,mgr int
	,hiredate date
	,sal decimal(10,2)
	,comm decimal(10,2)
	,deptno int not null
);

-- Create Table "dept"
create table dept(
	deptno int not null
	,dname varchar(50) not null
	,location varchar(50) not null
);

-- Create Table "salgrade"
create table salgrade(
	grade int not null
	,losal decimal(10,2)
	,hisal decimal(10,2)
);

-- Create Table "bonus"
create table bonus(
	ename varchar(10)
	,job varchar(9)
	,sal decimal(7,2)
	,comm decimal(7,2)
);	

-- Insert values into "emp"
insert into emp values (7369,'SMITH' ,'CLERK'    ,7902,DATE('1990-12-12'),800,0.00,20);								
insert into emp values (7499,'ALLEN' ,'SALESMAN' ,7698,DATE('1998-08-15','yyyy-mm-dd'),1600,300,30);								
insert into emp values (7521,'WARD'  ,'SALESMAN' ,7698,DATE('1996-03-26','yyyy-mm-dd'),1250,500,30);								
insert into emp values (7566,'JONES' ,'MANAGER'  ,7839,DATE('1995-10-31','yyyy-mm-dd'),2975,null,20);								
insert into emp values (7698,'BLAKE' ,'MANAGER'  ,7839,DATE('1992-06-11','yyyy-mm-dd'),2850,null,30);								
insert into emp values (7782,'CLARK' ,'MANAGER'  ,7839,DATE('1993-05-14','yyyy-mm-dd'),2450,null,10);								
insert into emp values (7788,'SCOTT' ,'ANALYST'  ,7566,DATE('1996-03-05','yyyy-mm-dd'),3000,null,20);								
insert into emp values (7839,'KING'  ,'PRESIDENT',null,DATE('1990-06-09','yyyy-mm-dd'),5000,0,10);								
insert into emp values (7844,'TURNER','SALESMAN' ,7698,DATE('1995-06-04','yyyy-mm-dd'),1500,0,30);								
insert into emp values (7876,'ADAMS' ,'CLERK'    ,7788,DATE('1999-06-04','yyyy-mm-dd'),1100,null,20);								
insert into emp values (7900,'JAMES' ,'CLERK'    ,7698,DATE('2000-06-23','yyyy-mm-dd'),950,null,30);								
insert into emp values (7934,'MILLER','CLERK'    ,7782,DATE('2000-01-21','yyyy-mm-dd'),1300,null,10);								
insert into emp values (7902,'FORD'  ,'ANALYST'  ,7566,DATE('1997-12-05','yyyy-mm-dd'),3000,null,20);								
insert into emp values (7654,'MARTIN','SALESMAN' ,7698,DATE('1998-12-05','yyyy-mm-dd'),1250,1400,30);								

						
						
						

						
						
						

						
						
						
						

