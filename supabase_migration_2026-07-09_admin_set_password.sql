-- ============================================================
-- KAC CRM — Admin can set another user's password
-- Run in Supabase SQL Editor
-- Date: 2026-07-09
--
-- The app runs in the browser with the public key, which cannot
-- touch auth.users. This SECURITY DEFINER function runs with
-- elevated rights but refuses callers whose profile role is not
-- admin/director. The app calls it via supa.rpc().
-- ============================================================

CREATE OR REPLACE FUNCTION admin_set_user_password(target_user uuid, new_password text)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, auth, extensions
AS $$
DECLARE
  caller_role text;
BEGIN
  -- Only admins/directors may call this
  SELECT role INTO caller_role FROM public.profiles WHERE id = auth.uid();
  IF caller_role IS NULL OR caller_role NOT IN ('admin', 'director') THEN
    RAISE EXCEPTION 'Not authorized';
  END IF;

  IF new_password IS NULL OR length(new_password) < 8 THEN
    RAISE EXCEPTION 'Password must be at least 8 characters';
  END IF;

  UPDATE auth.users
  SET encrypted_password = extensions.crypt(new_password, extensions.gen_salt('bf')),
      updated_at = now()
  WHERE id = target_user;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'User not found';
  END IF;
END;
$$;

-- Lock down who can even attempt the call
REVOKE EXECUTE ON FUNCTION admin_set_user_password(uuid, text) FROM anon, public;
GRANT EXECUTE ON FUNCTION admin_set_user_password(uuid, text) TO authenticated;
