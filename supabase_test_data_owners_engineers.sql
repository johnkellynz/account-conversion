-- ============================================================
-- KAC Test Data: Owner (tier -1) & Engineer (tier 0) accounts
-- 5 Owner + 5 Engineer per team member (150 accounts total)
-- Run in Supabase SQL Editor
-- Date: 2026-06-30
-- ============================================================

-- Delete any previous owner/engineer test data
DELETE FROM kac_checklist WHERE account_id IN (SELECT id FROM kac_accounts WHERE company_name LIKE '[TEST-OWN]%' OR company_name LIKE '[TEST-ENG]%');
DELETE FROM kac_accounts WHERE company_name LIKE '[TEST-OWN]%' OR company_name LIKE '[TEST-ENG]%';

DO $$
DECLARE
  v_steve    uuid;
  v_david    uuid;
  v_josh     uuid;
  v_ben      uuid;
  v_assaad   uuid;
  v_adam      uuid;
  v_john     uuid;
  v_regan    uuid;
  v_brendan  uuid;
  v_tom      uuid;
  v_adrian   uuid;
  v_robert   uuid;
  v_cristian uuid;
  v_osama    uuid;
  v_joshua   uuid;
BEGIN
  -- Look up all team member IDs
  SELECT id INTO v_steve    FROM auth.users WHERE email = 'steve.traynor@victaulic.com';
  SELECT id INTO v_david    FROM auth.users WHERE email = 'david.ellis@victaulic.com';
  SELECT id INTO v_josh     FROM auth.users WHERE email = 'josh.shehadeh@victaulic.com';
  SELECT id INTO v_ben      FROM auth.users WHERE email = 'ben.hall@victaulic.com';
  SELECT id INTO v_assaad   FROM auth.users WHERE email = 'assaad.khalil@victaulic.com';
  SELECT id INTO v_adam      FROM auth.users WHERE email = 'adam.kelso@victaulic.com';
  SELECT id INTO v_john     FROM auth.users WHERE email = 'john.kelly@victaulic.com';
  SELECT id INTO v_regan    FROM auth.users WHERE email = 'regan.marwick@victaulic.com';
  SELECT id INTO v_brendan  FROM auth.users WHERE email = 'brendan.mcaviney@victaulic.com';
  SELECT id INTO v_tom      FROM auth.users WHERE email = 'tom.wilson@victaulic.com';
  SELECT id INTO v_adrian   FROM auth.users WHERE email = 'adrian.lotfi@victaulic.com';
  SELECT id INTO v_robert   FROM auth.users WHERE email = 'robert.luscombe@victaulic.com';
  SELECT id INTO v_cristian FROM auth.users WHERE email = 'cristian.rendon@victaulic.com';
  SELECT id INTO v_osama    FROM auth.users WHERE email = 'osama.akkawi@victaulic.com';
  SELECT id INTO v_joshua   FROM auth.users WHERE email = 'joshua.parish@victaulic.com';

  -- ================================================================
  -- STEVE TRAYNOR — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Traynor Holdings Group', 'AU', -1, 4, 'Sydney', 'NSW', 'Commercial, Property', 'AUD', '18000000', v_steve, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] National Piping Alliance', 'AU', -1, 3, 'Melbourne', 'VIC', 'Industrial, Mining', 'AUD', '12500000', v_steve, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Continental Mechanical Corp', 'AU', -1, 5, 'Brisbane', 'QLD', 'Commercial, Data Centres', 'AUD', '22000000', v_steve, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Pacific Basin Engineering', 'AU', -1, 2, 'Perth', 'WA', 'Mining, Resources', 'AUD', '15000000', v_steve, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Australis Infrastructure', 'AU', -1, 3, 'Adelaide', 'SA', 'Government, Defence', 'AUD', '9800000', v_steve, now(), now());

  -- STEVE TRAYNOR — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Celsius Design Engineers', 'AU', 0, 3, 'Sydney', 'NSW', 'Commercial, Health', 'AUD', '4200000', v_steve, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] ThermalSpec Consulting', 'AU', 0, 2, 'Melbourne', 'VIC', 'Industrial, Education', 'AUD', '2800000', v_steve, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] AirFlow Engineering Group', 'AU', 0, 4, 'Brisbane', 'QLD', 'Health, Pharmaceutical', 'AUD', '5100000', v_steve, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Conduit Systems Engineers', 'AU', 0, 1, 'Perth', 'WA', 'Mining, Resources', 'AUD', '3500000', v_steve, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Hydra Mechanical Design', 'AU', 0, 5, 'Adelaide', 'SA', 'Commercial, Industrial', 'AUD', '6200000', v_steve, now(), now());

  -- ================================================================
  -- DAVID ELLIS — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Ellis Capital Works', 'AU', -1, 3, 'Sydney', 'NSW', 'Commercial, Property', 'AUD', '14000000', v_david, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Harbour Bridge Mechanical', 'AU', -1, 4, 'Sydney', 'NSW', 'Industrial, Defence', 'AUD', '11200000', v_david, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Sovereign Piping Group', 'AU', -1, 2, 'Melbourne', 'VIC', 'Commercial, Data Centres', 'AUD', '16500000', v_david, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Federal Mechanical Services', 'AU', -1, 5, 'Canberra', 'ACT', 'Government, Education', 'AUD', '8900000', v_david, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Emerald City Contractors', 'AU', -1, 1, 'Sydney', 'NSW', 'Health, Pharmaceutical', 'AUD', '13000000', v_david, now(), now());

  -- DAVID ELLIS — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Precision Pipe Engineers', 'AU', 0, 2, 'Sydney', 'NSW', 'Commercial, Health', 'AUD', '3800000', v_david, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] CoolTech Engineering', 'AU', 0, 4, 'Melbourne', 'VIC', 'Industrial, Data Centres', 'AUD', '5500000', v_david, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Structural Climate Design', 'AU', 0, 1, 'Brisbane', 'QLD', 'Commercial, Retail', 'AUD', '2100000', v_david, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] HVAC Solutions Engineering', 'AU', 0, 3, 'Canberra', 'ACT', 'Government, Defence', 'AUD', '4600000', v_david, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Metro Climate Engineers', 'AU', 0, 5, 'Sydney', 'NSW', 'Property, Commercial', 'AUD', '7200000', v_david, now(), now());

  -- ================================================================
  -- JOSH SHEHADEH — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Trans-Tasman Mechanical', 'NZ', -1, 3, 'Auckland', 'AKL', 'Commercial, Industrial', 'NZD', '11000000', v_josh, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Southern Hemisphere Corp', 'NZ', -1, 4, 'Wellington', 'WGN', 'Government, Health', 'NZD', '9500000', v_josh, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Oceanic Infrastructure NZ', 'NZ', -1, 2, 'Christchurch', 'CAN', 'Education, Property', 'NZD', '13500000', v_josh, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Kiwi National Piping', 'NZ', -1, 5, 'Hamilton', 'WKO', 'Industrial, Mining', 'NZD', '8200000', v_josh, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Pacific Rim Contractors', 'NZ', -1, 1, 'Tauranga', 'BOP', 'Commercial, Retail', 'NZD', '7400000', v_josh, now(), now());

  -- JOSH SHEHADEH — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Aotearoa Engineering', 'NZ', 0, 2, 'Auckland', 'AKL', 'Commercial, Health', 'NZD', '3200000', v_josh, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Wellington Design Group', 'NZ', 0, 4, 'Wellington', 'WGN', 'Government, Education', 'NZD', '4800000', v_josh, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Christchurch Rebuild Eng', 'NZ', 0, 3, 'Christchurch', 'CAN', 'Industrial, Property', 'NZD', '5600000', v_josh, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] FlowTech NZ Engineers', 'NZ', 0, 1, 'Napier', 'HKB', 'Commercial, Retail', 'NZD', '2400000', v_josh, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Tui Mechanical Design', 'NZ', 0, 5, 'Hamilton', 'WKO', 'Mining, Resources', 'NZD', '6100000', v_josh, now(), now());

  -- ================================================================
  -- BEN HALL — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Hall Capital Projects', 'AU', -1, 4, 'Sydney', 'NSW', 'Commercial, Data Centres', 'AUD', '16000000', v_ben, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Antipodean Mechanical', 'AU', -1, 2, 'Melbourne', 'VIC', 'Industrial, Property', 'AUD', '10500000', v_ben, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Commonwealth HVAC Group', 'AU', -1, 3, 'Canberra', 'ACT', 'Government, Defence', 'AUD', '12800000', v_ben, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Gold Coast Mega Services', 'AU', -1, 5, 'Gold Coast', 'QLD', 'Commercial, Retail', 'AUD', '9200000', v_ben, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Outback Capital Works', 'AU', -1, 1, 'Darwin', 'NT', 'Mining, Resources', 'AUD', '14300000', v_ben, now(), now());

  -- BEN HALL — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Integral Pipe Design', 'AU', 0, 3, 'Sydney', 'NSW', 'Commercial, Health', 'AUD', '4000000', v_ben, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Southern Cross Engineers', 'AU', 0, 1, 'Melbourne', 'VIC', 'Industrial, Education', 'AUD', '2500000', v_ben, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Ventilation Systems Eng', 'AU', 0, 4, 'Brisbane', 'QLD', 'Health, Property', 'AUD', '5300000', v_ben, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] ARC Mechanical Design', 'AU', 0, 2, 'Perth', 'WA', 'Mining, Resources', 'AUD', '3700000', v_ben, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Horizon Climate Engineers', 'AU', 0, 5, 'Adelaide', 'SA', 'Government, Commercial', 'AUD', '6800000', v_ben, now(), now());

  -- ================================================================
  -- ASSAAD KHALIL — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Darling Harbour Mechanical', 'AU', -1, 3, 'Sydney', 'NSW', 'Commercial, Property', 'AUD', '11500000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Eastern Seaboard HVAC', 'AU', -1, 4, 'Newcastle', 'NSW', 'Industrial, Defence', 'AUD', '9800000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Capital Region Piping', 'AU', -1, 2, 'Canberra', 'ACT', 'Government, Health', 'AUD', '8400000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Greater Sydney Contractors', 'AU', -1, 5, 'Sydney', 'NSW', 'Data Centres, Commercial', 'AUD', '15200000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Hunter Region Holdings', 'AU', -1, 1, 'Maitland', 'NSW', 'Mining, Resources', 'AUD', '7600000', v_assaad, now(), now());

  -- ASSAAD KHALIL — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Parramatta Pipe Design', 'AU', 0, 2, 'Sydney', 'NSW', 'Commercial, Retail', 'AUD', '3100000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Coastal Climate Engineers', 'AU', 0, 4, 'Wollongong', 'NSW', 'Industrial, Education', 'AUD', '4900000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] ProVent Engineering', 'AU', 0, 1, 'Sydney', 'NSW', 'Health, Pharmaceutical', 'AUD', '2300000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Inline Mechanical Design', 'AU', 0, 3, 'Newcastle', 'NSW', 'Commercial, Property', 'AUD', '5200000', v_assaad, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] ACT Climate Consulting', 'AU', 0, 5, 'Canberra', 'ACT', 'Government, Defence', 'AUD', '6500000', v_assaad, now(), now());

  -- ================================================================
  -- ADAM KELSO — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Western Mining Services', 'AU', -1, 4, 'Perth', 'WA', 'Mining, Resources', 'AUD', '14500000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Kimberley Industrial Group', 'AU', -1, 2, 'Broome', 'WA', 'Industrial, Mining', 'AUD', '8900000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Adelaide Metro Holdings', 'AU', -1, 3, 'Adelaide', 'SA', 'Commercial, Health', 'AUD', '11000000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Nullarbor Construction Corp', 'AU', -1, 5, 'Kalgoorlie', 'WA', 'Mining, Government', 'AUD', '10200000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Swan River Contractors', 'AU', -1, 1, 'Perth', 'WA', 'Commercial, Property', 'AUD', '7800000', v_adam, now(), now());

  -- ADAM KELSO — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Pilbara Design Group', 'AU', 0, 3, 'Karratha', 'WA', 'Mining, Resources', 'AUD', '4400000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] WA Ventilation Engineers', 'AU', 0, 1, 'Perth', 'WA', 'Commercial, Industrial', 'AUD', '2600000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Flinders Mechanical Design', 'AU', 0, 4, 'Adelaide', 'SA', 'Health, Education', 'AUD', '5000000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Goldfields Pipe Engineers', 'AU', 0, 2, 'Kalgoorlie', 'WA', 'Mining, Government', 'AUD', '3300000', v_adam, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] South West Climate Eng', 'AU', 0, 5, 'Bunbury', 'WA', 'Industrial, Property', 'AUD', '6000000', v_adam, now(), now());

  -- ================================================================
  -- JOHN KELLY — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Macquarie Mechanical Group', 'AU', -1, 3, 'Sydney', 'NSW', 'Commercial, Data Centres', 'AUD', '13500000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] North Shore Holdings', 'AU', -1, 4, 'Sydney', 'NSW', 'Health, Pharmaceutical', 'AUD', '10800000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Central Coast Contractors', 'AU', -1, 2, 'Gosford', 'NSW', 'Industrial, Property', 'AUD', '8100000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Blue Mountains HVAC Corp', 'AU', -1, 5, 'Penrith', 'NSW', 'Education, Government', 'AUD', '9400000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Inner West Piping Group', 'AU', -1, 1, 'Sydney', 'NSW', 'Commercial, Retail', 'AUD', '7200000', v_john, now(), now());

  -- JOHN KELLY — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Bondi Climate Design', 'AU', 0, 2, 'Sydney', 'NSW', 'Commercial, Property', 'AUD', '3600000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Olympic Park Engineers', 'AU', 0, 4, 'Sydney', 'NSW', 'Data Centres, Industrial', 'AUD', '5400000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Hawkesbury Pipe Design', 'AU', 0, 1, 'Windsor', 'NSW', 'Education, Health', 'AUD', '2200000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] CBD Mechanical Engineers', 'AU', 0, 3, 'Sydney', 'NSW', 'Commercial, Retail', 'AUD', '4800000', v_john, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Northern Beaches Eng', 'AU', 0, 5, 'Sydney', 'NSW', 'Property, Government', 'AUD', '7000000', v_john, now(), now());

  -- ================================================================
  -- REGAN MARWICK — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Sunshine State Holdings', 'AU', -1, 4, 'Brisbane', 'QLD', 'Commercial, Retail', 'AUD', '12000000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Moreton Bay Contractors', 'AU', -1, 2, 'Brisbane', 'QLD', 'Industrial, Property', 'AUD', '8500000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Queensland National Corp', 'AU', -1, 3, 'Townsville', 'QLD', 'Mining, Resources', 'AUD', '14800000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Barrier Reef Mechanical', 'AU', -1, 5, 'Cairns', 'QLD', 'Government, Health', 'AUD', '9100000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Toowoomba Capital Works', 'AU', -1, 1, 'Toowoomba', 'QLD', 'Education, Commercial', 'AUD', '6800000', v_regan, now(), now());

  -- REGAN MARWICK — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Brisbane Climate Design', 'AU', 0, 3, 'Brisbane', 'QLD', 'Commercial, Health', 'AUD', '4100000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Tropical Air Engineers', 'AU', 0, 1, 'Cairns', 'QLD', 'Industrial, Mining', 'AUD', '2700000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Gold Coast HVAC Design', 'AU', 0, 4, 'Gold Coast', 'QLD', 'Commercial, Retail', 'AUD', '5200000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Darling Downs Engineers', 'AU', 0, 2, 'Toowoomba', 'QLD', 'Education, Government', 'AUD', '3000000', v_regan, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Mackay Pipe Design', 'AU', 0, 5, 'Mackay', 'QLD', 'Mining, Resources', 'AUD', '6300000', v_regan, now(), now());

  -- ================================================================
  -- BRENDAN MCAVINEY — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Yarra Valley Holdings', 'AU', -1, 3, 'Melbourne', 'VIC', 'Commercial, Property', 'AUD', '11800000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Port Philip Contractors', 'AU', -1, 4, 'Melbourne', 'VIC', 'Industrial, Data Centres', 'AUD', '13200000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Gippsland Mechanical Corp', 'AU', -1, 2, 'Traralgon', 'VIC', 'Mining, Resources', 'AUD', '8700000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Geelong Capital Works', 'AU', -1, 5, 'Geelong', 'VIC', 'Education, Health', 'AUD', '10100000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Tasmania Premier Group', 'AU', -1, 1, 'Hobart', 'TAS', 'Government, Commercial', 'AUD', '7300000', v_brendan, now(), now());

  -- BRENDAN MCAVINEY — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Docklands Pipe Design', 'AU', 0, 2, 'Melbourne', 'VIC', 'Commercial, Property', 'AUD', '3400000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Dandenong Climate Eng', 'AU', 0, 4, 'Dandenong', 'VIC', 'Industrial, Logistics', 'AUD', '5100000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Ballarat HVAC Design', 'AU', 0, 1, 'Ballarat', 'VIC', 'Education, Government', 'AUD', '2400000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Latrobe Valley Engineers', 'AU', 0, 3, 'Traralgon', 'VIC', 'Mining, Resources', 'AUD', '4700000', v_brendan, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Hobart Climate Consulting', 'AU', 0, 5, 'Hobart', 'TAS', 'Health, Commercial', 'AUD', '6400000', v_brendan, now(), now());

  -- ================================================================
  -- TOM WILSON — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Sunshine Coast Holdings', 'AU', -1, 4, 'Maroochydore', 'QLD', 'Commercial, Retail', 'AUD', '10900000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Fraser Coast Contractors', 'AU', -1, 2, 'Hervey Bay', 'QLD', 'Health, Education', 'AUD', '7800000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Rockhampton Industrial', 'AU', -1, 3, 'Rockhampton', 'QLD', 'Mining, Resources', 'AUD', '12400000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Illawarra Mechanical Group', 'AU', -1, 5, 'Wollongong', 'NSW', 'Industrial, Defence', 'AUD', '9600000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Tamworth Capital Works', 'AU', -1, 1, 'Tamworth', 'NSW', 'Government, Property', 'AUD', '6500000', v_tom, now(), now());

  -- TOM WILSON — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Redcliffe HVAC Design', 'AU', 0, 3, 'Brisbane', 'QLD', 'Commercial, Health', 'AUD', '4300000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Central QLD Engineers', 'AU', 0, 1, 'Rockhampton', 'QLD', 'Mining, Industrial', 'AUD', '2500000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Ipswich Pipe Design', 'AU', 0, 4, 'Ipswich', 'QLD', 'Education, Government', 'AUD', '5300000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] South Coast Climate Eng', 'AU', 0, 2, 'Wollongong', 'NSW', 'Industrial, Defence', 'AUD', '3200000', v_tom, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] New England Mechanical Eng', 'AU', 0, 5, 'Armidale', 'NSW', 'Property, Commercial', 'AUD', '6100000', v_tom, now(), now());

  -- ================================================================
  -- ADRIAN LOTFI — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Auckland Metro Holdings', 'NZ', -1, 3, 'Auckland', 'AKL', 'Commercial, Property', 'NZD', '10500000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Waikato Industrial Group', 'NZ', -1, 4, 'Hamilton', 'WKO', 'Industrial, Mining', 'NZD', '8900000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Bay of Plenty Corp', 'NZ', -1, 2, 'Tauranga', 'BOP', 'Commercial, Retail', 'NZD', '7200000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Northland Piping Holdings', 'NZ', -1, 5, 'Whangarei', 'NTL', 'Government, Health', 'NZD', '6800000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Manukau Contractors NZ', 'NZ', -1, 1, 'Auckland', 'AKL', 'Education, Data Centres', 'NZD', '12000000', v_adrian, now(), now());

  -- ADRIAN LOTFI — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Auckland HVAC Design', 'NZ', 0, 2, 'Auckland', 'AKL', 'Commercial, Health', 'NZD', '3500000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Rotorua Climate Engineers', 'NZ', 0, 4, 'Rotorua', 'BOP', 'Industrial, Property', 'NZD', '4600000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Waikato Pipe Design', 'NZ', 0, 1, 'Hamilton', 'WKO', 'Education, Government', 'NZD', '2100000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] North Shore Engineers NZ', 'NZ', 0, 3, 'Auckland', 'AKL', 'Commercial, Retail', 'NZD', '4200000', v_adrian, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Coromandel Mechanical Eng', 'NZ', 0, 5, 'Thames', 'WKO', 'Mining, Resources', 'NZD', '5800000', v_adrian, now(), now());

  -- ================================================================
  -- ROBERT LUSCOMBE — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Canterbury Plains Group', 'NZ', -1, 4, 'Christchurch', 'CAN', 'Industrial, Property', 'NZD', '9200000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] South Island Holdings', 'NZ', -1, 2, 'Dunedin', 'OTA', 'Education, Health', 'NZD', '7500000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Nelson Tasman Corp', 'NZ', -1, 3, 'Nelson', 'NSN', 'Commercial, Retail', 'NZD', '11300000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Marlborough Contractors', 'NZ', -1, 5, 'Blenheim', 'MBH', 'Industrial, Mining', 'NZD', '8100000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] West Coast Piping NZ', 'NZ', -1, 1, 'Greymouth', 'WTC', 'Government, Resources', 'NZD', '6400000', v_robert, now(), now());

  -- ROBERT LUSCOMBE — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Christchurch Design Group', 'NZ', 0, 3, 'Christchurch', 'CAN', 'Commercial, Health', 'NZD', '4500000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Otago Pipe Engineers', 'NZ', 0, 1, 'Dunedin', 'OTA', 'Education, Property', 'NZD', '2300000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Tasman Climate Design', 'NZ', 0, 4, 'Nelson', 'NSN', 'Industrial, Government', 'NZD', '5700000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Southland HVAC Engineers', 'NZ', 0, 2, 'Invercargill', 'STL', 'Mining, Resources', 'NZD', '3100000', v_robert, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Ashburton Mechanical Eng', 'NZ', 0, 5, 'Ashburton', 'CAN', 'Commercial, Retail', 'NZD', '6600000', v_robert, now(), now());

  -- ================================================================
  -- CRISTIAN RENDON — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Wellington Capital Group', 'NZ', -1, 3, 'Wellington', 'WGN', 'Government, Defence', 'NZD', '10700000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Hawke Bay Holdings', 'NZ', -1, 4, 'Napier', 'HKB', 'Commercial, Health', 'NZD', '8800000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Manawatu Mechanical Corp', 'NZ', -1, 2, 'Palmerston North', 'MWT', 'Education, Industrial', 'NZD', '7100000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Taranaki Industrial NZ', 'NZ', -1, 5, 'New Plymouth', 'TKI', 'Mining, Resources', 'NZD', '9500000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Wairarapa Contractors', 'NZ', -1, 1, 'Masterton', 'WGN', 'Property, Retail', 'NZD', '6200000', v_cristian, now(), now());

  -- CRISTIAN RENDON — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Hutt Valley Design Group', 'NZ', 0, 2, 'Lower Hutt', 'WGN', 'Commercial, Government', 'NZD', '3800000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Kapiti Coast Engineers', 'NZ', 0, 4, 'Paraparaumu', 'WGN', 'Health, Education', 'NZD', '5000000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Whanganui Pipe Design', 'NZ', 0, 1, 'Whanganui', 'MWT', 'Industrial, Retail', 'NZD', '2200000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Gisborne HVAC Engineers', 'NZ', 0, 3, 'Gisborne', 'GIS', 'Commercial, Property', 'NZD', '4400000', v_cristian, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Tararua Mechanical Design', 'NZ', 0, 5, 'Woodville', 'MWT', 'Mining, Government', 'NZD', '6200000', v_cristian, now(), now());

  -- ================================================================
  -- OSAMA AKKAWI — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Western Sydney Holdings', 'AU', -1, 3, 'Parramatta', 'NSW', 'Commercial, Data Centres', 'AUD', '13000000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Bankstown Industrial Corp', 'AU', -1, 4, 'Bankstown', 'NSW', 'Industrial, Logistics', 'AUD', '10400000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Liverpool Mechanical Group', 'AU', -1, 2, 'Liverpool', 'NSW', 'Health, Education', 'AUD', '8200000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Campbelltown Piping Corp', 'AU', -1, 5, 'Campbelltown', 'NSW', 'Government, Defence', 'AUD', '11500000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Sutherland Shire Holdings', 'AU', -1, 1, 'Cronulla', 'NSW', 'Property, Retail', 'AUD', '7000000', v_osama, now(), now());

  -- OSAMA AKKAWI — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Blacktown Climate Design', 'AU', 0, 2, 'Blacktown', 'NSW', 'Commercial, Property', 'AUD', '3300000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Canterbury Pipe Engineers', 'AU', 0, 4, 'Canterbury', 'NSW', 'Health, Pharmaceutical', 'AUD', '5500000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Penrith HVAC Design', 'AU', 0, 1, 'Penrith', 'NSW', 'Industrial, Education', 'AUD', '2000000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Fairfield Mechanical Eng', 'AU', 0, 3, 'Fairfield', 'NSW', 'Commercial, Retail', 'AUD', '4500000', v_osama, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Ryde Ventilation Engineers', 'AU', 0, 5, 'Ryde', 'NSW', 'Data Centres, Government', 'AUD', '6700000', v_osama, now(), now());

  -- ================================================================
  -- JOSHUA PARISH — Owner accounts (tier -1)
  -- ================================================================
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-OWN] Cairns Tropical Holdings', 'AU', -1, 4, 'Cairns', 'QLD', 'Commercial, Health', 'AUD', '9800000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Gladstone Industrial Corp', 'AU', -1, 2, 'Gladstone', 'QLD', 'Mining, Resources', 'AUD', '11200000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Bundaberg Mechanical Group', 'AU', -1, 3, 'Bundaberg', 'QLD', 'Industrial, Property', 'AUD', '7900000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Redlands Piping Holdings', 'AU', -1, 5, 'Cleveland', 'QLD', 'Education, Government', 'AUD', '10600000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST-OWN] Logan City Contractors', 'AU', -1, 1, 'Logan', 'QLD', 'Commercial, Retail', 'AUD', '6300000', v_joshua, now(), now());

  -- JOSHUA PARISH — Engineer accounts (tier 0)
  INSERT INTO kac_accounts (id, company_name, country, tier, current_stage, hq_city, regions, key_sectors, currency, estimated_revenue, assigned_to, created_at, updated_at)
  VALUES
    (gen_random_uuid(), '[TEST-ENG] Noosa Climate Design', 'AU', 0, 3, 'Noosa', 'QLD', 'Commercial, Property', 'AUD', '4200000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Whitsunday Pipe Engineers', 'AU', 0, 1, 'Airlie Beach', 'QLD', 'Industrial, Mining', 'AUD', '2600000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Caboolture HVAC Design', 'AU', 0, 4, 'Caboolture', 'QLD', 'Health, Education', 'AUD', '5100000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Springfield Mechanical Eng', 'AU', 0, 2, 'Springfield', 'QLD', 'Commercial, Retail', 'AUD', '3400000', v_joshua, now(), now()),
    (gen_random_uuid(), '[TEST-ENG] Toowong Climate Engineers', 'AU', 0, 5, 'Brisbane', 'QLD', 'Government, Data Centres', 'AUD', '6500000', v_joshua, now(), now());

  RAISE NOTICE '--- Owner & Engineer test data inserted: 150 accounts ---';

