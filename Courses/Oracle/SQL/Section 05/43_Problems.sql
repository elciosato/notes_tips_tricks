select name as company_name
,nullif(commercial_contact,technical_contact) as EXCLUSIVELY_COMMERCIAL_CONTACT
,nvl2(last_contacted,budget,budget_range_start) as budget
,last_contacted as LAST_CONTACTED_DATE
from company
where (nvl(last_contacted,date '2020-01-01') > date '2019-01-01')
order by last_contacted nulls FIRST;