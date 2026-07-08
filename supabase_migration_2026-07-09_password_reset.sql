-- ============================================================
-- KAC CRM — Reset all team passwords
-- Run in Supabase SQL Editor
-- https://supabase.co/dashboard/project/iqshxrebqnqhexsfozqw/sql
-- Date: 2026-07-09
--
-- New pattern: firstname.lastname2026!  (all lowercase)
-- e.g. regan.marwick@victaulic.com -> regan.marwick2026!
-- Derived from the email local-part, so it covers all 15 users.
-- ============================================================

UPDATE auth.users
SET encrypted_password = crypt(lower(split_part(email, '@', 1)) || '2026!', gen_salt('bf')),
    updated_at = now()
WHERE email LIKE '%@victaulic.com';

-- Optional: don't force a password change on next login.
-- Uncomment if you want everyone to keep the new pattern as-is.
-- UPDATE profiles SET must_change_password = false;

-- Verify (returns 15 rows; passwords are hashed, this just confirms who was touched)
SELECT email, updated_at FROM auth.users WHERE email LIKE '%@victaulic.com' ORDER BY email;
