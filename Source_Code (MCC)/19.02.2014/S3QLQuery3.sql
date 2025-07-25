USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[proc2]    Script Date: 02/19/2014 14:33:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[proc2] 
		
AS
	declare @var varchar(6)
	declare @dealer_child_code nvarchar(6)
	declare @dealer_code nvarchar(6)
    delete from MiscDb.dbo.a;
    
    declare c1 cursor for
			select distinct(dealer_code), dbo.fun_cursor(dealer_code) as "dealer_child_code"
			from dn_dealer_link 
			where dealer_code not in (dealer_child_code)
			
	 open c1				
	 fetch next from c1 into @dealer_code, @dealer_child_code
	 				
	 while @@FETCH_STATUS = 0
	 begin
		
		insert into MiscDb.dbo.a values(@dealer_code, dbo.fun_cursor(@dealer_code))
		
		fetch next from c1 into @dealer_code, @dealer_child_code
	 end
	
	close c1
	deallocate c1		
GO	