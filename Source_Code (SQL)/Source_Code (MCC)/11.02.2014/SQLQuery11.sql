USE [bd2]
GO
/****** Object:  UserDefinedFunction [dbo].[TrackingItemsModified]    Script Date: 02/11/2014 15:01:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER FUNCTION [dbo].[TrackingItemsModified](@minId int)
RETURNS @trackingItems TABLE (
   Id       int      NOT NULL,
   Issued   date     NOT NULL,
   Category int      NOT NULL,
   Modified datetime NULL
) 
AS
BEGIN
   INSERT INTO @trackingItems (Id, Issued, Category)
   SELECT ti.Id, ti.Issued, ti.Category 
   FROM   TrackingItem ti
   WHERE  ti.Id >= @minId; 
   
   UPDATE @trackingItems
   SET Category = Category + 1,
       Modified = GETDATE()
   WHERE Category%2 = 0;
  
   RETURN;
END;