-- Migration: account branches (multi-region accounts)
-- Date: 2026-07-20
-- One account can now have extra branch locations (e.g. Aquaheat Wellington
-- under the Aquaheat account), each with its own optional rep. Checklist,
-- acceptance matrix and opportunity stay at the account level. Contacts can
-- be tagged to a branch. Run BEFORE deploying the new index.html.

create table if not exists public.kac_branches (
  id uuid primary key,
  account_id uuid not null references public.kac_accounts(id) on delete cascade,
  city text not null,
  region text,
  rep_id uuid references public.profiles(id),
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.kac_branches enable row level security;

drop policy if exists "kac_branches_read" on public.kac_branches;
create policy "kac_branches_read" on public.kac_branches
  for select to authenticated using (true);

drop policy if exists "kac_branches_write" on public.kac_branches;
create policy "kac_branches_write" on public.kac_branches
  for all to authenticated using (true) with check (true);

alter table public.kac_contacts
  add column if not exists branch_id uuid references public.kac_branches(id) on delete set null;
