-- Migration 2026-06-30: 5 accounts per person (except Steve) + refresh matrix & opportunity
-- One run does everything, in order, inside a single transaction:
--   PART 1  Accounts: every profile EXCEPT Steve Traynor gets exactly 5 accounts.
--           Creates filler accounts if short, deletes if over. (Dave/Ben/Josh/John included.)
--   PART 2  Acceptance matrix test data (varied 25-90%, deterministic) for ALL accounts.
--   PART 3  Opportunity: AU ≈ USD 75M (AUD), NZ ≈ USD 15M (NZD).
-- Run once in the Supabase SQL editor. Hard-reload the app afterwards.

begin;

-- ============================ PART 1: ACCOUNTS ==============================
-- 1a) Delete any surplus over the target (no-op if we have fewer than target)
with tgt as (
  select (select count(*) from profiles where coalesce(full_name,'') <> 'Steve Traynor') * 5 as k
),
ranked as (select id, row_number() over (order by id) rn from kac_accounts)
delete from kac_accounts where id in (select r.id from ranked r, tgt where r.rn > tgt.k);

-- 1b) Create the shortfall by cloning random existing accounts (copies every column)
create temporary table _clones on commit drop as
  select * from kac_accounts order by random()
  limit greatest(0,
    (select count(*) from profiles where coalesce(full_name,'') <> 'Steve Traynor') * 5
    - (select count(*) from kac_accounts));
update _clones set id = gen_random_uuid(), assigned_to = null, created_at = now(), updated_at = now();
update _clones set company_name = '[TEST] New ' || left(id::text, 6);
insert into kac_accounts select * from _clones;

-- 1c) Assign exactly 5 accounts to each assignee (Steve gets none)
with assignees as (
  select id, row_number() over (order by full_name) rn
  from profiles where coalesce(full_name,'') <> 'Steve Traynor'
),
ranked as (select id, row_number() over (order by id) rn from kac_accounts)
update kac_accounts a
set assigned_to = asn.id, updated_at = now()
from ranked r join assignees asn on asn.rn = ((r.rn - 1) / 5) + 1
where a.id = r.id;

-- ======================= PART 2: ACCEPTANCE MATRIX =========================
delete from kac_matrix_data;
insert into kac_matrix_data (id, account_id, row_id, col_id, status_id, updated_at, updated_by)
select gen_random_uuid(), a.id, r.id, c.id,
  case
    when (abs(hashtext(a.id::text||r.id::text||c.id::text||'na')) % 10000)/10000.0 < 0.04
      then (select id from kac_matrix_config where config_type='status' and label='N/A' limit 1)
    when (abs(hashtext(a.id::text||r.id::text||c.id::text||'ap')) % 10000)/10000.0
         < (0.25 + (abs(hashtext(a.id::text)) % 1000)/1000.0 * 0.65)
      then (select id from kac_matrix_config where config_type='status' and label='Approved' limit 1)
    when (abs(hashtext(a.id::text||r.id::text||c.id::text||'sp')) % 10000)/10000.0 < 0.50
      then (select id from kac_matrix_config where config_type='status' and label='In Progress' limit 1)
    when (abs(hashtext(a.id::text||r.id::text||c.id::text||'sp')) % 10000)/10000.0 < 0.80
      then (select id from kac_matrix_config where config_type='status' and label='Not Started' limit 1)
    else (select id from kac_matrix_config where config_type='status' and label='Rejected' limit 1)
  end,
  now() - ((abs(hashtext(a.id::text||r.id::text||c.id::text||'dt')) % 150) || ' days')::interval,
  (select id from profiles limit 1)
from kac_accounts a
cross join (select id from kac_matrix_config where config_type='row') r
cross join (select id from kac_matrix_config where config_type='col') c;

-- ========================= PART 3: OPPORTUNITY =============================
-- AU → AUD totalling ~USD 75M (×1.55) ; NZ → NZD totalling ~USD 15M (×1.72)
update kac_accounts a
set currency = 'AUD',
    estimated_revenue = round((116250000.0 / nullif((select count(*) from kac_accounts where country='AU'),0)) * (0.5 + random())),
    updated_at = now()
where a.country = 'AU';
update kac_accounts a
set currency = 'NZD',
    estimated_revenue = round((25800000.0 / nullif((select count(*) from kac_accounts where country='NZ'),0)) * (0.5 + random())),
    updated_at = now()
where a.country = 'NZ';

commit;

-- Verify ----------------------------------------------------------------------
-- select p.full_name, count(a.id) from profiles p
--   left join kac_accounts a on a.assigned_to = p.id group by p.full_name order by 2 desc;
-- select country, count(*), sum(estimated_revenue) from kac_accounts group by country;
