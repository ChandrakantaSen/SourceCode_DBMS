create table DailyIncome(VendorId nvarchar(10), IncomeDay nvarchar(10), IncomeAmount int)
insert into DailyIncome values ('SPIKE', 'FRI', 100)

insert into DailyIncome values ('SPIKE', 'MON', 300)

insert into DailyIncome values ('FREDS', 'SUN', 400)
insert into DailyIncome values ('SPIKE', 'WED', 500)
insert into DailyIncome values ('SPIKE', 'TUE', 200)
insert into DailyIncome values ('JOHNS', 'WED', 900)
insert into DailyIncome values ('SPIKE', 'FRI', 100)
insert into DailyIncome values ('JOHNS', 'MON', 300)
insert into DailyIncome values ('SPIKE', 'SUN', 400)
insert into DailyIncome values ('JOHNS', 'FRI', 300)
insert into DailyIncome values ('FREDS', 'TUE', 500)
insert into DailyIncome values ('FREDS', 'TUE', 200)
insert into DailyIncome values ('SPIKE', 'MON', 900)
insert into DailyIncome values ('FREDS', 'FRI', 900)
insert into DailyIncome values ('FREDS', 'MON', 500)
insert into DailyIncome values ('JOHNS', 'SUN', 600)
insert into DailyIncome values ('SPIKE', 'FRI', 300)
insert into DailyIncome values ('SPIKE', 'WED', 500)
insert into DailyIncome values ('SPIKE', 'FRI', 300)
insert into DailyIncome values ('JOHNS', 'THU', 800)
insert into DailyIncome values ('JOHNS', 'SAT', 800)
insert into DailyIncome values ('SPIKE', 'TUE', 100)
insert into DailyIncome values ('SPIKE', 'THU', 300)
insert into DailyIncome values ('FREDS', 'WED', 500)
insert into DailyIncome values ('SPIKE', 'SAT', 100)
insert into DailyIncome values ('FREDS', 'SAT', 500)
insert into DailyIncome values ('FREDS', 'THU', 800)
insert into DailyIncome values ('JOHNS', 'TUE', 600)
select * from DailyIncome
select * from DailyIncome
pivot (max (IncomeAmount) for IncomeDay in ([MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN])) as MaxIncomePerDay
where VendorId in ('SPIKE')
pivot (avg (IncomeAmount) for IncomeDay in ([MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN])) as AvgIncomePerDay

 