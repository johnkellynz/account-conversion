-- Migration 2026-06-30: Rescale account opportunity to ~USD 75M total (AU 85% / NZ 15%)
-- The app converts each account's native currency to the displayed currency with live FX
-- (fallback AUD 1.55, NZD 1.72) and splits the opportunity bar by country. So:
--   AU → AUD, totalling ~USD 63.75M  (85% of 75M)  → 63.75M * 1.55 = 98,812,500 AUD
--   NZ → NZD, totalling ~USD 11.25M  (15% of 75M)  → 11.25M * 1.72 = 19,350,000 NZD
-- Each account gets the per-account mean times (0.5..1.5) for realistic variation; the
-- random factor averages 1.0 so the totals land on target. "Approx" because live FX may
-- differ slightly from the fallback rates above.
-- Run once in the Supabase SQL editor.

begin;

update kac_accounts a
set currency = 'AUD',
    estimated_revenue = round(
      (98812500.0 / nullif((select count(*) from kac_accounts where country = 'AU'), 0))
      * (0.5 + random())
    ),
    updated_at = now()
where a.country = 'AU';

update kac_accounts a
set currency = 'NZD',
    estimated_revenue = round(
      (19350000.0 / nullif((select count(*) from kac_accounts where country = 'NZ'), 0))
      * (0.5 + random())
    ),
    updated_at = now()
where a.country = 'NZ';

commit;

-- Verify (in AUD/NZD; divide by the fx rates for the USD figures) --------------
-- select country, count(*), sum(estimated_revenue) from kac_accounts group by country;
-- AU sum ≈ 98.8M AUD (≈ 63.75M USD), NZ sum ≈ 19.35M NZD (≈ 11.25M USD)
