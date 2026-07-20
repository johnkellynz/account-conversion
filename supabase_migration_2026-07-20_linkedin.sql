-- Migration: LinkedIn connection flag on contacts
-- Date: 2026-07-20
-- Adds linkedin_connected to kac_contacts, shown as a "Connected on LinkedIn"
-- checkbox in the contact forms and an "in" badge in the contact lists.
-- Run BEFORE deploying the new index.html — contact saves include this
-- column and will fail to sync without it.

alter table public.kac_contacts
  add column if not exists linkedin_connected boolean default false;
