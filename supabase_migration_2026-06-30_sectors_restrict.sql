-- Migration 2026-06-30: Restrict Key Sectors to the approved 6 and remap account data
-- Approved sectors: Commercial, Health, Education, Data Centre, Industrial, Other
-- Run once in the Supabase SQL editor. Safe to re-run (idempotent).
-- Pairs with the SECTORS constant (index.html) and the kac_sectors seed file.

begin;

-- 1) Reset the admin-managed sector list to the approved 6 ---------------------
delete from kac_sectors;
insert into kac_sectors (label, sort_order) values
  ('Commercial',  0),
  ('Health',      1),
  ('Education',   2),
  ('Data Centre', 3),
  ('Industrial',  4),
  ('Other',       5);

-- 2) Remap existing account sector tags onto the approved 6 --------------------
-- key_sectors is a comma-separated text field. For each account we:
--   * split on commas and trim each value
--   * rename "Data Centres" -> "Data Centre"
--   * keep Commercial / Health / Education / Industrial / Data Centre as-is
--   * collapse every other (retired) sector to "Other"
--   * de-duplicate and re-join (alphabetical)
-- Accounts with an empty/NULL key_sectors are left untouched.
update kac_accounts a
set key_sectors = sub.new_sectors,
    updated_at  = now()
from (
  select a2.id,
         coalesce(string_agg(distinct m.mapped, ', ' order by m.mapped), '') as new_sectors
  from kac_accounts a2
  cross join lateral (
    select case
             when btrim(s) ilike 'data centre%'                              then 'Data Centre'
             when btrim(s) in ('Commercial','Health','Education','Industrial') then btrim(s)
             when btrim(s) = ''                                              then null
             else 'Other'
           end as mapped
    from unnest(string_to_array(coalesce(a2.key_sectors, ''), ',')) as s
  ) m
  where m.mapped is not null
  group by a2.id
) sub
where a.id = sub.id
  and coalesce(a.key_sectors, '') <> coalesce(sub.new_sectors, '');

commit;

-- Verify ----------------------------------------------------------------------
-- select label, sort_order from kac_sectors order by sort_order;
-- select distinct key_sectors from kac_accounts order by 1;
