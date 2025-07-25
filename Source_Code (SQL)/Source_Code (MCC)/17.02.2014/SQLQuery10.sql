USE [MiscDb]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_link_codes]    Script Date: 02/17/2014 15:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[fn_link_codes] 
(
  @dealer_code nvarchar(5)
)
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @link_codes AS NVARCHAR(100);
    SET @link_codes = '';
	Select @link_codes += dealer_child_code + ','
      From dn_dealer_link
	 Where dealer_code = @dealer_code
	   
    If @link_codes Is Null Set @link_codes = '';
    
	RETURN @link_codes;
END
