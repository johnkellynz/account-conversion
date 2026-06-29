-- ============================================================
-- KAC Test Data Batch 2: 10 more accounts per rep (110 total)
-- Mixed stages: Engage through Grow & Retain, plus some Identify
-- Run in Supabase SQL Editor
-- ============================================================

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

  -- ========== ASSAAD KHALIL ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Blacktown Mechanical',     'AU', 1, 5, 'Sydney',     'NSW', 'Commercial, Health',      'AUD', '3100000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Riverstone HVAC',          'AU', 2, 4, 'Sydney',     'NSW', 'Data Centres, Property',  'AUD', '1250000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Dandenong Piping',         'AU', 1, 3, 'Melbourne',  'VIC', 'Industrial, Logistics',   'AUD', '2800000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Campbelltown Air Systems', 'AU', 2, 2, 'Sydney',     'NSW', 'Education, Government',   'AUD', '780000',  v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Cranbourne Services',      'AU', 3, 5, 'Melbourne',  'VIC', 'Retail, Commercial',      'AUD', '420000',  v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Penrith Mechanical Co',    'AU', 1, 4, 'Sydney',     'NSW', 'Health, Pharmaceutical',  'AUD', '2650000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Werribee Climate',         'AU', 2, 3, 'Melbourne',  'VIC', 'Commercial, Education',   'AUD', '920000',  v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Liverpool Engineering',    'AU', 1, 2, 'Sydney',     'NSW', 'Defence, Government',     'AUD', '1900000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Epping HVAC Group',        'AU', 2, 1, 'Melbourne',  'VIC', 'Property, Retail',        'AUD', '650000',  v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST] Castle Hill Mechanical',   'AU', 1, 3, 'Sydney',     'NSW', 'Commercial, Industrial',  'AUD', '2400000', v_assaad, now(), now());

  -- ========== ADAM KELSO ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Joondalup Mechanical',     'AU', 1, 4, 'Perth',      'WA',  'Mining, Resources',       'AUD', '3500000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Rockingham HVAC',          'AU', 2, 5, 'Perth',      'WA',  'Commercial, Industrial',  'AUD', '1100000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Salisbury Air Services',   'AU', 1, 3, 'Adelaide',   'SA',  'Defence, Government',     'AUD', '2900000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Midland Piping Co',        'AU', 2, 2, 'Perth',      'WA',  'Resources, Logistics',    'AUD', '850000',  v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Mandurah Mechanical',      'AU', 3, 4, 'Mandurah',   'WA',  'Commercial, Retail',      'AUD', '380000',  v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Elizabeth Engineering',     'AU', 1, 5, 'Adelaide',   'SA',  'Industrial, Health',      'AUD', '3200000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Armadale Climate',         'AU', 2, 3, 'Perth',      'WA',  'Education, Property',     'AUD', '740000',  v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Gawler HVAC Solutions',    'AU', 1, 2, 'Adelaide',   'SA',  'Commercial, Mining',      'AUD', '2100000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Bunbury Mechanical',       'AU', 2, 1, 'Bunbury',    'WA',  'Resources, Industrial',   'AUD', '680000',  v_adam, now(), now()),
    (gen_random_uuid(), '[TEST] Stirling Services',        'AU', 1, 4, 'Perth',      'WA',  'Commercial, Data Centres','AUD', '2750000', v_adam, now(), now());

  -- ========== REGAN MARWICK ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Chatswood Mechanical',     'AU', 1, 5, 'Sydney',     'NSW', 'Commercial, Health',      'AUD', '3300000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Ipswich Air Systems',      'AU', 2, 4, 'Brisbane',   'QLD', 'Industrial, Logistics',   'AUD', '980000',  v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Hornsby HVAC',             'AU', 1, 3, 'Sydney',     'NSW', 'Data Centres, Property',  'AUD', '2600000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Logan Piping Group',       'AU', 2, 2, 'Brisbane',   'QLD', 'Government, Education',   'AUD', '720000',  v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Bankstown Climate',        'AU', 3, 3, 'Sydney',     'NSW', 'Retail, Commercial',      'AUD', '350000',  v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Caboolture Mechanical',    'AU', 1, 4, 'Brisbane',   'QLD', 'Mining, Resources',       'AUD', '2900000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Hurstville Engineering',   'AU', 2, 5, 'Sydney',     'NSW', 'Commercial, Industrial',  'AUD', '1050000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Redcliffe HVAC',           'AU', 1, 2, 'Brisbane',   'QLD', 'Health, Pharmaceutical',  'AUD', '1800000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Strathfield Services',     'AU', 2, 1, 'Sydney',     'NSW', 'Education, Government',   'AUD', '590000',  v_regan, now(), now()),
    (gen_random_uuid(), '[TEST] Toowoomba Mechanical',     'AU', 1, 3, 'Toowoomba',  'QLD', 'Commercial, Property',    'AUD', '2200000', v_regan, now(), now());

  -- ========== BRENDAN MCAVINEY ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Frankston Mechanical',     'AU', 1, 5, 'Melbourne',  'VIC', 'Commercial, Data Centres','AUD', '3400000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Morphett Vale HVAC',       'AU', 2, 4, 'Adelaide',   'SA',  'Industrial, Health',      'AUD', '1080000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Berwick Piping Co',        'AU', 1, 3, 'Melbourne',  'VIC', 'Defence, Government',     'AUD', '2500000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Noarlunga Air Systems',    'AU', 2, 2, 'Adelaide',   'SA',  'Education, Property',     'AUD', '760000',  v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Melton Climate',           'AU', 3, 5, 'Melbourne',  'VIC', 'Retail, Commercial',      'AUD', '390000',  v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Mildura Mechanical',       'AU', 1, 4, 'Mildura',    'VIC', 'Mining, Resources',       'AUD', '2800000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Unley Engineering',        'AU', 2, 3, 'Adelaide',   'SA',  'Commercial, Logistics',   'AUD', '880000',  v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Sunbury HVAC Solutions',   'AU', 1, 2, 'Melbourne',  'VIC', 'Health, Pharmaceutical',  'AUD', '1950000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Prospect Services',        'AU', 2, 1, 'Adelaide',   'SA',  'Government, Education',   'AUD', '620000',  v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST] Pakenham Mechanical',      'AU', 1, 3, 'Melbourne',  'VIC', 'Industrial, Commercial',  'AUD', '2300000', v_brendan, now(), now());

  -- ========== TOM WILSON ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Rockhampton HVAC',         'AU', 1, 5, 'Rockhampton','QLD', 'Mining, Resources',       'AUD', '3600000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Gosford Mechanical',       'AU', 2, 4, 'Gosford',    'NSW', 'Commercial, Property',    'AUD', '1150000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Gladstone Piping',         'AU', 1, 3, 'Gladstone',  'QLD', 'Industrial, Logistics',   'AUD', '2700000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Tamworth Air Services',    'AU', 2, 2, 'Tamworth',   'NSW', 'Education, Health',       'AUD', '690000',  v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Hervey Bay Climate',       'AU', 3, 4, 'Hervey Bay', 'QLD', 'Retail, Government',      'AUD', '340000',  v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Orange Mechanical Co',     'AU', 1, 4, 'Orange',     'NSW', 'Commercial, Defence',     'AUD', '2400000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Bundaberg Engineering',    'AU', 2, 5, 'Bundaberg',  'QLD', 'Industrial, Mining',      'AUD', '980000',  v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Dubbo HVAC Group',         'AU', 1, 2, 'Dubbo',      'NSW', 'Resources, Logistics',    'AUD', '1700000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Emerald Services',         'AU', 2, 1, 'Emerald',    'QLD', 'Mining, Resources',       'AUD', '580000',  v_tom, now(), now()),
    (gen_random_uuid(), '[TEST] Port Macquarie Mechanical','AU', 1, 3, 'Port Macquarie','NSW','Commercial, Health',    'AUD', '2100000', v_tom, now(), now());

  -- ========== ADRIAN LOTFI ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Manukau Mechanical',       'NZ', 1, 5, 'Auckland',      'AKL', 'Commercial, Data Centres','NZD', '2800000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Riccarton HVAC',           'NZ', 2, 4, 'Christchurch',  'CAN', 'Industrial, Education',   'NZD', '920000',  v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Porirua Piping',           'NZ', 1, 3, 'Wellington',    'WGN', 'Government, Health',      'NZD', '2200000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Papakura Air Systems',     'NZ', 2, 2, 'Auckland',      'AKL', 'Property, Retail',        'NZD', '650000',  v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Rotorua Climate',          'NZ', 3, 3, 'Rotorua',       'BOP', 'Commercial, Government',  'NZD', '310000',  v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Henderson Mechanical',     'NZ', 1, 4, 'Auckland',      'AKL', 'Industrial, Mining',      'NZD', '2500000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Palmerston North Eng',     'NZ', 2, 5, 'Palmerston North','MWT','Education, Health',      'NZD', '780000',  v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Botany HVAC Solutions',    'NZ', 1, 2, 'Auckland',      'AKL', 'Commercial, Property',    'NZD', '1600000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Whanganui Services',       'NZ', 2, 1, 'Whanganui',     'MWT', 'Government, Retail',      'NZD', '480000',  v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST] Takapuna Mechanical',      'NZ', 1, 3, 'Auckland',      'AKL', 'Data Centres, Commercial','NZD', '1900000', v_adrian, now(), now());

  -- ========== ROBERT LUSCOMBE ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Mt Albert Mechanical',     'NZ', 1, 5, 'Auckland',      'AKL', 'Commercial, Health',      'NZD', '3000000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Hornby HVAC',              'NZ', 2, 4, 'Christchurch',  'CAN', 'Industrial, Logistics',   'NZD', '870000',  v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Hutt Valley Piping',       'NZ', 1, 3, 'Lower Hutt',    'WGN', 'Government, Defence',     'NZD', '2300000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Te Atatu Air Systems',     'NZ', 2, 2, 'Auckland',      'AKL', 'Education, Property',     'NZD', '590000',  v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Timaru Climate',           'NZ', 3, 4, 'Timaru',        'CAN', 'Commercial, Retail',      'NZD', '280000',  v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Onehunga Mechanical',      'NZ', 1, 4, 'Auckland',      'AKL', 'Data Centres, Industrial','NZD', '2600000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Masterton Engineering',    'NZ', 2, 3, 'Masterton',     'WGN', 'Government, Health',      'NZD', '720000',  v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Avondale HVAC Solutions',  'NZ', 1, 2, 'Auckland',      'AKL', 'Commercial, Property',    'NZD', '1700000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Blenheim Services',        'NZ', 2, 1, 'Blenheim',      'MBH', 'Industrial, Mining',      'NZD', '510000',  v_robert, now(), now()),
    (gen_random_uuid(), '[TEST] Greymouth Mechanical',     'NZ', 1, 5, 'Greymouth',     'WTC', 'Mining, Resources',       'NZD', '1950000', v_robert, now(), now());

  -- ========== CRISTIAN RENDON ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Pakuranga Mechanical',     'NZ', 1, 5, 'Auckland',      'AKL', 'Commercial, Data Centres','NZD', '2700000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Ashburton HVAC',           'NZ', 2, 4, 'Ashburton',     'CAN', 'Industrial, Education',   'NZD', '810000',  v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Kapiti Piping Co',         'NZ', 1, 3, 'Paraparaumu',   'WGN', 'Government, Defence',     'NZD', '2100000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Pukekohe Air Systems',     'NZ', 2, 2, 'Auckland',      'AKL', 'Property, Commercial',    'NZD', '630000',  v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Whakatane Climate',        'NZ', 3, 3, 'Whakatane',     'BOP', 'Health, Government',      'NZD', '290000',  v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Ellerslie Mechanical',     'NZ', 1, 4, 'Auckland',      'AKL', 'Industrial, Logistics',   'NZD', '2400000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Levin Engineering',        'NZ', 2, 5, 'Levin',         'MWT', 'Education, Retail',       'NZD', '750000',  v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Howick HVAC Solutions',    'NZ', 1, 2, 'Auckland',      'AKL', 'Commercial, Health',      'NZD', '1800000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Thames Services',          'NZ', 2, 1, 'Thames',        'WKO', 'Mining, Industrial',      'NZD', '470000',  v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST] Mt Roskill Mechanical',    'NZ', 1, 3, 'Auckland',      'AKL', 'Commercial, Property',    'NZD', '2000000', v_cristian, now(), now());

  -- ========== OSAMA AKKAWI ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Ryde Mechanical',          'AU', 1, 5, 'Sydney',     'NSW', 'Commercial, Health',      'AUD', '3200000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Wanneroo HVAC',            'AU', 2, 4, 'Perth',      'WA',  'Industrial, Mining',      'AUD', '1020000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Thornleigh Piping',        'AU', 1, 3, 'Sydney',     'NSW', 'Data Centres, Property',  'AUD', '2600000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Cockburn Air Systems',     'AU', 2, 2, 'Perth',      'WA',  'Government, Education',   'AUD', '710000',  v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Auburn Climate',           'AU', 3, 4, 'Sydney',     'NSW', 'Retail, Commercial',      'AUD', '360000',  v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Canning Vale Mechanical',  'AU', 1, 4, 'Perth',      'WA',  'Resources, Logistics',    'AUD', '2850000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Concord Engineering',      'AU', 2, 5, 'Sydney',     'NSW', 'Commercial, Industrial',  'AUD', '950000',  v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Gosnells HVAC Solutions',  'AU', 1, 2, 'Perth',      'WA',  'Defence, Government',     'AUD', '1850000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Marrickville Services',    'AU', 2, 1, 'Sydney',     'NSW', 'Education, Property',     'AUD', '580000',  v_osama, now(), now()),
    (gen_random_uuid(), '[TEST] Balcatta Mechanical',      'AU', 1, 3, 'Perth',      'WA',  'Mining, Commercial',      'AUD', '2200000', v_osama, now(), now());

  -- ========== JOSHUA PARISH ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Capalaba Mechanical',      'AU', 1, 5, 'Brisbane',   'QLD', 'Commercial, Industrial',  'AUD', '3500000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Wagga Wagga HVAC',         'AU', 2, 4, 'Wagga Wagga','NSW', 'Education, Health',       'AUD', '890000',  v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Nambour Piping Co',        'AU', 1, 3, 'Nambour',    'QLD', 'Mining, Resources',       'AUD', '2300000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Bathurst Air Systems',     'AU', 2, 2, 'Bathurst',   'NSW', 'Government, Defence',     'AUD', '670000',  v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Beenleigh Climate',        'AU', 3, 5, 'Brisbane',   'QLD', 'Retail, Property',        'AUD', '410000',  v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Lismore Mechanical',       'AU', 1, 4, 'Lismore',    'NSW', 'Commercial, Health',      'AUD', '2700000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Caloundra Engineering',    'AU', 2, 3, 'Caloundra',  'QLD', 'Industrial, Logistics',   'AUD', '810000',  v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Grafton HVAC Solutions',   'AU', 1, 2, 'Grafton',    'NSW', 'Commercial, Property',    'AUD', '1600000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Beaudesert Services',      'AU', 2, 1, 'Brisbane',   'QLD', 'Mining, Government',      'AUD', '530000',  v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST] Coffs Harbour Mechanical', 'AU', 1, 3, 'Coffs Harbour','NSW','Data Centres, Industrial','AUD', '2000000', v_joshua, now(), now());

  -- ========== JOHN KELLY ==========
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at) VALUES
    (gen_random_uuid(), '[TEST] Manly Mechanical',         'AU', 1, 5, 'Sydney',     'NSW', 'Commercial, Property',    'AUD', '3100000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Taupo HVAC',               'NZ', 2, 4, 'Taupo',      'WKO', 'Industrial, Education',   'NZD', '890000',  v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Dee Why Piping',           'AU', 1, 3, 'Sydney',     'NSW', 'Data Centres, Health',    'AUD', '2500000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Rotorua Air Systems',      'NZ', 2, 2, 'Rotorua',    'BOP', 'Government, Commercial',  'NZD', '620000',  v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Brookvale Climate',        'AU', 3, 4, 'Sydney',     'NSW', 'Retail, Education',       'AUD', '370000',  v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Hamilton Mechanical NZ',   'NZ', 1, 4, 'Hamilton',   'WKO', 'Industrial, Mining',      'NZD', '2200000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Mona Vale Engineering',    'AU', 2, 5, 'Sydney',     'NSW', 'Commercial, Defence',     'AUD', '980000',  v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Napier HVAC Solutions',    'NZ', 1, 2, 'Napier',     'HKB', 'Health, Property',        'NZD', '1700000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST] Avalon Services',          'AU', 2, 1, 'Sydney',     'NSW', 'Government, Property',    'AUD', '540000',  v_john, now(), now()),
    (gen_random_uuid(), '[TEST] New Plymouth Mechanical',  'NZ', 1, 3, 'New Plymouth','TKI','Commercial, Resources',   'NZD', '1900000', v_john, now(), now());

