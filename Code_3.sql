declare
	n number(3):= 1;
	s number(4):= 0;
begin
	while n <= 100
	loop
		s := s + n;
		n := n + 1;
	end loop;
	dbms_output.put_line('the sum is '||s);
end;
/