USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[InsertStudentrecord]    Script Date: 02/12/2014 15:23:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER Procedure [dbo].[InsertStudentrecord]
(
 @StudentFirstName Varchar(50),
 @StudentLastName  Varchar(50),
 @StudentEmail     Varchar(50)
) 
As
 Begin
   BEGIN TRY 
		 Insert into tbl_Students (Firstname, Lastname, Email)
		 Values(@StudentFirstName, @StudentLastName,@StudentEmail)
		 -- PRINT 'This will not execute'
   END TRY
   BEGIN CATCH
		SELECT ERROR_NUMBER() AS ErrorNumber, 
		       ERROR_SEVERITY() AS ErrorSeverity, 
		       ERROR_STATE() AS ErrorState,				
		       ERROR_PROCEDURE() AS ErrorProcedure, 
		       ERROR_LINE() AS ErrorLine, 
		       ERROR_MESSAGE() AS ErrorMessage;
        END CATCH;
   
 End
