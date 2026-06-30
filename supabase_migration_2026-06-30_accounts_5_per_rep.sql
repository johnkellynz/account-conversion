-- Migration 2026-06-30: Reduce to exactly 5 accounts per rep & manager (Steve = 0)
-- DESTRUCTIVE: permanently deletes the excess test accounts (and, via FK cascade, their
-- matrix cells / checklist / contacts / notes). Keeps 5 × (reps + managers, excluding
-- Steve Traynor) accounts and assigns them 5-per-person. Admins/directors get none.
--
-- RUN ORDER: run THIS first, THEN re-run the opportunity migration so the ~USD 75M is
-- spread across the final (smaller) set of accounts.
--
-- Run once in the Supabase SQL editor.

begin;

-- 1) Delete the excess accounts (keep the first 5×N by id) -----------------------
with elig as (
  select count(*) as c from profiles
  where role in ('rep','manager') and coalesce(full_name,'') <> 'Steve Traynor'
),
ranked as (select id, row_number() over (order by id) as rn from kac_accounts)
delete from kac_accounts
where id in (select r.id from ranked r, elig where r.rn > elig.c * 5);

-- 2) Assign the survivors exactly 5 per rep/manager ------------------------------
with assignees as (
  select id, row_number() over (order by full_name) as rn
  from profiles
  where role in ('rep','manager') and coalesce(full_name,'') <> 'Steve Traynor'
),
ranked as (select id, row_number() over (order by id) as rn from kac_accounts)
update kac_accounts a
set assigned_to = asn.id, updated_at = now()
from ranked r
join assignees asn on asn.rn = ((r.rn - 1) / 5) + 1
where a.id = r.id;

commit;

-- Verify ----------------------------------------------------------------------
-- select p.full_name, count(a.id)
-- from profiles p left join kac_accounts a on a.assigned_to = p.id
-- where p.role in ('rep','manager') group by p.full_name order by p.full_name;
-- (every rep/manager = 5; Steve Traynor = 0)
-- select count(*) from kac_accounts;   -- should equal 5 × (reps + managers minus Steve)
