Select T.idperson , 
       CASE 
         WHEN  T.type = 'C' THEN 
           (
              SELECT name 
              from Customers 
              where idcustomer = T.idperson
           ) 
        ELSE
          (
            SELECT name 
            from Providers 
            where idprovider = T.idperson
          )
        END Name 
from myTable T ;
