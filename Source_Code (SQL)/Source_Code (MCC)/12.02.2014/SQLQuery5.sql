USE [bd2]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[InsertStudentrecord]
		@StudentFirstName = N'Promit',
		@StudentLastName = N'Dutta',
		@StudentEmail = N'promit9903@abc.com'

SELECT	'Return Value' = @return_value

GO
select * from tbl_Students