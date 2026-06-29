-- ============================================================
-- KAC CRM — Key Account Conversion Tracking
-- Run in Supabase SQL Editor (https://iqshxrebqnqhexsfozqw.supabase.co)
-- Date: 2026-06-28
-- ============================================================

-- 1. PROFILES (extends auth.users with role & region)
-- ============================================================
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name text NOT NULL DEFAULT '',
  role text NOT NULL DEFAULT 'rep' CHECK (role IN ('rep', 'manager', 'admin')),
  region text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Auto-create profile on user signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name)
  VALUES (new.id, COALESCE(new.raw_user_meta_data->>'full_name', new.email));
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- 2. KAC_ACCOUNTS (target contractor companies)
-- ============================================================
CREATE TABLE IF NOT EXISTS kac_accounts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  company_name text NOT NULL,
  hq_city text DEFAULT '',
  country text NOT NULL DEFAULT 'AU' CHECK (country IN ('AU', 'NZ')),
  tier integer NOT NULL DEFAULT 2 CHECK (tier BETWEEN 1 AND 3),
  key_sectors text DEFAULT '',
  estimated_revenue text DEFAULT '',
  current_stage integer NOT NULL DEFAULT 1 CHECK (current_stage BETWEEN 1 AND 5),
  conversion_status text DEFAULT 'New',
  psa_tier text DEFAULT '' CHECK (psa_tier IN ('', 'Silver', 'Gold', 'Platinum')),
  assigned_to uuid REFERENCES profiles(id),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- 3. KAC_CONTACTS (people at target accounts)
-- ============================================================
CREATE TABLE IF NOT EXISTS kac_contacts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id uuid NOT NULL REFERENCES kac_accounts(id) ON DELETE CASCADE,
  contact_name text NOT NULL,
  role text DEFAULT '',
  email text DEFAULT '',
  phone text DEFAULT '',
  is_key_influencer boolean DEFAULT false,
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- 4. KAC_CHECKLIST (stage completion tracking — 22 items across 5 stages)
-- ============================================================
CREATE TABLE IF NOT EXISTS kac_checklist (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id uuid NOT NULL REFERENCES kac_accounts(id) ON DELETE CASCADE,
  stage integer NOT NULL CHECK (stage BETWEEN 1 AND 5),
  item_key text NOT NULL,
  completed boolean DEFAULT false,
  completed_at timestamptz,
  completed_by uuid REFERENCES profiles(id),
  notes text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(account_id, stage, item_key)
);

-- 5. KAC_NOTES (activity log per account)
-- ============================================================
CREATE TABLE IF NOT EXISTS kac_notes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id uuid NOT NULL REFERENCES kac_accounts(id) ON DELETE CASCADE,
  note text NOT NULL,
  created_by uuid REFERENCES profiles(id),
  created_at timestamptz DEFAULT now()
);

-- ============================================================
-- 6. ROW LEVEL SECURITY
-- ============================================================
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE kac_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE kac_contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE kac_checklist ENABLE ROW LEVEL SECURITY;
ALTER TABLE kac_notes ENABLE ROW LEVEL SECURITY;

-- Helper: is current user a manager or admin?
CREATE OR REPLACE FUNCTION is_manager()
RETURNS boolean AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('manager', 'admin')
  );
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- Profiles
CREATE POLICY "profiles_select" ON profiles FOR SELECT TO authenticated USING (true);
CREATE POLICY "profiles_update_own" ON profiles FOR UPDATE TO authenticated USING (id = auth.uid());

-- Accounts: reps see own, managers/admins see all
CREATE POLICY "accounts_select" ON kac_accounts FOR SELECT TO authenticated
  USING (assigned_to = auth.uid() OR is_manager());
CREATE POLICY "accounts_insert" ON kac_accounts FOR INSERT TO authenticated
  WITH CHECK (true);
CREATE POLICY "accounts_update" ON kac_accounts FOR UPDATE TO authenticated
  USING (assigned_to = auth.uid() OR is_manager());
CREATE POLICY "accounts_delete" ON kac_accounts FOR DELETE TO authenticated
  USING (is_manager());

-- Contacts: access follows account ownership
CREATE POLICY "contacts_all" ON kac_contacts FOR ALL TO authenticated
  USING (EXISTS (
    SELECT 1 FROM kac_accounts
    WHERE id = kac_contacts.account_id
      AND (assigned_to = auth.uid() OR is_manager())
  ));

-- Checklist: access follows account ownership
CREATE POLICY "checklist_all" ON kac_checklist FOR ALL TO authenticated
  USING (EXISTS (
    SELECT 1 FROM kac_accounts
    WHERE id = kac_checklist.account_id
      AND (assigned_to = auth.uid() OR is_manager())
  ));

-- Notes: access follows account ownership
CREATE POLICY "notes_select" ON kac_notes FOR SELECT TO authenticated
  USING (EXISTS (
    SELECT 1 FROM kac_accounts
    WHERE id = kac_notes.account_id
      AND (assigned_to = auth.uid() OR is_manager())
  ));
CREATE POLICY "notes_insert" ON kac_notes FOR INSERT TO authenticated
  WITH CHECK (EXISTS (
    SELECT 1 FROM kac_accounts
    WHERE id = kac_notes.account_id
      AND (assigned_to = auth.uid() OR is_manager())
  ));

-- ============================================================
-- 7. INDEXES
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_kac_accounts_assigned ON kac_accounts(assigned_to);
CREATE INDEX IF NOT EXISTS idx_kac_accounts_country ON kac_accounts(country);
CREATE INDEX IF NOT EXISTS idx_kac_accounts_stage ON kac_accounts(current_stage);
CREATE INDEX IF NOT EXISTS idx_kac_contacts_account ON kac_contacts(account_id);
CREATE INDEX IF NOT EXISTS idx_kac_checklist_account ON kac_checklist(account_id);
CREATE INDEX IF NOT EXISTS idx_kac_checklist_lookup ON kac_checklist(account_id, stage, item_key);
CREATE INDEX IF NOT EXISTS idx_kac_notes_account ON kac_notes(account_id);

-- ============================================================
-- 8. AUTO-UPDATE updated_at
-- ============================================================
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS trigger AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at BEFORE UPDATE ON kac_accounts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON kac_contacts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON kac_checklist
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER set_updated_at BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- 9. SCHEMA ADDITIONS (currency + regions)
-- ============================================================
ALTER TABLE kac_accounts ADD COLUMN IF NOT EXISTS currency text NOT NULL DEFAULT 'AUD' CHECK (currency IN ('AUD', 'NZD', 'USD'));
ALTER TABLE kac_accounts ADD COLUMN IF NOT EXISTS regions text DEFAULT '';
