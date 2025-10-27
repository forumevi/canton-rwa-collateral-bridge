import fetch from "node-fetch";

const base = process.env.JSON_API ?? "http://localhost:7575";
export async function create(templateId: string, payload: any) {
  const res = await fetch(`${base}/v1/create`, {
    method: "POST",
    headers: {"Content-Type":"application/json"},
    body: JSON.stringify({templateId, payload})
  });
  return res.json();
}

export async function exercise(contractId: string, choice: string, argument: any={}) {
  const res = await fetch(`${base}/v1/exercise`, {
    method: "POST",
    headers: {"Content-Type":"application/json"},
    body: JSON.stringify({contractId, choice, argument})
  });
  return res.json();
}

export async function query(templateId: string, filter: any={}) {
  const res = await fetch(`${base}/v1/query`, {
    method: "POST",
    headers: {"Content-Type":"application/json"},
    body: JSON.stringify({templateIds:[templateId], query: filter})
  });
  return res.json();
}
