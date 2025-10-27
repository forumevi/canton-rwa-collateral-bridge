import {create, query, exercise} from "./client.js";

async function demo() {
  console.log("Minting...");
  // NOTE: In a real flow, fetch TokenIssuer CID first or gate create if already exists
  // This demo assumes an issuer contract exists on ledger.
  const holdings = await query("Token:Holding", {holder: "Alice", symbol: "USDx"});
  if (!holdings.result || holdings.result.length === 0) {
    console.log("No holdings found for Alice. Please run Daml Script (Main:setup) first.");
    return;
  }
  const h = holdings.result[0];
  console.log("Locking collateral...");
  const lock = await create("Collateral:CollateralLock", {
    issuer: "Issuer", borrower: "Alice", lender: "LenderApp",
    symbol: "USDx", qty: 500.0, holding: h.contractId
  });
  await exercise(lock.result.contractId, "Lock", {});

  console.log("Creating offer...");
  const offer = await create("Loan:LoanOffer", {
    lender:"LenderApp", borrower:"Alice",
    principalSym:"USDx", principalAmt:200,
    collateralSym:"USDx", minCollateral:400, rateAPR:0.10
  });
  const vaults = await query("Collateral:CollateralVault", {borrower: "Alice"});
  const vaultCid = vaults.result[0].contractId;
  console.log("Accepting & disbursing...");
  const active = await exercise(offer.result.contractId, "Accept", {vault: vaultCid});
  await exercise(active.result.exerciseResult, "Disburse", {});
  console.log("Done.");
}

demo().catch(e => { console.error(e); process.exit(1); });