END $$;

-- Add checklist completions so stage progress looks realistic
-- Stage 1 complete for accounts at stage 2+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 1, unnest(ARRAY['s1_intel_pack','s1_map_registers','s1_distributor_intel','s1_buying_influencers']),
  true, now(), now()
FROM kac_accounts a WHERE a.company_name LIKE '[TEST]%' AND a.current_stage >= 2
AND a.id NOT IN (SELECT DISTINCT account_id FROM kac_checklist WHERE stage = 1);

-- Stage 2 complete for accounts at stage 3+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 2, unnest(ARRAY['s2_industry_events','s2_lunch_learn','s2_referral','s2_linkedin','s2_trade_show']),
  true, now(), now()
FROM kac_accounts a WHERE a.company_name LIKE '[TEST]%' AND a.current_stage >= 3
AND a.id NOT IN (SELECT DISTINCT account_id FROM kac_checklist WHERE stage = 2);

-- Stage 3 complete for accounts at stage 4+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 3, unnest(ARRAY['s3_live_demo','s3_factory_visit','s3_tco_analysis','s3_reference_tour','s3_bim_revit']),
  true, now(), now()
FROM kac_accounts a WHERE a.company_name LIKE '[TEST]%' AND a.current_stage >= 4
AND a.id NOT IN (SELECT DISTINCT account_id FROM kac_checklist WHERE stage = 3);

