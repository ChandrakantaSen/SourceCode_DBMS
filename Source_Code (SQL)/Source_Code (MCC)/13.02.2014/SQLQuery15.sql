select * from emp;
select * from dept;

select 
	 bd2.dbo.emp.empno,
	 bd2.dbo.emp.ename,
	 bd2.dbo.dept.dname,
	 SUM(bd2.dbo.emp.sal) as "Total",
	ceiling((bd2.dbo.emp.sal*isnull(bd2.dbo.emp.comm,1)),2) as "calculate"
from 
	 bd2.dbo.emp
    ,bd2.dbo.dept
where
     bd2.dbo.emp.dept = bd2.dbo.dept.deptno
group by 
        bd2.dbo.emp.empno,
        bd2.dbo.emp.ename,
        bd2.dbo.dept.dname,
        bd2.dbo.emp.sal,
        bd2.dbo.emp.comm