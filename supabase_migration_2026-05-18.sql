-- ============================================================================
-- Field CRM — Migration 2026-05-18
-- Adds Victaulic Toolbar / training-attendance / invitation-sent tracking to
-- the customers table. Safe to re-run (uses IF NOT EXISTS).
--
-- HOW TO APPLY:
--   1. Open https://supabase.com/dashboard → your project → SQL Editor
--   2. Paste the block below and click Run
--   3. Reload the CRM in your browser — saves will now persist the new fields
-- ============================================================================

alter table public.customers add column if not exists uses_revit_toolbar          text;
alter table public.customers add column if not exists attended_training           text;
alter table public.customers add column if not exists toolbar_invitation_sent_at  date;

-- Quick verification (optional) — shows the three new columns exist:
-- select column_name from information_schema.columns
-- where table_schema = 'public' and table_name = 'customers'
--   and column_name in ('uses_revit_toolbar','attended_training','toolbar_invitation_sent_at');
