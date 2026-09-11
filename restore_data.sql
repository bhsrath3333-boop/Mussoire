-- Restores the budgets and expenses that were entered on the earlier
-- Claude-artifact version of Switchback, into the new Supabase database.
-- Run once in Supabase SQL Editor.

update members set budget = 13300 where id in ('dul','jo','vp','pm','bindu','katu');

insert into expenses (description, amount, category, paid_by, split, created_at) values
  ('Train to Dehradun (onward)', 5000, 'transport', 'Bharath', '["Bharath"]'::jsonb, 1789819200000),
  ('Flight home (return)', 8300, 'transport', 'Bharath', '["Bharath"]'::jsonb, 1790164800000),
  ('Car (Baleno rental)', 15357, 'transport', 'Bharath', '["Dul","Jo","VP","PM","Bindu","Bharath"]'::jsonb, 1788782400000),
  ('Flight (Bindu + Jo)', 37811, 'transport', 'Bindu', '["Bindu","Jo"]'::jsonb, 1789041600000),
  ('Nainital Stay Advance', 8000, 'stay', 'Dul', '["Dul","Jo","VP","PM","Bindu","Katu","Bharath"]'::jsonb, 1789041600000);
