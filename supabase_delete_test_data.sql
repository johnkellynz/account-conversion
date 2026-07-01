-- Delete ALL test data, keep your real accounts (run LATER, when you're done testing)
-- ---------------------------------------------------------------------------
-- Removes every account whose name starts with "[TEST]" plus all of its child
-- records (matrix cells, checklist, notes, activities, contacts). Accounts you
-- entered yourself have no "[TEST]" prefix, so they are untouched.
--
-- Team members (profiles) and matrix/sector config are NOT test data and are
-- left alone. Run in the Supabase SQL editor.

-- STEP 1 (optional) — preview what will be deleted BEFORE running the delete:
-- select count(*) as test_accounts from kac_accounts where company_name like '[TEST]%';
-- select company_name from kac_accounts where company_name like '[TEST]%' order by company_name;

-- STEP 2 — delete. Wrapped in a transaction: if anything errors, nothing is removed.
begin;

-- Child rows first (explicit — safe whether or not each FK cascades on delete)
delete from kac_matrix_data where account_id in (select id from kac_accounts where company_name like '[TEST]%');
delete from kac_checklist   where account_id in (select id from kac_accounts where company_name like '[TEST]%');
delete from kac_notes       where account_id in (select id from kac_accounts where company_name like '[TEST]%');
delete from kac_activities  where account_id in (select id from kac_accounts where company_name like '[TEST]%');
delete from kac_contacts    where account_id in (select id from kac_accounts where company_name like '[TEST]%');

-- Then the accounts themselves
delete from kac_accounts where company_name like '[TEST]%';

commit;

-- Verify nothing test remains (expect 0):
-- select count(*) from kac_accounts where company_name like '[TEST]%';
