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
CREATE FUNCTION dbo.fun1 
(
	@dealer_category nvarchar(10),
	@depot_code nvarchar(3)
)
RETURNS int
AS
BEGIN
	DECLARE @con int;
	select @con=COUNT(dn_dealer_list.dealer_code) from dn_dealer_list 
	group by dn_dealer_list.dealer_category,dn_dealer_list.depot_code 
	having dn_dealer_list.dealer_category=@dealer_category and dn_dealer_list.depot_code=@depot_code
    
    return @con;
END
GO