END $$;

-- ============================================================
-- Add checklist completions for realistic stage progress
-- ============================================================

-- Stage 1 items done for accounts at stage 2+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 1, unnest(ARRAY['s1_intel_pack','s1_map_registers','s1_distributor_intel','s1_buying_influencers']),
  true, now(), now()
FROM kac_accounts a WHERE (a.company_name LIKE '[TEST-OWN]%' OR a.company_name LIKE '[TEST-ENG]%') AND a.current_stage >= 2;

-- Stage 2 items done for accounts at stage 3+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 2, unnest(ARRAY['s2_industry_events','s2_lunch_learn','s2_referral','s2_linkedin','s2_trade_show']),
  true, now(), now()
FROM kac_accounts a WHERE (a.company_name LIKE '[TEST-OWN]%' OR a.company_name LIKE '[TEST-ENG]%') AND a.current_stage >= 3;

-- Stage 3 items done for accounts at stage 4+
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 3, unnest(ARRAY['s3_live_demo','s3_factory_visit','s3_tco_analysis','s3_reference_tour','s3_bim_revit']),
  true, now(), now()
FROM kac_accounts a WHERE (a.company_name LIKE '[TEST-OWN]%' OR a.company_name LIKE '[TEST-ENG]%') AND a.current_stage >= 4;

-- Stage 4 items done for accounts at stage 5
INSERT INTO kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
SELECT gen_random_uuid(), a.id, 4, unnest(ARRAY['s4_bid_support','s4_first_order','s4_psa','s4_cip']),
  true, now(), now()
FROM kac_accounts a WHERE (a.company_name LIKE '[TEST-OWN]%' OR a.company_name LIKE '[TEST-ENG]%') AND a.current_stage >= 5;

-- Partial progress on current stage (2 items done)
DO $$
DECLARE
  rec RECORD;
  items text[];
BEGIN
  FOR rec IN SELECT id, current_stage FROM kac_accounts WHERE (company_name LIKE '[TEST-OWN]%' OR company_name LIKE '[TEST-ENG]%') AND current_stage BETWEEN 2 AND 4
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

-- Verify counts
SELECT
  CASE WHEN tier = -1 THEN 'Owner' WHEN tier = 0 THEN 'Engineer' END as tier_type,
  count(*) as total_accounts
FROM kac_accounts
WHERE company_name LIKE '[TEST-OWN]%' OR company_name LIKE '[TEST-ENG]%'
GROUP BY tier
ORDER BY tier;
