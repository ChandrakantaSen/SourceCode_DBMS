USE [MiscDb]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[prRow]

SELECT	'Return Value' = @return_value

GO

exec prRow
