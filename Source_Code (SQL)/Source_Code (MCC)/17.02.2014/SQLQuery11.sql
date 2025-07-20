SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION cr7 
(
	-- Add the parameters for the function here
	@dealer_code nvarchar(6)
)
RETURNS nvarchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @var AS NVARCHAR(100)
	set @var = ''

	-- Add the T-SQL statements to compute the return value here
	SELECT @var = @var + dealer_child_code + ', '
    from dn_dealer_link
    where dealer_code = @dealer_code
	-- Return the result of the function
	RETURN @var
END
GO

