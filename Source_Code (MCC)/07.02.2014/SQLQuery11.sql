USE [bd2]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[getstudents]
		@Student_Id = N'0acit'

SELECT	'Return Value' = @return_value

GO
