-- ============================================================================
-- Field CRM — Migration 2026-06-24  ·  PROJECT OWNER
-- Adds owner_name to the projects table so each project can be attributed to
-- a Victaulic rep. When a project is created in the app the logged-in user's
-- email (or display name) is stamped automatically; the rep can nominate a
-- different owner from the same form.
--
-- Safe to re-run: uses IF NOT EXISTS / idempotent.
--
-- HOW TO APPLY:
--   1. Open https://supabase.com/dashboard → your project → SQL Editor → + New query.
--   2. Paste this file and click RUN. Expect "Success. No rows returned."
--   3. Reload the CRM — the Project Owner field will appear in the New / Edit
--      Project modal, pre-filled with the logged-in user's email.
-- ============================================================================

alter table public.projects
  add column if not exists owner_name text;

-- Optional: back-fill existing projects owned by the user who runs this script.
-- Uncomment the line below if you want every existing project attributed to you:
-- update public.projects set owner_name = auth.email() where owner_name is null;

-- Verify:
-- select id, name, owner_name from public.projects order by created_at desc limit 10;
