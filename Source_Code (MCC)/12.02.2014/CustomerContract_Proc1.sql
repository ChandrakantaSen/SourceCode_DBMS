USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[CustomerContract_Proc1]    Script Date: 02/12/2014 13:16:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[CustomerContract_Proc1] 
	-- Add the parameters for the stored procedure here
	@cname varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select customer_tbl.customer_name
	      ,customer_tbl.customer_type
	       ,SUM(contract_tbl.amount)
	  from
	       customer_tbl
	      ,contract_tbl
	 where 
	       customer_tbl.customer_id = contract_tbl.customer_id
	   and customer_tbl.customer_name = @cname 
     /*group by
             customer_tbl.customer_name */
     order by
             customer_tbl.customer_name 
END
