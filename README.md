# Switchback

Live trip planner for the Dehradun → Mussoorie → Haridwar → Nainital → Bhimtal → Rishikesh trip (19–23 Sep). Itinerary voting, a shared budget, a wishlist with comments, and crew profiles — synced live across everyone's phones, no login required.

## Deploying

This is a single static page (`index.html`) backed by [Supabase](https://supabase.com) for shared, realtime data. No build step.

### 1. Create the database

1. Create a free Supabase project.
2. Open **SQL Editor** → New query → paste the contents of `supabase_schema.sql` → Run.
3. Go to **Project Settings → API** and copy the **Project URL** and the **anon public key**.

### 2. Wire up the app

Open `index.html`, find these two lines near the top of the `<script>` block, and fill them in:

```js
var SUPABASE_URL = "REPLACE_WITH_SUPABASE_PROJECT_URL";
var SUPABASE_ANON_KEY = "REPLACE_WITH_SUPABASE_ANON_KEY";
```

The anon key is safe to commit/expose — Supabase's security model relies on the row-level security policies in `supabase_schema.sql`, not on keeping that key secret.

### 3. Deploy to Vercel

Import this repository into Vercel (vercel.com → Add New → Project → pick this repo). No framework preset or build command needed — Vercel serves `index.html` as-is. Deploy.

That's it — the same URL works for everyone, no accounts, no app install.

## Notes

- Everyone reads and writes the same shared tables (`members`, `suggestions`, `expenses`, `wishlist`, `item_info`) — there's no per-user auth, matching the original design as a trusted friend-group tool. Don't reuse this RLS pattern (`using (true) with check (true)`) for anything that needs real access control.
- Identity ("who are you") is just a name picked on each device and stored in `localStorage` — not an account system.
