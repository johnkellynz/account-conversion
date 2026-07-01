-- Migration 2026-07-02: Editable Stakeholder tiers (kac_stakeholders)
--
-- Stakeholder tiers were hard-coded (Owner=-1, Engineer=0, Tier 1/2/3 = 1/2/3) and
-- stored as integers on kac_accounts.tier. This table makes the list admin-editable
-- while keeping tier_value as the integer written to accounts, so existing data is
-- unaffected. Run once in the Supabase SQL editor, then hard-reload.

create table if not exists kac_stakeholders (
  id          uuid primary key default gen_random_uuid(),
  label       text not null,
  tier_value  integer not null,
  sort_order  integer not null default 0
);

-- Seed the existing five tiers (only if the table is empty)
insert into kac_stakeholders (label, tier_value, sort_order)
select * from (values
  ('Owner', -1, 0),
  ('Engineer', 0, 1),
  ('Tier 1 — National Major', 1, 2),
  ('Tier 2 — State Leader', 2, 3),
  ('Tier 3 — Regional Specialist', 3, 4)
) as v(label, tier_value, sort_order)
where not exists (select 1 from kac_stakeholders);

alter table kac_stakeholders enable row level security;
drop policy if exists kac_stakeholders_all_authenticated on kac_stakeholders;
create policy kac_stakeholders_all_authenticated on kac_stakeholders
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

-- Verify:
-- select * from kac_stakeholders order by sort_order;
