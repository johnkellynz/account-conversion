-- ============================================================
-- KAC CRM — Create Team Accounts (No Email Sent)
-- Run in Supabase SQL Editor
-- https://supabase.co/dashboard/project/iqshxrebqnqhexsfozqw/sql
-- Date: 2026-06-28
-- ============================================================
--
-- This script creates 15 Victaulic team accounts by inserting
-- directly into auth.users and auth.identities, which bypasses
-- Supabase email confirmation flow — no emails are sent.
--
-- The handle_new_user() trigger on auth.users automatically
-- creates a row in public.profiles for each new user.
--
-- Passwords follow the pattern: KAC_[Firstname]2026!
-- Users should change their password on first login via Profile.
--
-- Team hierarchy:
--   Steve Traynor (divisional manager)
--   ├── David Ellis (manager)
--   │   ├── Assaad Khalil
--   │   ├── Adam Kelso
--   │   ├── John Kelly
--   │   ├── Regan Marwick
--   │   ├── Brendan McAviney
--   │   └── Tom Wilson
--   ├── Josh Shehadeh (manager)
--   │   ├── Adrian Lotfi
--   │   ├── Robert Luscombe
--   │   └── Cristian Rendon
--   └── Ben Hall (manager)
--       ├── Osama Akkawi
--       └── Joshua Parish
-- ============================================================

-- Step 1: Add reports_to column to profiles
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS reports_to uuid REFERENCES profiles(id);

-- Step 2: Create all 15 users
DO $$
DECLARE
  v_steve    uuid;
  v_david    uuid;
  v_josh     uuid;
  v_ben      uuid;
  v_khalil   uuid;
  v_kelso    uuid;
  v_kelly    uuid;
  v_marwick  uuid;
  v_mcaviney uuid;
  v_wilson   uuid;
  v_lotfi    uuid;
  v_luscombe uuid;
  v_rendon   uuid;
  v_akkawi   uuid;
  v_parish   uuid;
