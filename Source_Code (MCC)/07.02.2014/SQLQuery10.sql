USE [bd2]
GO
/****** Object:  Trigger [dbo].[tgrAfterDelete]    Script Date: 02/07/2014 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[tgrAfterDelete] ON [dbo].[Employee_Test]
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
		set @empaudit = 'Deleted -- After Delete Trigger';
		
		insert into bd2.dbo.Employee_Test_Audit values (@empId,@empname,@empsal,@empaudit,GETDATE());
		
		print 'Deleted Trigger are fired now...'
	end	
