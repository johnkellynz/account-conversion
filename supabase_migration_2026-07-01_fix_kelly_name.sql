-- Migration 2026-07-01: Set John Kelly's profile full_name
--
-- John Kelly's auth account (john.kelly@victaulic.com) pre-existed the team-creation
-- script, so supabase_create_team.sql only looked up his id and never set a full_name
-- for him (unlike the other 14 users). Result: his profiles.full_name is null/empty,
-- so the app shows a "—" dash wherever his name should appear (Rep filter option,
-- active-filter chip, header, rep columns).
--
-- Run once in the Supabase SQL editor, then hard-reload the app.

update profiles
set full_name = 'John Kelly'
where id = (select id from auth.users where email = 'john.kelly@victaulic.com');

-- Verify:
-- select p.id, p.full_name, p.role, u.email
-- from profiles p
-- join auth.users u on u.id = p.id
-- where u.email = 'john.kelly@victaulic.com';
