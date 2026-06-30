-- Migration 2026-06-30: Admin-editable Key Sectors list (kac_sectors)
-- Run once in the Supabase SQL editor. Safe to re-run (idempotent).

create table if not exists kac_sectors (
  id uuid primary key default gen_random_uuid(),
  label text not null,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

alter table kac_sectors enable row level security;

drop policy if exists "kac_sectors_read" on kac_sectors;
create policy "kac_sectors_read" on kac_sectors
  for select to authenticated using (true);

drop policy if exists "kac_sectors_write" on kac_sectors;
create policy "kac_sectors_write" on kac_sectors
  for all to authenticated using (true) with check (true);

-- Seed the approved default sectors, but ONLY if the table is empty
insert into kac_sectors (label, sort_order)
select v.label, v.sort_order
from (values
  ('Commercial', 0), ('Health', 1), ('Education', 2),
  ('Data Centre', 3), ('Industrial', 4), ('Other', 5)
) as v(label, sort_order)
where not exists (select 1 from kac_sectors);
