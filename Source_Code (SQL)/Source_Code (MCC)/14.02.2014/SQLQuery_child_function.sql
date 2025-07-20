-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION conn
(
	@dealer_code nvarchar (6)
)
RETURNS varchar (50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @NameList VarChar(MAX) =  ''		
	select @NameList = 
		   coalesce (case when @NameList = '' then dealer_child_code
						  else @NameList + ', ' + dealer_child_code
					end,'')
   from dn_dealer_link
   	where dealer_code in (@dealer_code)
	-- Return the result of the function
	RETURN @NameList 

END
GO

