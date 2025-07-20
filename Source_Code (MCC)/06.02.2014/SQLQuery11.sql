select * from emp
select * from dept
select SUM(salary) "Total_Salary" from emp
select emp.eno, emp.ename,emp.salary,dept.dept
from emp,dept
where emp.eno=dept.eno
update dept 
set dept='marketing'
where eno='03c'