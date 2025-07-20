declare
	n number(3):= 0;
begin
	while n <= 100
	loop
		n := n + 2;
		dbms_output.put_line(n);
	end loop;
end;
/