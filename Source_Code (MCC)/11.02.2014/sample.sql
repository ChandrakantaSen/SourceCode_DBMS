declare 
	  @val varchar (5),
      @i int, @j int
set @val = '* '
set @i = 1
set @j = (@i) 
while(@i <= 5)
begin
 while (@j>=@i)
	begin
		print @val
	set @j= @j-1
	end
	print @val
set @i = @i + 1
end ;

DECLARE 
	@num INT,
	@num1 INT, 
	@space INT, 
	@str varchar(50)
SET @num = 1
WHILE(@num<=10)
BEGIN
    SET @num1 = 0 
    SET @space = 10-@num
    WHILE (@num1<@num)
    BEGIN
        if @str is null
            SET @str = '* '
        ELSE
            SET @str = @str+'* '   
            SET @num1 = @num1+1
    END
    PRINT (space(@space)+@str)
    SET @num = @num+1   
    SET @str = null
END
