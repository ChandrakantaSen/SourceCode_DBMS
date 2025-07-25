USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[Cursor_Example]    Script Date: 02/15/2014 13:25:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Cursor_Example]
AS
    DECLARE @Currency varchar(Max)
    DECLARE @Consolidated_Currency varchar(Max)
    DECLARE Cur_Cursor CURSOR FOR
    SELECT Currency FROM tbl_Currency
 
    OPEN Cur_Cursor
 
    FETCH NEXT FROM Cur_Cursor INTO @Currency
 
    WHILE @@FETCH_STATUS = 0
    BEGIN
        Set @Consolidated_Currency =ISNULL(@Consolidated_Currency,'')
        + ISNULL(@Currency + ', ','')
 
            FETCH NEXT FROM Cur_Cursor INTO  @Currency
    END
    Select Left(@Consolidated_Currency,LEN(@Consolidated_Currency)-1) as [Currency]
 
CLOSE Cur_Cursor
DEALLOCATE Cur_Cursor
