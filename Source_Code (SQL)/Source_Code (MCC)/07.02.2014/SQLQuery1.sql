select * from emp
insert into emp values ('05d', 'amjad','12-26-1980', 9520.75)
alter table emp add deptno numeric(08)
update emp set deptno=105
where eno='05d'
select * from leave
drop table leave
select * from dept
alter table dept add deptno numeric(08)
select * from dept
update dept set deptno=33
where dname='marketing'
sp_RENAME 'dept.dept','dname','COLUMN'
insert into dept values ('06g', 'tester',11)
/*UPDATE emp , dept
SET emp.eno = '09x',dept.deptno = '111'
FROM emp e1, dept d1
WHERE e1.eno = d1.eno
and e1.eno = '03c'*/
insert into emp values ('06g', 'sattar','09-15-2004', 7750.00,111)
select * from emp
select eno,deptname
from emp,dept
where eno='03c'
select salary from emp where salary not in (select e1.salary from emp e1, emp e2 where e1.salary>e2.salary)
SELECT ename, dname, salary
FROM emp, dept
WHERE emp.eno = dept.eno
select eno,salary
from emp
where salary>2000
select * from sys.triggers
select
   CONSTRAINT_NAME 
from 
   INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE 
where 
   TABLE_NAME = 'emp' 
  and  COLUMN_NAME = 'salary'
