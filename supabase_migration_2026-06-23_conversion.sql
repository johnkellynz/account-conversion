-- ============================================================================
-- Field CRM — Migration 2026-06-23  ·  ACCOUNT CONVERSION HQ
-- Adds the editable fields the new "Conversion HQ" view writes to, ensures the
-- opportunities table exists in the cloud, and (PART B, OPTIONAL) switches the
-- app from single-user to a shared TEAM model so multiple reps can pull all
-- conversion data together.
--
-- Safe to re-run: every statement uses IF NOT EXISTS / idempotent policy drops.
--
-- HOW TO APPLY:
--   1. Open https://supabase.com/dashboard -> your project -> SQL Editor
--   2. Run PART A now (safe — only adds columns + the opportunities table).
--   3. Read PART B carefully. It changes who can see whose data. Only run it
--      when you are ready for every signed-in user to see all accounts,
--      projects and opportunities (this is the "multiple users / pull all
--      conversion data together" requirement).
--   4. Reload the CRM. The Conversion HQ edit controls will now persist.
-- ============================================================================


-- ============================================================================
-- PART A — Conversion fields + opportunities table  (SAFE, run anytime)
-- ============================================================================

-- ---- customers: account-level conversion attributes ------------------------
alter table public.customers add column if not exists tier                 smallint;     -- 1 / 2 / 3
alter table public.customers add column if not exists conversion_stage     text;         -- identify / engage / demonstrate / convert / grow
alter table public.customers add column if not exists psa_tier             text;         -- current PSA: SILVER / GOLD / PLATINUM
alter table public.customers add column if not exists psa_target_tier      text;         -- target PSA tier
alter table public.customers add column if not exists share_of_wallet_pct  numeric;      -- estimated Victaulic share of this account's spend

-- ---- projects: must-have flag, market, penetration, invoice timing ---------
-- (projects.value already exists from the base schema)
alter table public.projects  add column if not exists must_have            boolean default false;
alter table public.projects  add column if not exists market               text;
alter table public.projects  add column if not exists sector               text;
alter table public.projects  add column if not exists penetration_pct      smallint;     -- manual override of the derived %
alter table public.projects  add column if not exists incumbent            text;         -- who we're displacing (weld / Gruvlok / press-fit)
alter table public.projects  add column if not exists expected_invoice_date date;        -- month this project is likely to invoice / land
alter table public.projects  add column if not exists probability          smallint;     -- 0-100 win probability
alter table public.projects  add column if not exists stage                text;         -- optional project conversion stage

-- ---- opportunities: create if missing, then add conversion columns ---------
-- This table backs the Opportunities view and the new Pipeline-by-month roll-up.
-- It was never in the original schema files, so create it here (idempotent).
create table if not exists public.opportunities (
  id                   bigserial primary key,
  user_id              uuid not null references auth.users(id) on delete cascade,
  customer_id          bigint references public.customers(id) on delete cascade,
  project_id           bigint references public.projects(id)  on delete set null,
  stage                text,
  expected_close_date  date,
  won_lost_reason      text,
  closed_at            timestamptz,
  created_at           timestamptz not null default now()
);
create index if not exists opportunities_user_idx     on public.opportunities(user_id);
create index if not exists opportunities_customer_idx on public.opportunities(customer_id);

-- new conversion columns on opportunities
alter table public.opportunities add column if not exists amount                numeric;   -- opportunity value (falls back to project.value)
alter table public.opportunities add column if not exists probability           smallint;  -- 0-100; otherwise inferred from stage
alter table public.opportunities add column if not exists expected_invoice_date date;      -- the month it lands when invoiced
alter table public.opportunities add column if not exists owner_name            text;      -- display owner for the multi-user pipeline roll-up

-- opportunities RLS — owner-only for now (PART B widens this to the team)
alter table public.opportunities enable row level security;
do $$
begin
  execute 'drop policy if exists "owner_select" on public.opportunities';
  execute 'drop policy if exists "owner_insert" on public.opportunities';
  execute 'drop policy if exists "owner_update" on public.opportunities';
  execute 'drop policy if exists "owner_delete" on public.opportunities';
  execute 'create policy "owner_select" on public.opportunities for select using (user_id = auth.uid())';
  execute 'create policy "owner_insert" on public.opportunities for insert with check (user_id = auth.uid())';
  execute 'create policy "owner_update" on public.opportunities for update using (user_id = auth.uid()) with check (user_id = auth.uid())';
  execute 'create policy "owner_delete" on public.opportunities for delete using (user_id = auth.uid())';
end$$;

-- ---- Seed the 8 Tier-1 national accounts (Australia) -----------------------
-- Creates a placeholder company "anchor" contact for each Tier-1 major so they
-- show up in segmentation / hit-list / funnel immediately. Owned by the user
-- who runs this. Skips any company you already have. Edit/merge later in-app.
insert into public.customers (user_id, name, company, country, category, region, importance, tier, conversion_stage, notes)
select auth.uid(), v.name, v.company, 'AU', 'Contractor T1', v.region, 3, 1, v.stage, v.note
from (values
  ('Watpac Mechanical / BGIS',           'Account anchor — Watpac/BGIS',        'QLD', 'demonstrate', 'Tier 1 seed. Status: Partial — deepen. Health/Defence/Gov, AUD $200M+.'),
  ('JCI / York Mechanical Services',     'Account anchor — JCI/York',           'NSW', 'identify',    'Tier 1 seed. Status: Low — target. Commercial/Industrial, AUD $180M+.'),
  ('Stowe Australia',                    'Account anchor — Stowe',              'QLD', 'demonstrate', 'Tier 1 seed. Status: Partial — grow. Multi-sector, AUD $150M+.'),
  ('Hastie Group / Ventia Mechanical',   'Account anchor — Hastie/Ventia',      'VIC', 'identify',    'Tier 1 seed. Status: Low — target. Health/Commercial, AUD $140M+.'),
  ('Mechanical One (Lendlease Services)','Account anchor — Mechanical One',     'NSW', 'convert',     'Tier 1 seed. Status: Active — protect & grow. Property/Retail/Gov, AUD $120M+.'),
  ('Nilsen (Electrical & Mechanical)',   'Account anchor — Nilsen',             'SA',  'identify',    'Tier 1 seed. Status: Low — target. Industrial/Mining, AUD $100M+.'),
  ('AE Smith',                           'Account anchor — AE Smith',           'VIC', 'grow',        'Tier 1 seed. Status: Active — grow wallet. Commercial/Health, AUD $90M+.'),
  ('Intech Engineers',                   'Account anchor — Intech',             'WA',  'engage',      'Tier 1 seed. Status: Emerging — engage. Resources/Industrial, AUD $80M+.')
) as v(company, name, region, stage, note)
where not exists (
  select 1 from public.customers c
  where c.user_id = auth.uid() and lower(c.company) = lower(v.company)
);

-- ---- Seed the New Zealand Tier-1 targets (modelled — confirm later) ---------
insert into public.customers (user_id, name, company, country, category, region, importance, tier, conversion_stage, notes)
select auth.uid(), v.name, v.company, 'NZ', 'Contractor T1', v.region, 3, 1, 'identify', v.note
from (values
  ('Aquaheat New Zealand', 'Account anchor — Aquaheat',  'Auckland',     'NZ Tier 1 (modelled). NZ largest mechanical contractor, 350+ staff. Commercial/Health/Digital/Mission-critical.'),
  ('Economech',            'Account anchor — Economech', 'Auckland',     'NZ Tier 1 (modelled). Commercial + data centres (Aotea Centre, Auckland Town Hall).'),
  ('Chilltech',            'Account anchor — Chilltech', 'Auckland',     'NZ Tier 1 (modelled). 60+ staff, upper North Island commercial/retail.'),
  ('Thermal Solutions',    'Account anchor — Thermal Sol','Auckland',    'NZ Tier 1 (modelled). Industrial/cold chain/food & bev (Fonterra). Auckland/Hastings/Chch.'),
  ('AMT Group',            'Account anchor — AMT Group', 'Christchurch', 'NZ Tier 1 (modelled). Commercial/health, Christchurch/national.')
) as v(company, name, region, note)
where not exists (
  select 1 from public.customers c
  where c.user_id = auth.uid() and lower(c.company) = lower(v.company)
);

-- Verify PART A:
-- select column_name from information_schema.columns
--   where table_schema='public' and table_name='projects' and column_name='must_have';
-- select company, tier, conversion_stage from public.customers where tier = 1 order by country, company;


-- ============================================================================
-- PART B — TEAM SHARING (OPTIONAL · SECURITY-SENSITIVE · read before running)
-- ----------------------------------------------------------------------------
-- WHAT THIS DOES: replaces the "each user only sees their own rows" policies
-- with "any signed-in user sees and edits ALL rows". This is what makes
-- "multiple users pulling all conversion data together" work — every rep's
-- accounts, projects and opportunities roll up into one shared pipeline.
--
-- IMPLICATION: there is no per-rep privacy after this. Everyone with a login
-- sees everything (this matches your playbook decision: "account sharing fully
-- open across reps"). user_id is still recorded on every row for the audit
-- trail and for owner attribution in the pipeline view.
--
-- Run this ONLY when you have created the other users' logins and are ready to
-- share. To undo, re-run PART A's owner-only policy block per table.
-- ============================================================================

-- Uncomment the whole block below to enable team sharing:
/*
do $$
declare t text;
begin
  foreach t in array array['customers','interactions','projects','products','acceptance','history','lunch_learns','opportunities']
  loop
    execute format('alter table public.%I enable row level security', t);
    execute format('drop policy if exists "owner_select" on public.%I', t);
    execute format('drop policy if exists "owner_insert" on public.%I', t);
    execute format('drop policy if exists "owner_update" on public.%I', t);
    execute format('drop policy if exists "owner_delete" on public.%I', t);
    execute format('drop policy if exists "team_select" on public.%I', t);
    execute format('drop policy if exists "team_insert" on public.%I', t);
    execute format('drop policy if exists "team_update" on public.%I', t);
    execute format('drop policy if exists "team_delete" on public.%I', t);
    -- any authenticated user can read every row
    execute format('create policy "team_select" on public.%I for select using (auth.role() = ''authenticated'')', t);
    -- inserts must still stamp the creator (preserves the audit trail)
    execute format('create policy "team_insert" on public.%I for insert with check (user_id = auth.uid())', t);
    -- any authenticated user can update / delete any row (fully open team)
    execute format('create policy "team_update" on public.%I for update using (auth.role() = ''authenticated'') with check (auth.role() = ''authenticated'')', t);
    execute format('create policy "team_delete" on public.%I for delete using (auth.role() = ''authenticated'')', t);
  end loop;
end$$;
*/

-- After enabling PART B, set owner_name on opportunities so the pipeline-by-
-- owner table reads nicely across users, e.g.:
--   update public.opportunities set owner_name = 'JK' where user_id = auth.uid() and owner_name is null;
