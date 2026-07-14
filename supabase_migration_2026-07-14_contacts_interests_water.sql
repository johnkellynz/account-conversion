-- Migration 2026-07-14: (1) add "Water" key sector, (2) add contact "interests" field
-- Run once in the Supabase SQL editor. Safe to re-run (idempotent).
-- Pairs with index.html (SECTORS constant + contact Interests input).

begin;

-- 1) Add "Water" to the admin-managed key sector list -------------------------
--    The Add/Edit Account form renders from kac_sectors when it has rows, so
--    the SECTORS constant alone is not enough to make "Water" appear live.
insert into kac_sectors (label, sort_order)
select 'Water', coalesce((select max(sort_order) from kac_sectors), -1) + 1
where not exists (select 1 from kac_sectors where label = 'Water');

-- 2) Add free-text "interests" column to contacts -----------------------------
--    Required before saving contacts with the new Interests field, otherwise
--    the insert/update is rejected and falls into the offline sync queue.
alter table kac_contacts add column if not exists interests text;

commit;

-- Verify ----------------------------------------------------------------------
-- select label, sort_order from kac_sectors order by sort_order;
-- select column_name from information_schema.columns
--   where table_name = 'kac_contacts' and column_name = 'interests';
