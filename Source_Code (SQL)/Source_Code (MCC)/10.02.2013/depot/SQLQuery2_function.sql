use miscdb

select pm_depot_master.regn,
pm_depot_master.depot_code,
pm_depot_master.depot_name,
isnull((dbo.fun1('GC',pm_depot_master.depot_code)),0) "GC",
isnull((dbo.fun1('SC',pm_depot_master.depot_code)),0) "SC",
isnull((dbo.fun1('STA',pm_depot_master.depot_code)),0) "STA",
isnull((dbo.fun1('OTH',pm_depot_master.depot_code)),0) "OTH" 
from pm_depot_master

