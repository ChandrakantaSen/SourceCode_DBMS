
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE pc1
(
	-- Add the parameters for the stored procedure here
	  @dealer_code varchar(100)
)
AS
    declare @depot_code varchar(100)
    declare @dealer_code1 varchar(100)
    declare @dealer_child_code varchar(100)   
    declare @var varchar(100)
    declare c1 cursor for
    select depot_code,
           dealer_code,
           dealer_child_code from dn_dealer_link
		   where dealer_code in (@dealer_code)   
    open c1
    fetch next from c1 into @depot_code, @dealer_code1, @dealer_child_code
    while @@FETCH_STATUS = 0
    begin
        set @var =	ISNULL(@var,'') +        
                    ISNULL(@dealer_child_code + ', ','')
        fetch next from c1 into @depot_code, @dealer_code1, @dealer_child_code
    end
    select depot_code, 
           @dealer_code1,
           @var as dealer_child_code
           from dn_dealer_link
close c1
deallocate c1
GO
