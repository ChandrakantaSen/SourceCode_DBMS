USE [MiscDb]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[proc1]

SELECT	'Return Value' = @return_value

GO
exec [dbo].[proc1]