USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[InsertStudentrecord]    Script Date: 02/07/2014 13:56:57 ******/
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
 @StudentFirstName Varchar(50),
 @StudentLastName  Varchar(50),
 @StudentEmail     Varchar(50)
) 
As
 Begin
   Insert into students (Student_Id, Fname, Lname, Email)
   Values(@StudentId, @StudentFirstName, @StudentLastName,@StudentEmail)
 End
