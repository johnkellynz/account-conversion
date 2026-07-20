-- Migration: per-user custom contact sectors
-- Date: 2026-07-20
-- Adds a custom_sectors column to profiles so each user's manually-entered
-- contact sectors sync across their devices. Comma-separated text, e.g.
-- "Rail, Defence". Only the owning user reads/writes it (existing profiles
-- RLS already restricts updates to the user's own row).

alter table public.profiles
  add column if not exists custom_sectors text;
