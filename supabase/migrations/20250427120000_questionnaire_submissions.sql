-- Run via Supabase CLI or paste into SQL Editor (Dashboard → SQL).
-- After applying: disable public sign-ups in Auth so only you create staff accounts,
-- or restrict SELECT further (e.g. by email) if you allow open registration.

create table if not exists public.questionnaire_submissions (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  answers jsonb not null default '{}'::jsonb
);

create index if not exists questionnaire_submissions_created_at_idx
  on public.questionnaire_submissions (created_at desc);

alter table public.questionnaire_submissions enable row level security;

drop policy if exists "Allow insert for questionnaire" on public.questionnaire_submissions;
create policy "Allow insert for questionnaire"
  on public.questionnaire_submissions
  for insert
  to anon, authenticated
  with check (true);

drop policy if exists "Allow select for authenticated staff" on public.questionnaire_submissions;
create policy "Allow select for authenticated staff"
  on public.questionnaire_submissions
  for select
  to authenticated
  using (true);
