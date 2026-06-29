-- ============================================================
-- KAC Test Data: 5 test accounts per rep (55 total)
-- Run in Supabase SQL Editor
-- ============================================================

-- First run the admin columns migration if not done already:
-- ALTER TABLE profiles ADD COLUMN IF NOT EXISTS must_change_password boolean DEFAULT false;
-- ALTER TABLE profiles ADD COLUMN IF NOT EXISTS locked boolean DEFAULT false;
-- UPDATE profiles SET must_change_password = true WHERE id != '5d88315a-9efd-4861-9a36-fc0bba7c8dc4';

-- Delete any previous test data (checklist first, then accounts)
DELETE FROM kac_checklist WHERE account_id IN (SELECT id FROM kac_accounts WHERE company_name LIKE '[TEST]%');
DELETE FROM kac_accounts WHERE company_name LIKE '[TEST]%';

-- Insert test accounts using rep email lookups
DO $$
DECLARE
  v_assaad  uuid;
  v_adam    uuid;
  v_regan  uuid;
  v_brendan uuid;
  v_tom    uuid;
  v_adrian uuid;
  v_robert uuid;
  v_cristian uuid;
  v_osama  uuid;
  v_joshua uuid;
  v_john   uuid;
BEGIN
  SELECT id INTO v_assaad  FROM auth.users WHERE email = 'assaad.khalil@victaulic.com';
  SELECT id INTO v_adam    FROM auth.users WHERE email = 'adam.kelso@victaulic.com';
  SELECT id INTO v_regan   FROM auth.users WHERE email = 'regan.marwick@victaulic.com';
  SELECT id INTO v_brendan FROM auth.users WHERE email = 'brendan.mcaviney@victaulic.com';
  SELECT id INTO v_tom     FROM auth.users WHERE email = 'tom.wilson@victaulic.com';
  SELECT id INTO v_adrian  FROM auth.users WHERE email = 'adrian.lotfi@victaulic.com';
  SELECT id INTO v_robert  FROM auth.users WHERE email = 'robert.luscombe@victaulic.com';
  SELECT id INTO v_cristian FROM auth.users WHERE email = 'cristian.rendon@victaulic.com';
  SELECT id INTO v_osama   FROM auth.users WHERE email = 'osama.akkawi@victaulic.com';
  SELECT id INTO v_joshua  FROM auth.users WHERE email = 'joshua.parish@victaulic.com';
  SELECT id INTO v_john    FROM auth.users WHERE email = 'john.kelly@victaulic.com';

  -- ========== ASSAAD KHALIL (David Ellis team, NSW/VIC) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Apex Mechanical Services', 'AU', 1, 3, 'Sydney', 'NSW', 'Commercial, Health', 'AUD', '2500000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Southern Cross HVAC', 'AU', 2, 2, 'Melbourne', 'VIC', 'Commercial, Education', 'AUD', '800000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Pacific Air Systems', 'AU', 1, 4, 'Brisbane', 'QLD', 'Industrial, Mining', 'AUD', '3200000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Metro Climate Control', 'AU', 3, 1, 'Sydney', 'NSW', 'Retail, Property', 'AUD', '350000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Harbour Mechanical', 'AU', 2, 2, 'Newcastle', 'NSW', 'Defence, Government', 'AUD', '1100000', v_assaad, now(), now());

  -- ========== ADAM KELSO (David Ellis team, WA/SA) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Westfield Mechanical', 'AU', 1, 5, 'Perth', 'WA', 'Mining, Resources', 'AUD', '4100000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Ironbark Engineering', 'AU', 2, 3, 'Adelaide', 'SA', 'Industrial, Logistics', 'AUD', '950000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Coastal Air Solutions', 'AU', 2, 2, 'Gold Coast', 'QLD', 'Commercial, Retail', 'AUD', '720000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Pinnacle HVAC Group', 'AU', 1, 3, 'Melbourne', 'VIC', 'Data Centres, Commercial', 'AUD', '2800000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Territory Mechanical', 'AU', 3, 1, 'Darwin', 'NT', 'Government, Defence', 'AUD', '280000', v_adam, now(), now());

  -- ========== REGAN MARWICK (David Ellis team, NSW/QLD) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] BluePeak Services', 'AU', 1, 4, 'Sydney', 'NSW', 'Health, Pharmaceutical', 'AUD', '3500000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Zenith Climate Systems', 'AU', 2, 2, 'Canberra', 'ACT', 'Government, Education', 'AUD', '600000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Outback Mechanical', 'AU', 3, 1, 'Townsville', 'QLD', 'Mining, Resources', 'AUD', '220000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Eastern Piping Co', 'AU', 2, 3, 'Wollongong', 'NSW', 'Industrial, Logistics', 'AUD', '890000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Riverview HVAC', 'AU', 1, 2, 'Brisbane', 'QLD', 'Commercial, Property', 'AUD', '1900000', v_regan, now(), now());

  -- ========== BRENDAN MCAVINEY (David Ellis team, VIC/SA) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Summit Mechanical Group', 'AU', 1, 3, 'Melbourne', 'VIC', 'Commercial, Data Centres', 'AUD', '2700000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Goldfield Services', 'AU', 2, 1, 'Kalgoorlie', 'WA', 'Mining, Resources', 'AUD', '750000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Bay Area Plumbing & HVAC', 'AU', 2, 4, 'Geelong', 'VIC', 'Industrial, Education', 'AUD', '1050000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] ClimateTech Solutions', 'AU', 3, 2, 'Hobart', 'TAS', 'Government, Health', 'AUD', '310000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Adelaide Mechanical', 'AU', 1, 5, 'Adelaide', 'SA', 'Commercial, Industrial', 'AUD', '3800000', v_brendan, now(), now());

  -- ========== TOM WILSON (David Ellis team, QLD/NSW) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Northern Air Contractors', 'AU', 2, 3, 'Cairns', 'QLD', 'Commercial, Retail', 'AUD', '680000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Redback Mechanical', 'AU', 1, 2, 'Sydney', 'NSW', 'Defence, Government', 'AUD', '2200000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Pioneer HVAC', 'AU', 3, 1, 'Ballarat', 'VIC', 'Education, Property', 'AUD', '190000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Coral Sea Engineering', 'AU', 1, 4, 'Mackay', 'QLD', 'Mining, Resources', 'AUD', '3100000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Murray Valley Mechanical', 'AU', 2, 2, 'Albury', 'NSW', 'Industrial, Logistics', 'AUD', '820000', v_tom, now(), now());

  -- ========== ADRIAN LOTFI (Josh Shehadeh team, NZ) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Kiwi Mechanical Services', 'NZ', 1, 3, 'Auckland', 'AKL', 'Commercial, Health', 'NZD', '1800000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Southern Alps HVAC', 'NZ', 2, 2, 'Christchurch', 'CAN', 'Industrial, Education', 'NZD', '650000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Harbour City Piping', 'NZ', 1, 4, 'Wellington', 'WGN', 'Government, Defence', 'NZD', '2400000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Bay Mechanical Ltd', 'NZ', 3, 1, 'Tauranga', 'BOP', 'Commercial, Retail', 'NZD', '280000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Northland Air Systems', 'NZ', 2, 3, 'Whangarei', 'NTL', 'Industrial, Property', 'NZD', '520000', v_adrian, now(), now());

  -- ========== ROBERT LUSCOMBE (Josh Shehadeh team, NZ) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Pacific Plumbing & HVAC', 'NZ', 1, 5, 'Auckland', 'AKL', 'Commercial, Data Centres', 'NZD', '3200000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Waikato Mechanical', 'NZ', 2, 2, 'Hamilton', 'WKO', 'Industrial, Mining', 'NZD', '780000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Capital Climate Control', 'NZ', 2, 3, 'Wellington', 'WGN', 'Government, Health', 'NZD', '910000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Otago Engineering Services', 'NZ', 3, 1, 'Dunedin', 'OTA', 'Education, Commercial', 'NZD', '190000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Taranaki Mechanical', 'NZ', 1, 2, 'New Plymouth', 'TKI', 'Industrial, Resources', 'NZD', '1500000', v_robert, now(), now());

  -- ========== CRISTIAN RENDON (Josh Shehadeh team, NZ) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Alpine Mechanical NZ', 'NZ', 1, 3, 'Queenstown', 'OTA', 'Commercial, Property', 'NZD', '2100000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] East Cape HVAC', 'NZ', 3, 1, 'Gisborne', 'GIS', 'Industrial, Government', 'NZD', '240000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Hawke Bay Services', 'NZ', 2, 4, 'Napier', 'HKB', 'Health, Commercial', 'NZD', '870000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Nelson Piping Co', 'NZ', 2, 2, 'Nelson', 'NSN', 'Education, Retail', 'NZD', '550000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Southland Mechanical', 'NZ', 1, 2, 'Invercargill', 'STL', 'Mining, Industrial', 'NZD', '1700000', v_cristian, now(), now());

  -- ========== OSAMA AKKAWI (Ben Hall team, AU) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Skyline Mechanical', 'AU', 1, 3, 'Sydney', 'NSW', 'Commercial, Property', 'AUD', '2600000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Red Earth Engineering', 'AU', 2, 1, 'Perth', 'WA', 'Mining, Resources', 'AUD', '900000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Bayside HVAC Solutions', 'AU', 1, 4, 'Melbourne', 'VIC', 'Health, Pharmaceutical', 'AUD', '3400000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Tropics Mechanical', 'AU', 3, 2, 'Darwin', 'NT', 'Government, Defence', 'AUD', '270000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Hunter Valley Piping', 'AU', 2, 3, 'Maitland', 'NSW', 'Industrial, Logistics', 'AUD', '1150000', v_osama, now(), now());

  -- ========== JOSHUA PARISH (Ben Hall team, AU) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Sunstate Mechanical', 'AU', 2, 2, 'Brisbane', 'QLD', 'Commercial, Education', 'AUD', '830000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Great Southern HVAC', 'AU', 1, 5, 'Adelaide', 'SA', 'Industrial, Commercial', 'AUD', '3700000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Canberra Piping Group', 'AU', 2, 3, 'Canberra', 'ACT', 'Government, Defence', 'AUD', '720000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Pilbara Mechanical', 'AU', 1, 1, 'Karratha', 'WA', 'Mining, Resources', 'AUD', '4500000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Launceston Air Services', 'AU', 3, 2, 'Launceston', 'TAS', 'Health, Education', 'AUD', '310000', v_joshua, now(), now());

  -- ========== JOHN KELLY (admin, AU) ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST] Crown Mechanical Group', 'AU', 1, 4, 'Sydney', 'NSW', 'Commercial, Data Centres', 'AUD', '3000000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Parramatta HVAC', 'AU', 2, 2, 'Sydney', 'NSW', 'Health, Property', 'AUD', '950000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Sunshine Coast Piping', 'AU', 2, 3, 'Maroochydore', 'QLD', 'Commercial, Retail', 'AUD', '680000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Fremantle Mechanical', 'AU', 1, 1, 'Fremantle', 'WA', 'Industrial, Logistics', 'AUD', '2100000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Bendigo Climate Systems', 'AU', 3, 5, 'Bendigo', 'VIC', 'Education, Government', 'AUD', '290000', v_john, now(), now());

