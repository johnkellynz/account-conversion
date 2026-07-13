-- ============================================================
-- KAC CRM — Restore TEST data (SAFE / additive)
-- Run once in the Supabase SQL Editor, then hard-reload the app.
--
-- This ONLY inserts new "[TEST]" accounts and their contacts,
-- checklist progress and acceptance-matrix cells. It never deletes
-- or overwrites anything, so your REAL accounts are untouched.
-- Everything it adds is prefixed "[TEST]", so supabase_delete_test_data.sql
-- can cleanly remove it again later.
-- ============================================================

begin;

-- ---------- PART 1: [TEST] accounts (assigned round-robin to reps) ----------
with reps as (
  select array_agg(id order by full_name) as ids
  from profiles where role in ('rep', 'manager', 'admin')
),
seed(company_name, country, hq_city, regions, key_sectors, tier, estimated_revenue, currency) as (
  values
    ('[TEST] Aurora Mechanical',        'AU','Sydney',            'NSW','Commercial HVAC',      2,'8200000','AUD'),
    ('[TEST] Brightwater Plumbing',     'AU','Melbourne',         'VIC','Plumbing & Hydronics', 2,'5400000','AUD'),
    ('[TEST] Coastline Air Services',   'AU','Brisbane',          'QLD','Data Centres',         1,'11200000','AUD'),
    ('[TEST] Delta HVAC Solutions',     'AU','Perth',             'WA', 'Industrial',           2,'6100000','AUD'),
    ('[TEST] Evergreen Mechanical',     'AU','Adelaide',          'SA', 'Healthcare',           3,'3300000','AUD'),
    ('[TEST] Fortis Building Services', 'AU','Sydney',            'NSW','Commercial HVAC',      1,'9800000','AUD'),
    ('[TEST] Granite Plumbing Group',   'AU','Newcastle',         'NSW','Plumbing & Hydronics', 2,'4700000','AUD'),
    ('[TEST] Horizon Climate Control',  'AU','Gold Coast',        'QLD','Education',            2,'5200000','AUD'),
    ('[TEST] Ironbark Mechanical',      'AU','Canberra',          'ACT','Commercial HVAC',      3,'2900000','AUD'),
    ('[TEST] Jasper Fire & Hydraulics', 'AU','Melbourne',         'VIC','Fire Protection',      2,'6800000','AUD'),
    ('[TEST] Kingfisher Air Cond.',     'AU','Geelong',           'VIC','Industrial',           2,'4100000','AUD'),
    ('[TEST] Lumen Building Services',  'AU','Darwin',            'NT', 'Commercial HVAC',      3,'2600000','AUD'),
    ('[TEST] Meridian Mechanical',      'AU','Hobart',            'TAS','Healthcare',           2,'3800000','AUD'),
    ('[TEST] Northgate HVAC',           'AU','Wollongong',        'NSW','Data Centres',         1,'10400000','AUD'),
    ('[TEST] Optima Plumbing & Fire',   'AU','Townsville',        'QLD','Fire Protection',      2,'4500000','AUD'),
    ('[TEST] Pacific Mechanical',       'NZ','Auckland',          'AKL','Commercial HVAC',      1,'9200000','NZD'),
    ('[TEST] Rimu Building Services',   'NZ','Wellington',        'WGN','Education',            2,'4300000','NZD'),
    ('[TEST] Southern Cross HVAC',      'NZ','Christchurch',      'CAN','Industrial',           2,'5600000','NZD'),
    ('[TEST] Tasman Plumbing Group',    'NZ','Hamilton',          'WKO','Plumbing & Hydronics', 2,'3700000','NZD'),
    ('[TEST] Kauri Climate Control',    'NZ','Tauranga',          'BOP','Healthcare',           3,'2800000','NZD'),
    ('[TEST] Waitaki Mechanical',       'NZ','Dunedin',           'OTA','Commercial HVAC',      2,'3100000','NZD'),
    ('[TEST] Harbour City Air',         'NZ','Wellington',        'WGN','Data Centres',         1,'7400000','NZD'),
    ('[TEST] Alpine Fire & Hydraulics', 'NZ','Queenstown',        'OTA','Fire Protection',      3,'2200000','NZD'),
    ('[TEST] Silverfern Mechanical',    'NZ','Palmerston North',  'MWT','Industrial',           2,'3900000','NZD')
),
numbered as (
  select s.*, row_number() over () as rn from seed s
)
insert into kac_accounts
  (company_name, country, hq_city, regions, key_sectors, tier, estimated_revenue, currency, current_stage, conversion_status, assigned_to)
select n.company_name, n.country, n.hq_city, n.regions, n.key_sectors, n.tier, n.estimated_revenue, n.currency,
       1, 'New',
       r.ids[1 + ((n.rn - 1) % array_length(r.ids, 1))]
from numbered n
cross join reps r
where not exists (select 1 from kac_accounts x where x.company_name = n.company_name);