-- Stage 4 complete for accounts at stage 5
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 4, unnest(ARRAY['s4_bid_support','s4_first_order','s4_psa','s4_cip']),
  true, now(), now()
FROM kac_accounts a WHERE a.company_name LIKE '[TEST]%' AND a.current_stage >= 5
AND a.id NOT IN (SELECT DISTINCT account_id FROM kac_checklist WHERE stage = 4);

-- Partial progress on current stage (2 items done) for accounts at stage 2-4
DO $$
DECLARE
  rec RECORD;
  items text[];
BEGIN
  FOR rec IN SELECT id, current_stage FROM kac_accounts
    WHERE company_name LIKE '[TEST]%' AND current_stage BETWEEN 2 AND 4
    AND id NOT IN (SELECT DISTINCT account_id FROM kac_checklist WHERE stage = (SELECT current_stage FROM kac_accounts WHERE id = kac_accounts.id))
  LOOP
    CASE rec.current_stage
      WHEN 2 THEN items := ARRAY['s2_industry_events','s2_lunch_learn'];
      WHEN 3 THEN items := ARRAY['s3_live_demo','s3_tco_analysis'];
      WHEN 4 THEN items := ARRAY['s4_bid_support','s4_first_order'];
    END CASE;

    INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
    SELECT gen_random_uuid(), rec.id, rec.current_stage, unnest(items), true, now(), now()
    ON CONFLICT DO NOTHING;
  END LOOP;
END $$;
