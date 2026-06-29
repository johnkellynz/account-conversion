-- ============================================================
-- Add 2 dummy contacts per company
-- Run in Supabase SQL Editor
-- ============================================================

-- Clear any existing contacts first
DELETE FROM kac_contacts;

-- Insert 2 unique contacts per account
WITH numbered AS (
  SELECT id, ROW_NUMBER() OVER (ORDER BY company_name) AS rn FROM kac_accounts
),
contact_pool(pair, cname, crole, ckf) AS (VALUES
  (1,  'James Mitchell',   'Operations Manager',        true),
  (1,  'Sarah Chen',       'Procurement Lead',          false),
  (2,  'Mark Sullivan',    'Projects Director',         true),
  (2,  'Lisa Patel',       'Facilities Manager',        false),
  (3,  'David Wong',       'Chief Engineer',            true),
  (3,  'Emma Richards',    'Building Services Manager', false),
  (4,  'Tom Baker',        'Contracts Manager',         true),
  (4,  'Rachel Kim',       'Site Supervisor',           false),
  (5,  'Michael O''Brien', 'Technical Director',        true),
  (5,  'Kate Williams',    'Design Manager',            false),
  (6,  'Chris Taylor',     'Mechanical Lead',           true),
  (6,  'Priya Sharma',     'Supply Chain Manager',      false),
  (7,  'Nathan Lee',       'Asset Manager',             true),
  (7,  'Jessica Adams',    'Maintenance Director',      false),
  (8,  'Ryan Cooper',      'HVAC Manager',              true),
  (8,  'Olivia Martin',    'Plant Engineer',            false),
  (9,  'Daniel Hughes',    'Project Engineer',          true),
  (9,  'Sophie Clark',     'Services Coordinator',      false),
  (10, 'Andrew Scott',     'Estimator',                 true),
  (10, 'Megan Brown',      'Regional Manager',          false),
  (11, 'Peter Nguyen',     'Operations Director',       true),
  (11, 'Hannah Davies',    'Purchasing Officer',        false),
  (12, 'Simon Fraser',     'Head of Engineering',       true),
  (12, 'Amy Robertson',    'Property Manager',          false),
  (13, 'Ben Walker',       'Construction Manager',      true),
  (13, 'Laura Johnson',    'Commissioning Engineer',    false),
  (14, 'Marcus Hall',      'Energy Manager',            true),
  (14, 'Chloe Stewart',    'Technical Lead',            false),
  (15, 'Jake Edwards',     'BMS Manager',               true),
  (15, 'Tanya Moore',      'Service Manager',           false),
  (16, 'Paul Bennett',     'Senior Engineer',           true),
  (16, 'Fiona Campbell',   'Quality Manager',           false),
  (17, 'Luke Anderson',    'Planning Manager',          true),
  (17, 'Nina Kapoor',      'Development Manager',       false),
  (18, 'Sam Dixon',        'Infrastructure Lead',       true),
  (18, 'Rebecca Young',    'Ops Coordinator',           false),
  (19, 'Owen Phillips',    'Building Manager',          true),
  (19, 'Grace Murphy',     'Sustainability Lead',       false),
  (20, 'Alex Turner',      'Head of Procurement',       true),
  (20, 'Holly Price',      'Fleet Manager',             false),
  (21, 'Greg Patterson',   'Mechanical Engineer',       true),
  (21, 'Wendy Liu',        'Contracts Administrator',   false),
  (22, 'Steve Hartley',    'Site Manager',              true),
  (22, 'Diana Reeves',     'Compliance Officer',        false),
  (23, 'Liam O''Connor',   'Services Manager',          true),
  (23, 'Anika Pham',       'Design Coordinator',        false),
  (24, 'Craig Morrison',   'Plant Manager',             true),
  (24, 'Tessa Blackwell',  'Procurement Officer',       false),
  (25, 'Dean Carpenter',   'Estimating Manager',        true),
  (25, 'Kylie Tan',        'Project Coordinator',       false),
  (26, 'Rory Walsh',       'Engineering Manager',       true),
  (26, 'Michelle Santos',  'Office Manager',            false),
  (27, 'Brett Lawson',     'Workshop Manager',          true),
  (27, 'Joanne Kirk',      'Health & Safety Lead',      false),
  (28, 'Tony Marsh',       'Maintenance Manager',       true),
  (28, 'Samantha Byrne',   'Accounts Manager',          false),
  (29, 'Darren Cole',      'Field Supervisor',          true),
  (29, 'Natalie Dunn',     'Scheduling Coordinator',    false),
  (30, 'Phil Dawson',      'General Manager',           true),
  (30, 'Karen West',       'Admin Manager',             false),
  (31, 'Ian Sinclair',     'Piping Superintendent',     true),
  (31, 'Leanne Hart',      'Bid Manager',               false),
  (32, 'Trevor Knight',    'Commissioning Lead',        true),
  (32, 'Angela Russo',     'Client Relations Manager',  false),
  (33, 'Wayne Gibbs',      'Drafting Manager',          true),
  (33, 'Julie Pearce',     'Finance Controller',        false),
  (34, 'Colin Stark',      'QA/QC Manager',             true),
  (34, 'Rhonda Elliot',    'Logistics Coordinator',     false),
  (35, 'Murray Voss',      'Install Manager',           true),
  (35, 'Sandra Kemp',      'Customer Success Lead',     false)
)
INSERT INTO kac_contacts (account_id, contact_name, role, is_key_influencer)
SELECT n.id, cp.cname, cp.crole, cp.ckf
FROM numbered n
JOIN contact_pool cp ON cp.pair = n.rn;
