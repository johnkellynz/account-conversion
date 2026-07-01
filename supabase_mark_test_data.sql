-- Mark ALL current accounts as test data (run ONCE, now)
-- ---------------------------------------------------------------------------
-- Everything currently in kac_accounts is test/seed data. This prefixes each
-- company name with "[TEST] " so you can tell it apart from the real customers
-- you enter next. Real accounts you add via the app will NOT have the prefix,
-- so the cleanup script later can delete exactly the test data and keep yours.
--
-- Idempotent: accounts already starting with "[TEST]" are skipped, so it's safe
-- to re-run. Run in the Supabase SQL editor, then hard-reload the app.

update kac_accounts
set company_name = '[TEST] ' || company_name
where company_name not like '[TEST]%';

-- Verify (every row should now start with [TEST]):
-- select company_name from kac_accounts order by company_name;
