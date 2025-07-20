--====================================
--  Create database trigger template 
--====================================
USE bd2
GO

CREATE TRIGGER tgrAfterDelete ON dbo.Employee_Test
	FOR delete 
AS 
	declare @empId int;
	declare @empname varchar(50);
	declare @empsal decimal(10,2);
	declare @empaudit varchar(50);
	
	begin
		select @empId = d.Emp_ID from deleted d;
		select @empname = d.Emp_Name from deleted d;
		select @empsal = d.Emp_Sal from deleted d;
		set @empaudit = 'Deleted -- After Trigger';
		
		insert into bd2.dbo.Employee_Test_Audit values (@empId,@empname,@empsal,@empaudit,GETDATE());
		
		print 'Deleted Trigger are fired now...'
	end	
GO


