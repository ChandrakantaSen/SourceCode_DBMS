-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
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
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION TrackingItemsModified(@minId int)
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