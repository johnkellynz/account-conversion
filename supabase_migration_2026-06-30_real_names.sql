-- Migration 2026-06-30: Make customers look real — strip [TEST…] tags, name the fillers
-- 1) The cloned filler accounts ('[TEST] New <hash>') get realistic company names.
-- 2) Every remaining '[TEST-ENG] / [TEST-OWN] / [TEST] …' prefix is stripped.
-- Run once in the Supabase SQL editor. Hard-reload afterwards.

begin;

-- 1) Realistic names for the filler clones
with fillers as (
  select id, row_number() over (order by id) rn
  from kac_accounts where company_name like '[TEST] New %'
),
names(rn, nm) as (values
  (1,'Alpine Air Solutions'),(2,'Summit Mechanical Services'),(3,'Apex HVAC Group'),
  (4,'Vanguard Plumbing & Mechanical'),(5,'Cornerstone Building Services'),(6,'Precision Air Engineering'),
  (7,'Horizon Mechanical'),(8,'Ironbark Mechanical Services'),(9,'Redwood HVAC'),
  (10,'Coastal Climate Engineering'),(11,'Meridian Mechanical Group'),(12,'Sterling Building Services'),
  (13,'Pinnacle Air Solutions'),(14,'Frontier Mechanical'),(15,'Cascade Climate Systems'),
  (16,'Lighthouse Mechanical'),(17,'Keystone HVAC Group'),(18,'Trident Mechanical Services'),
  (19,'Anvil Engineering'),(20,'Brightwater Mechanical'),(21,'Granite Mechanical Group'),
  (22,'Northstar HVAC'),(23,'Sovereign Mechanical'),(24,'Beacon Climate Engineering'),
  (25,'Tasman Mechanical Services'),(26,'Southern Cross HVAC'),(27,'Outback Air Solutions'),
  (28,'Riverside Mechanical'),(29,'Crestline Engineering'),(30,'Highland Mechanical Group')
)
update kac_accounts a
set company_name = names.nm, updated_at = now()
from fillers join names on names.rn = fillers.rn
where a.id = fillers.id;

-- 2) Strip the [TEST…] prefix from the rest
update kac_accounts
set company_name = btrim(regexp_replace(company_name, '^\[TEST[^]]*\]\s*', '')),
    updated_at = now()
where company_name like '[TEST%';

commit;

-- Verify: should return 0
-- select count(*) from kac_accounts where company_name like '[TEST%';
