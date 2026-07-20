-- Migration: remove unused account key sectors
-- Date: 2026-07-20
-- The account Key Sectors list is admin-managed via kac_sectors (the code
-- default is only a fallback when that table is empty). This removes
-- Commercial, Retail, Government and Education from the shared list.
-- Accounts that already have one of these saved keep their stored value.

delete from public.kac_sectors
 where label in ('Commercial', 'Retail', 'Government', 'Education');
