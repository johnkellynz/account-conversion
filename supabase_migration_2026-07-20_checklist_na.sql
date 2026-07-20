-- Migration: N/A option for checklist items
-- Date: 2026-07-20
-- Adds an "na" flag to kac_checklist. Items marked N/A are excluded from
-- stage progress counts (both numerator and denominator) and cannot be
-- checked while N/A. Run this BEFORE using the N/A buttons — without the
-- column, N/A toggles will fail to sync to Supabase.

alter table public.kac_checklist
  add column if not exists na boolean default false;
