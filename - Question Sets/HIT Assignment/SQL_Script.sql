select * from emp
SELECT empno, ename,deptno FROM emp WHERE job = 'CLERK'						
SELECT empno, ename,sal FROM emp WHERE job = 'MANAGER'						
SELECT empno, ename,hiredate FROM emp WHERE job = 'ANALYST'						
SELECT ename FROM emp WHERE sal BETWEEN 2000 AND 3000
SELECT ename FROM emp WHERE sal < 1000						
SELECT ename FROM emp WHERE sal > 4000						
SELECT ename FROM emp WHERE sal = 800 or sal = 1600 or sal = 2450						
SELECT ename,job FROM emp WHERE job = 'CLERK' or job = 'SALESMAN' OR job = 'ANALYST'				
SELECT ename FROM EMP WHERE comm IS NULL						
SELECT ename FROM EMP WHERE comm IS NOT NULL						
SELECT ename FROM EMP WHERE ename LIKE 'F%'						
SELECT ENAME,JOB FROM EMP where LENGTH (Trim(ENAME))=5
SELECT ename FROM EMP WHERE ename LIKE 'G%'						
SELECT ename FROM EMP WHERE ename LIKE '%N'
SELECT ENAME,JOB FROM EMP where LENGTH (Trim(ENAME))=5 and ENAME LIKE '%S'						
select ename, job, hiredate from emp where hiredate between to_date('01-01-1981', 'DD-MM-RR') AND to_date('31-12-1981', 'DD-MM-RR')
SELECT ename FROM EMP WHERE ename NOT LIKE 'CL%'						
