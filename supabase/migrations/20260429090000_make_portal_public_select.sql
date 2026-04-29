-- Make portal data publicly readable (anon key).
-- WARNING: this exposes all questionnaire submissions to anyone with the portal URL.

drop policy if exists "Allow select for authenticated staff" on public.questionnaire_submissions;
drop policy if exists "Allow public select for questionnaire" on public.questionnaire_submissions;

create policy "Allow public select for questionnaire"
  on public.questionnaire_submissions
  for select
  to anon, authenticated
  using (true);
