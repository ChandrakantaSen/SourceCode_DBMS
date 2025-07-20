insert into leave values ('01a',200.00,80.00)
select * from leave
insert into leave values ('03c',0.00,0.00)
delete from leave where esi=0.00 
select * from emp
create procedure countempno (x in number) is
begin
  count(x);
end;
begin
	countempno(select eno from emp);
end;