-- ---------- PART 2: 3 contacts per [TEST] account ----------
with numbered as (
  select id, row_number() over (order by company_name) as rn
  from kac_accounts where company_name like '[TEST]%'
),
pool as (
  select
    ARRAY['James','Sarah','Mark','Lisa','David','Emma','Tom','Rachel','Michael','Kate',
          'Chris','Priya','Nathan','Jessica','Ryan','Olivia','Daniel','Sophie','Andrew','Megan',
          'Peter','Hannah','Simon','Amy','Ben','Laura','Marcus','Chloe','Jake','Tanya',
          'Paul','Fiona','Luke','Nina','Sam','Rebecca','Owen','Grace','Alex','Holly'] AS fn,
    ARRAY['Mitchell','Chen','Sullivan','Patel','Wong','Richards','Baker','Kim','Williams','Taylor',
          'Sharma','Lee','Adams','Cooper','Martin','Hughes','Clark','Scott','Brown','Nguyen',
          'Davies','Fraser','Robertson','Walker','Johnson','Hall','Stewart','Edwards','Moore','Bennett',
          'Campbell','Anderson','Kapoor','Dixon','Young','Phillips','Murphy','Turner','Price','Liu'] AS ln,
    ARRAY['Estimating Manager','Project Engineer','Procurement Manager','BIM / Technical Lead',
          'Site Foreman / Supervisor','MD / Director / Owner','HSE Manager','Operations Manager',
          'Facilities Manager','Mechanical Lead'] AS rl
),
slots as (
  select n.id, n.rn, s as slot
  from numbered n cross join generate_series(1, 3) as s
)
insert into kac_contacts (account_id, contact_name, role, is_key_influencer)
select sl.id,
  p.fn[1 + ((sl.rn * 3 + sl.slot * 7)  % 40)] || ' ' ||
  p.ln[1 + ((sl.rn * 5 + sl.slot * 11) % 40)],
  p.rl[1 + ((sl.rn + sl.slot) % 10)],
  (sl.slot = 1)
from slots sl cross join pool p;

-- ---------- PART 3: checklist progress (varied stages) for [TEST] accounts ----------
insert into kac_checklist (id, account_id, stage, item_key, completed, completed_at, updated_at)
select gen_random_uuid(), a.id, s.stage, s.item_key, true,
  case
    when s.stage > (abs(hashtext(a.id::text)) % 5)
                   - least(abs(hashtext(a.id::text)) % 5, abs(hashtext(a.id::text||'m')) % 4)
      then date_trunc('month', now())
           + ((abs(hashtext(a.id::text||s.item_key)) % greatest(1, extract(day from now())::int)) || ' days')::interval
           + interval '9 hours'
    else date_trunc('month', now())
           - (((abs(hashtext(a.id::text)) % 5) - s.stage + 1) || ' months')::interval
           + interval '14 days'
  end,
  now()
from kac_accounts a
cross join (values
  (1,'s1_intel_pack'),(1,'s1_map_registers'),(1,'s1_distributor_intel'),(1,'s1_buying_influencers'),
  (2,'s2_industry_events'),(2,'s2_lunch_learn'),(2,'s2_referral'),(2,'s2_linkedin'),(2,'s2_trade_show'),
  (3,'s3_live_demo'),(3,'s3_factory_visit'),(3,'s3_tco_analysis'),(3,'s3_reference_tour'),(3,'s3_bim_revit'),
  (4,'s4_bid_support'),(4,'s4_first_order'),(4,'s4_psa'),(4,'s4_cip')
) as s(stage, item_key)
where a.company_name like '[TEST]%'
  and s.stage <= (abs(hashtext(a.id::text)) % 5)
on conflict (account_id, stage, item_key) do nothing;

-- keep the stored current_stage in step with the seeded checklist
update kac_accounts a
set current_stage = least(5, (abs(hashtext(a.id::text)) % 5) + 1)
where a.company_name like '[TEST]%';

-- ---------- PART 4: acceptance-matrix cells for [TEST] accounts ----------
insert into kac_matrix_data (id, account_id, row_id, col_id, status_id, updated_at, updated_by)
select gen_random_uuid(), a.id, r.id, c.id,
  case
    when (abs(hashtext(a.id::text||r.id::text||c.id::text||'na')) % 10000)/10000.0 < 0.04
      then (select id from kac_matrix_config where config_type='status' and label='N/A'          limit 1)
    when (abs(hashtext(a.id::text||r.id::text||c.id::text||'ap')) % 10000)/10000.0
         < (0.25 + (abs(hashtext(a.id::text)) % 1000)/1000.0 * 0.65)
      then (select id from kac_matrix_config where config_type='status' and label='Accepted'     limit 1)
    when (abs(hashtext(a.id::text||r.id::text||c.id::text||'sp')) % 10000)/10000.0 < 0.50
      then (select id from kac_matrix_config where config_type='status' and label='In Progress'  limit 1)
    when (abs(hashtext(a.id::text||r.id::text||c.id::text||'sp')) % 10000)/10000.0 < 0.80
      then (select id from kac_matrix_config where config_type='status' and label='Not Started'  limit 1)
    else     (select id from kac_matrix_config where config_type='status' and label='Rejected'    limit 1)
  end,
  now() - ((abs(hashtext(a.id::text||r.id::text||c.id::text||'dt')) % 150) || ' days')::interval,
  (select id from profiles limit 1)
from kac_accounts a
cross join (select id from kac_matrix_config where config_type='row') r
cross join (select id from kac_matrix_config where config_type='col') c
where a.company_name like '[TEST]%';

commit;

-- Verify (expect 24 test accounts + ~72 contacts):
-- select count(*) from kac_accounts where company_name like '[TEST]%';
-- select count(*) from kac_contacts where account_id in (select id from kac_accounts where company_name like '[TEST]%');
