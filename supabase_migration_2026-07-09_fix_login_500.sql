-- ============================================================
-- KAC CRM — Fix 500 error on login for manually-created users
-- Run in Supabase SQL Editor
-- Date: 2026-07-09
--
-- Users inserted directly into auth.users (supabase_create_team.sql)
-- have NULLs in token/string columns that GoTrue cannot scan,
-- causing "500" on every sign-in attempt regardless of password.
-- Setting them to empty strings fixes login.
-- ============================================================

UPDATE auth.users SET
  confirmation_token         = COALESCE(confirmation_token, ''),
  recovery_token             = COALESCE(recovery_token, ''),
  email_change               = COALESCE(email_change, ''),
  email_change_token_new     = COALESCE(email_change_token_new, ''),
  email_change_token_current = COALESCE(email_change_token_current, ''),
  phone_change               = COALESCE(phone_change, ''),
  phone_change_token         = COALESCE(phone_change_token, ''),
  reauthentication_token     = COALESCE(reauthentication_token, '')
WHERE email LIKE '%@victaulic.com';

-- Verify: no NULLs should remain in these columns
SELECT email,
       confirmation_token IS NULL OR email_change IS NULL
       OR email_change_token_new IS NULL OR email_change_token_current IS NULL
       OR phone_change IS NULL OR phone_change_token IS NULL
       OR reauthentication_token IS NULL AS still_broken
FROM auth.users
WHERE email LIKE '%@victaulic.com'
ORDER BY email;
