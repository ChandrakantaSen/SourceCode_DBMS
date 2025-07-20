select MiscDb.dbo.dn_dealer_list.dealer_code,
       MiscDb.dbo.dn_dealer_list.active as '44835'
       
from MiscDb.dbo.dn_dealer_list

where 
     MiscDb.dbo.dn_dealer_list.dealer_code=44835
     
 
    declare @sql nvarchar(100)
    set @sql = 'ALTER TABLE reports ADD '+ @columnname+' VARCHAR(50) NULL'
    exec sp_executesql @sql
DECLARE @columnname VARCHAR(50)
SET @columnname = '[on_' + @description +']'
IF NOT EXISTS(SELECT * FROM syscolumns WHERE id = OBJECT_ID('reports')       
    AND NAME = @columnname)
BEGIN      
ALTER TABLE reports ADD @columnname VARCHAR(50) NULL
END