END $$;

-- Add checklist completions so stage progress looks realistic
-- Stage 1 items done for accounts at stage 2+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 1, unnest(ARRAY['s1_intel_pack','s1_map_registers','s1_distributor_intel','s1_buying_influencers']),
  true, now(), now()
FROM kac_accounts a WHERE a.company_name LIKE '[TEST]%' AND a.current_stage >= 2;

-- Stage 2 items done for accounts at stage 3+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 2, unnest(ARRAY['s2_industry_events','s2_lunch_learn','s2_referral','s2_linkedin','s2_trade_show']),
  true, now(), now()
FROM kac_accounts a WHERE a.company_name LIKE '[TEST]%' AND a.current_stage >= 3;

-- Stage 3 items done for accounts at stage 4+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 3, unnest(ARRAY['s3_live_demo','s3_factory_visit','s3_tco_analysis','s3_reference_tour','s3_bim_revit']),
  true, now(), now()
FROM kac_accounts a WHERE a.company_name LIKE '[TEST]%' AND a.current_stage >= 4;

-- Stage 4 items done for accounts at stage 5
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 4, unnest(ARRAY['s4_bid_support','s4_first_order','s4_psa','s4_cip']),
  true, now(), now()
FROM kac_accounts a WHERE a.company_name LIKE '[TEST]%' AND a.current_stage >= 5;

-- Add partial progress on current stage for accounts at stage 2-4
-- (2 items completed on their current stage)
DO $$
DECLARE
  rec RECORD;
  items text[];
BEGIN
  FOR rec IN SELECT id, current_stage FROM kac_accounts WHERE company_name LIKE '[TEST]%' AND current_stage BETWEEN 2 AND 4
  LOOP
    CASE rec.current_stage
      WHEN 2 THEN items := ARRAY['s2_industry_events','s2_lunch_learn'];
      WHEN 3 THEN items := ARRAY['s3_live_demo','s3_tco_analysis'];
      WHEN 4 THEN items := ARRAY['s4_bid_support','s4_first_order'];
    END CASE;

    INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
    SELECT gen_random_uuid(), rec.id, rec.current_stage, unnest(items), true, now(), now();
  END LOOP;
END $$;

-- Verify: count per rep
SELECT p.full_name, count(a.*) as accounts,
  round(avg(a.current_stage),1) as avg_stage,
  string_agg(DISTINCT a.regions, ', ' ORDER BY a.regions) as regions
FROM kac_accounts a
JOIN profiles p ON p.id = a.assigned_to
WHERE a.company_name LIKE '[TEST]%'
GROUP BY p.full_name
ORDER BY p.full_name;
