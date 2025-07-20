DECLARE @fName varchar(50)
       ,@lName varchar(50)
 
DECLARE cursorName CURSOR -- Declare cursor
LOCAL SCROLL STATIC
FOR
	Select firstName, lastName 
	FROM tbl_Students
OPEN cursorName -- open the cursor
FETCH NEXT FROM cursorName 
   INTO @fName, @lName
   PRINT @fName + ' ' + @lName -- print the name
WHILE @@FETCH_STATUS = 0 
BEGIN
   FETCH NEXT FROM cursorName
   INTO @fName, @lName
   PRINT @fName + ' ' + @lName -- print the name
END
CLOSE cursorName -- close the cursor
DEALLOCATE cursorName -- Deallocate the cursor