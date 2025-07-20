create table TEMP_A (
	Tbl_ID	int not null,
	Tbl_Data varchar(50) not null
)
-- Insert sample data in to first temp table
insert into TEMP_A values (1, 'Tbl A Row 1')
insert into TEMP_A values (2, 'Tbl A Row 2')
insert into TEMP_A values (3, 'Tbl A Row 3')
insert into TEMP_A values (4, 'Tbl A Row 4')

-- Create the second temp table
create table TEMP_B (
	Tbl_ID	int not null,
	Tbl_Data varchar(50) not null
)
-- Inset sample data into the second temp table
insert into TEMP_B values (1, 'Tbl B Row 1')
insert into TEMP_B values (2, 'Tbl B Row 2')
insert into TEMP_B values (3, 'Tbl B Row 3a')
insert into TEMP_B values (3, 'Tbl B Row 3b')
insert into TEMP_B values (5, 'Tbl B Row 5')

select * from TEMP_B
select * from TEMP_A
select *
from TEMP_A
LEFT OUTER JOIN TEMP_B
	ON TEMP_A.Tbl_ID = TEMP_B.Tbl_ID
where TEMP_B.Tbl_ID is null

delete tbl_data
from TEMP_A,TEMP_B
where 
