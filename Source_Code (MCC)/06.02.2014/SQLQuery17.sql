USE [bd2]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[rowcount1]
		@dept = N'slaes'

SELECT	'Return Value' = @return_value

GO
