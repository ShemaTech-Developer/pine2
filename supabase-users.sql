-- PineNotes shared accounts — run once in Supabase SQL Editor
-- Makes login work on any phone/browser/domain (not just the device where account was created)
create table if not exists public.pine_users (
  username text primary key,
  display_name text not null default '',
  pass_hash text not null,
  role text default '',
  teacher_data jsonb default '{}'::jsonb,
  created_at date default current_date
);
alter table public.pine_users enable row level security;
grant select, insert, update, delete on table public.pine_users to anon, authenticated;
grant usage on schema public to anon, authenticated;
drop policy if exists "pine users read" on public.pine_users;
drop policy if exists "pine users insert" on public.pine_users;
drop policy if exists "pine users update" on public.pine_users;
create policy "pine users read" on public.pine_users for select using (true);
create policy "pine users insert" on public.pine_users for insert with check (true);
create policy "pine users update" on public.pine_users for update using (true) with check (true);
-- NOTE: pass_hash is visible to anyone with the anon key in this demo mode.
-- For production, move auth to Supabase Auth (backend). For school demo this is acceptable.
