-- ============================================================================
-- Field CRM — Migration 2026-05-25
-- Adds LinkedIn connection tracking to the customers table.
-- Stores Yes / No / Unknown as text (mirrors uses_revit_toolbar).
-- Safe to re-run (uses IF NOT EXISTS).
--
-- HOW TO APPLY:
--   1. Open https://supabase.com/dashboard → your project → SQL Editor
--   2. Paste the block below and click Run
--   3. Reload the CRM in your browser — saves will now persist the LinkedIn field
-- ============================================================================

alter table public.customers add column if not exists linkedin_connected text;

-- Quick verification (optional) — confirms the new column exists:
-- select column_name from information_schema.columns
-- where table_schema = 'public' and table_name = 'customers'
--   and column_name = 'linkedin_connected';
