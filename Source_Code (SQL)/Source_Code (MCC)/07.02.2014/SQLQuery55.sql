USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[InsertStudentrecord]    Script Date: 02/07/2014 13:39:56 ******/
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
 @StudentId Varchar(50),
 @StudentFirstName Varchar(200),
 @StudentLastName  Varchar(200),
 @StudentEmail     Varchar(50)
) 
As
 Begin
   Insert into Students (Student_Id, Fname, Lname, Email)
   Values(@StudentId, @StudentFirstName, @StudentLastName,@StudentEmail)
 End
