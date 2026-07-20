-- Migration: "Presented" matrix status + partial-credit scoring
-- Date: 2026-07-20
-- Adds a Presented status to the acceptance matrix, ordered before In Progress.
-- The app now scores each step towards Accepted at a third:
--   Presented = 33.3%, In Progress = 66.7%, Accepted = 100%
--   (Not Started / Not Allowed = 0, N/A excluded from the denominator)
-- Skips the insert if a Presented status already exists.

update public.kac_matrix_config
   set sort_order = sort_order + 1
 where config_type = 'status'
   and sort_order >= (select sort_order from public.kac_matrix_config
                       where config_type = 'status' and label = 'In Progress')
   and not exists (select 1 from public.kac_matrix_config
                    where config_type = 'status' and label = 'Presented');

insert into public.kac_matrix_config (config_type, label, color, sort_order)
select 'status', 'Presented', '#8B5CF6',
       (select sort_order - 1 from public.kac_matrix_config
         where config_type = 'status' and label = 'In Progress')
 where not exists (select 1 from public.kac_matrix_config
                    where config_type = 'status' and label = 'Presented');
