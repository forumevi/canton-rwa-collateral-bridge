-- Example queries (adjust table names to your PQS schema/projections)

-- Active loans (projection example; adapt to actual namespace)
SELECT * FROM active_loan;

-- Collateral balances
SELECT borrower, symbol AS collateral_sym, SUM(qty) AS total_collateral
FROM collateral_vault
GROUP BY borrower, symbol;

-- LTV (assuming 1:1 price in MVP)
WITH c AS (
  SELECT borrower, SUM(qty) AS total_collateral
  FROM collateral_vault GROUP BY borrower
)
SELECT l.borrower,
       l.principalAmt / NULLIF(c.total_collateral,0) AS ltv
FROM active_loan l
JOIN c ON c.borrower = l.borrower;
