-- ============================================================
-- KAC CRM — Admin can create a new user (auth + profile)
-- Run once in the Supabase SQL Editor, then hard-reload the app.
--
-- Mirrors admin_set_user_password: a SECURITY DEFINER function that
-- runs with elevated rights but refuses any caller whose profile role
-- is not admin/director. The browser app calls it via
-- supa.rpc('admin_create_user', {...}). The service_role key is never
-- exposed to the client.
-- ============================================================

CREATE OR REPLACE FUNCTION admin_create_user(
  new_email      text,
  new_password   text,
  new_full_name  text,
  new_role       text DEFAULT 'rep',
  new_country    text DEFAULT NULL,
  new_reports_to uuid DEFAULT NULL
)
RETURNS uuid
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, auth, extensions
AS $$
DECLARE
  caller_role text;
  new_id uuid := gen_random_uuid();
BEGIN
  -- Only admins/directors may call this
  SELECT role INTO caller_role FROM public.profiles WHERE id = auth.uid();
  IF caller_role IS NULL OR caller_role NOT IN ('admin', 'director') THEN
    RAISE EXCEPTION 'Not authorized';
  END IF;

  -- Validate input
  IF new_email IS NULL OR position('@' in new_email) = 0 THEN
    RAISE EXCEPTION 'A valid email is required';
  END IF;
  IF new_password IS NULL OR length(new_password) < 8 THEN
    RAISE EXCEPTION 'Password must be at least 8 characters';
  END IF;
  IF new_role NOT IN ('rep', 'manager', 'admin', 'director') THEN
    RAISE EXCEPTION 'Invalid role';
  END IF;
  IF EXISTS (SELECT 1 FROM auth.users WHERE lower(email) = lower(new_email)) THEN
    RAISE EXCEPTION 'A user with that email already exists';
  END IF;

  -- Create the auth user; email pre-confirmed so they can sign in immediately
  INSERT INTO auth.users (
    instance_id, id, aud, role, email,
    encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data,
    created_at, updated_at
  ) VALUES (
    '00000000-0000-0000-0000-000000000000', new_id, 'authenticated', 'authenticated', lower(new_email),
    extensions.crypt(new_password, extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    jsonb_build_object('full_name', new_full_name),
    now(), now()
  );

  -- Identity row (required for email / password sign-in)
  INSERT INTO auth.identities (
    id, user_id, provider_id, identity_data, provider,
    last_sign_in_at, created_at, updated_at
  ) VALUES (
    gen_random_uuid(), new_id, lower(new_email),
    jsonb_build_object('sub', new_id::text, 'email', lower(new_email), 'email_verified', true),
    'email', now(), now(), now()
  );

  -- The on_auth_user_created trigger already inserted a profiles row;
  -- fill in the role / country / manager chosen in the form.
  UPDATE public.profiles
     SET full_name  = COALESCE(new_full_name, full_name),
         role       = new_role,
         country    = new_country,
         reports_to = new_reports_to,
         updated_at = now()
   WHERE id = new_id;

  RETURN new_id;
END;
$$;

-- Lock down who can even attempt the call
REVOKE EXECUTE ON FUNCTION admin_create_user(text, text, text, text, text, uuid) FROM anon, public;
GRANT  EXECUTE ON FUNCTION admin_create_user(text, text, text, text, text, uuid) TO authenticated;