BEGIN

  -- --------------------------------------------------------
  -- MANAGERS
  -- --------------------------------------------------------

  -- Steve Traynor — Divisional Manager
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'steve.traynor@victaulic.com', crypt('KAC_Steve2026!', gen_salt('bf')), now(),
    '{"full_name":"Steve Traynor"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_steve;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_steve, jsonb_build_object('sub', v_steve::text, 'email', 'steve.traynor@victaulic.com', 'email_verified', true), 'email', v_steve::text, now(), now(), now());

  -- David Ellis — Manager (reports to Steve)
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'david.ellis@victaulic.com', crypt('KAC_David2026!', gen_salt('bf')), now(),
    '{"full_name":"David Ellis"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_david;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_david, jsonb_build_object('sub', v_david::text, 'email', 'david.ellis@victaulic.com', 'email_verified', true), 'email', v_david::text, now(), now(), now());

  -- Josh Shehadeh — Manager (reports to Steve)
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'josh.shehadeh@victaulic.com', crypt('KAC_Josh2026!', gen_salt('bf')), now(),
    '{"full_name":"Josh Shehadeh"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_josh;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_josh, jsonb_build_object('sub', v_josh::text, 'email', 'josh.shehadeh@victaulic.com', 'email_verified', true), 'email', v_josh::text, now(), now(), now());

  -- Ben Hall — Manager (reports to Steve)
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'ben.hall@victaulic.com', crypt('KAC_Ben2026!', gen_salt('bf')), now(),
    '{"full_name":"Ben Hall"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_ben;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_ben, jsonb_build_object('sub', v_ben::text, 'email', 'ben.hall@victaulic.com', 'email_verified', true), 'email', v_ben::text, now(), now(), now());

  -- --------------------------------------------------------
  -- REPS UNDER DAVID ELLIS
  -- --------------------------------------------------------

  -- Assaad Khalil
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'assaad.khalil@victaulic.com', crypt('KAC_Assaad2026!', gen_salt('bf')), now(),
    '{"full_name":"Assaad Khalil"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_khalil;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_khalil, jsonb_build_object('sub', v_khalil::text, 'email', 'assaad.khalil@victaulic.com', 'email_verified', true), 'email', v_khalil::text, now(), now(), now());

  -- Adam Kelso
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'adam.kelso@victaulic.com', crypt('KAC_Adam2026!', gen_salt('bf')), now(),
    '{"full_name":"Adam Kelso"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_kelso;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_kelso, jsonb_build_object('sub', v_kelso::text, 'email', 'adam.kelso@victaulic.com', 'email_verified', true), 'email', v_kelso::text, now(), now(), now());

  -- John Kelly (already exists — look up existing account)
  SELECT id INTO v_kelly FROM auth.users WHERE email = 'john.kelly@victaulic.com';

  -- Regan Marwick
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'regan.marwick@victaulic.com', crypt('KAC_Regan2026!', gen_salt('bf')), now(),
    '{"full_name":"Regan Marwick"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_marwick;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_marwick, jsonb_build_object('sub', v_marwick::text, 'email', 'regan.marwick@victaulic.com', 'email_verified', true), 'email', v_marwick::text, now(), now(), now());

  -- Brendan McAviney
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'brendan.mcaviney@victaulic.com', crypt('KAC_Brendan2026!', gen_salt('bf')), now(),
    '{"full_name":"Brendan McAviney"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_mcaviney;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_mcaviney, jsonb_build_object('sub', v_mcaviney::text, 'email', 'brendan.mcaviney@victaulic.com', 'email_verified', true), 'email', v_mcaviney::text, now(), now(), now());

  -- Tom Wilson
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'tom.wilson@victaulic.com', crypt('KAC_Tom2026!', gen_salt('bf')), now(),
    '{"full_name":"Tom Wilson"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_wilson;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_wilson, jsonb_build_object('sub', v_wilson::text, 'email', 'tom.wilson@victaulic.com', 'email_verified', true), 'email', v_wilson::text, now(), now(), now());

  -- --------------------------------------------------------
  -- REPS UNDER JOSH SHEHADEH
  -- --------------------------------------------------------

  -- Adrian Lotfi
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'adrian.lotfi@victaulic.com', crypt('KAC_Adrian2026!', gen_salt('bf')), now(),
    '{"full_name":"Adrian Lotfi"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_lotfi;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_lotfi, jsonb_build_object('sub', v_lotfi::text, 'email', 'adrian.lotfi@victaulic.com', 'email_verified', true), 'email', v_lotfi::text, now(), now(), now());

  -- Robert Luscombe
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'robert.luscombe@victaulic.com', crypt('KAC_Robert2026!', gen_salt('bf')), now(),
    '{"full_name":"Robert Luscombe"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_luscombe;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_luscombe, jsonb_build_object('sub', v_luscombe::text, 'email', 'robert.luscombe@victaulic.com', 'email_verified', true), 'email', v_luscombe::text, now(), now(), now());

  -- Cristian Rendon
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'cristian.rendon@victaulic.com', crypt('KAC_Cristian2026!', gen_salt('bf')), now(),
    '{"full_name":"Cristian Rendon"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_rendon;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_rendon, jsonb_build_object('sub', v_rendon::text, 'email', 'cristian.rendon@victaulic.com', 'email_verified', true), 'email', v_rendon::text, now(), now(), now());

  -- --------------------------------------------------------
  -- REPS UNDER BEN HALL
  -- --------------------------------------------------------

  -- Osama Akkawi
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'osama.akkawi@victaulic.com', crypt('KAC_Osama2026!', gen_salt('bf')), now(),
    '{"full_name":"Osama Akkawi"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_akkawi;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_akkawi, jsonb_build_object('sub', v_akkawi::text, 'email', 'osama.akkawi@victaulic.com', 'email_verified', true), 'email', v_akkawi::text, now(), now(), now());

  -- Joshua Parish
  INSERT INTO auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token)
  VALUES ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
    'joshua.parish@victaulic.com', crypt('KAC_Joshua2026!', gen_salt('bf')), now(),
    '{"full_name":"Joshua Parish"}'::jsonb, now(), now(), '', '')
  RETURNING id INTO v_parish;

  INSERT INTO auth.identities (id, user_id, identity_data, provider, provider_id, last_sign_in_at, created_at, updated_at)
  VALUES (gen_random_uuid(), v_parish, jsonb_build_object('sub', v_parish::text, 'email', 'joshua.parish@victaulic.com', 'email_verified', true), 'email', v_parish::text, now(), now(), now());

  -- --------------------------------------------------------
  -- Step 3: UPDATE PROFILES — roles and reports_to
  -- --------------------------------------------------------
  -- The handle_new_user() trigger has already created profile
  -- rows with role='rep' for all 15 users. Now we set managers
  -- and wire up the reporting hierarchy.

  -- Promote managers (including John Kelly)
  UPDATE profiles SET role = 'manager' WHERE id IN (v_steve, v_david, v_josh, v_ben, v_kelly);

  -- Steve is divisional manager — no reports_to

  -- Managers report to Steve
  UPDATE profiles SET reports_to = v_steve WHERE id IN (v_david, v_josh, v_ben);

  -- David's reps
  UPDATE profiles SET reports_to = v_david WHERE id IN (v_khalil, v_kelso, v_kelly, v_marwick, v_mcaviney, v_wilson);

  -- Josh's reps
  UPDATE profiles SET reports_to = v_josh WHERE id IN (v_lotfi, v_luscombe, v_rendon);

  -- Ben's reps
  UPDATE profiles SET reports_to = v_ben WHERE id IN (v_akkawi, v_parish);

  RAISE NOTICE '--- Team creation complete ---';
  RAISE NOTICE 'Steve Traynor  (manager)  id=%', v_steve;
  RAISE NOTICE 'David Ellis    (manager)  id=%', v_david;
  RAISE NOTICE 'Josh Shehadeh  (manager)  id=%', v_josh;
  RAISE NOTICE 'Ben Hall       (manager)  id=%', v_ben;
  RAISE NOTICE 'Assaad Khalil  (rep)      id=%', v_khalil;
  RAISE NOTICE 'Adam Kelso     (rep)      id=%', v_kelso;
  RAISE NOTICE 'John Kelly     (rep)      id=%', v_kelly;
  RAISE NOTICE 'Regan Marwick  (rep)      id=%', v_marwick;
  RAISE NOTICE 'Brendan McAviney (rep)    id=%', v_mcaviney;
  RAISE NOTICE 'Tom Wilson     (rep)      id=%', v_wilson;
  RAISE NOTICE 'Adrian Lotfi   (rep)      id=%', v_lotfi;
  RAISE NOTICE 'Robert Luscombe (rep)     id=%', v_luscombe;
  RAISE NOTICE 'Cristian Rendon (rep)     id=%', v_rendon;
  RAISE NOTICE 'Osama Akkawi   (rep)      id=%', v_akkawi;
  RAISE NOTICE 'Joshua Parish  (rep)      id=%', v_parish;

END $$;
