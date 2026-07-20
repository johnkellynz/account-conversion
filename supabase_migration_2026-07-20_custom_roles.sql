-- Migration: per-user custom contact roles
-- Date: 2026-07-20
-- Adds a custom_roles column to profiles so any role a user types manually
-- in a contact form is remembered and offered in their role dropdown on
-- every device. Comma-separated text, same pattern as custom_sectors.

alter table public.profiles
  add column if not exists custom_roles text;
