CREATE TABLE dealer_list(
   depot_code VARCHAR (10),
   dealer_code VARCHAR (10),
   dealer_child_code VARCHAR (10),
);
INSERT INTO dealer_list VALUES ('017','36591','12345');
select * from dealer_list;
exec dealer_list_p1 
