USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[prRow]    Script Date: 02/15/2014 14:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[prRow]
	-- Add the parameters for the stored procedure here
	@dealer_code nvarchar(6)
AS
    	
    declare @depot_code varchar(100)
    declare @dealer_child_code varchar(100)
    declare @var varchar(100)
    declare c1 cursor for
    select depot_code,
           dealer_code,
           dealer_child_code from dn_dealer_link
    open c1
    fetch next from c1 into @depot_code, @dealer_code, @dealer_child_code
 
    while @@FETCH_STATUS = 0
    begin
        set @var =	ISNULL(@var,'') +        
                    ISNULL(@dealer_child_code + ', ','')
 
        fetch next from c1 into @depot_code, @dealer_code, @dealer_child_code
    end
    select depot_code, 
           dealer_code,
           @var as dealer_child_code
           from dn_dealer_link
           
close c1
deallocate c1

  --,LEN(@var)-1
  --Left(@var,LEN(@var)-1)
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  