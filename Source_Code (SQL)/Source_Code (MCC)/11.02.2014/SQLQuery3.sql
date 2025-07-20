 Create table tblEmployeeCity
(
    vEmpID varchar(10),
    eName varchar(50),
    vCity varchar(50) 
);

INSERT INTO [dbo].[tblEmployeeCity] VALUES ('E001','Ajay Shukla','New York');
INSERT INTO [dbo].[tblEmployeeCity] VALUES ('E002','Sanjay Shukla','Beijing');
INSERT INTO [dbo].[tblEmployeeCity] VALUES ('E003','Vijay Shukla','Banglore');

select * from tblEmployeeCity;