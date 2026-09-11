-- Switchback trip app — Supabase schema
-- Run this once in Supabase: Project → SQL Editor → New query → paste → Run

create table if not exists members (
  id text primary key,
  name text not null,
  color text,
  home text,
  budget numeric default 0,
  car text default '',
  current_stop text default '',
  joined_at bigint
);

create table if not exists suggestions (
  id uuid primary key default gen_random_uuid(),
  day_id text not null,
  title text not null,
  note text default '',
  place text default '',
  category text default 'see',
  added_by text,
  votes jsonb default '{}'::jsonb,
  comments jsonb default '[]'::jsonb,
  created_at bigint
);

create table if not exists expenses (
  id uuid primary key default gen_random_uuid(),
  description text not null,
  amount numeric not null,
  category text default 'other',
  paid_by text,
  split jsonb default '[]'::jsonb,
  created_at bigint
);

create table if not exists wishlist (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  owner text,
  stop text default '',
  date text default '',
  time text default '',
  place text default '',
  links jsonb default '[]'::jsonb,
  status text default 'pending',
  votes jsonb default '{}'::jsonb,
  comments jsonb default '[]'::jsonb,
  created_at bigint
);

create table if not exists item_info (
  id text primary key,
  poc text default '',
  phone text default '',
  bill_ids jsonb default '[]'::jsonb
);

-- This is a trusted friend-group tool with no login (matches the original
-- design) — every row is readable and writable by anyone with the anon key.
-- That is intentional here, not an oversight: don't reuse this policy
-- pattern for anything with real access-control needs.
alter table members enable row level security;
alter table suggestions enable row level security;
alter table expenses enable row level security;
alter table wishlist enable row level security;
alter table item_info enable row level security;

create policy "anyone can read/write members" on members for all using (true) with check (true);
create policy "anyone can read/write suggestions" on suggestions for all using (true) with check (true);
create policy "anyone can read/write expenses" on expenses for all using (true) with check (true);
create policy "anyone can read/write wishlist" on wishlist for all using (true) with check (true);
create policy "anyone can read/write item_info" on item_info for all using (true) with check (true);

-- Realtime: enable live sync on every table
alter publication supabase_realtime add table members, suggestions, expenses, wishlist, item_info;

-- Seed the 7 crew members
insert into members (id, name, color, car, joined_at) values
  ('dul', 'Dul', '#c96a34', '', 1),
  ('jo', 'Jo', '#3d6357', '', 2),
  ('vp', 'VP', '#b8862e', '', 3),
  ('pm', 'PM', '#7a5cad', '', 4),
  ('bindu', 'Bindu', '#3d7ea6', '', 5),
  ('katu', 'Katu', '#a3402f', 'punto', 6),
  ('bharath', 'Bharath', '#5c8a3d', 'punto', 7)
on conflict (id) do nothing;
