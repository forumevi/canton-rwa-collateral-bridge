#!/usr/bin/env bash
set -euo pipefail

# This is a template runner. Adjust paths/ports for your environment.
# Requires Canton installed and 'console' command available.

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DAR="../daml/.daml/dist/canton-rwa-0.1.0.dar"

cat > ${SCRIPT_DIR}/runner.sc <<'SCALA'
import com.digitalasset.canton._

val issuerDomain = ExampleServer.runDomain("IssuerDomain", 5011)
val lendingDomain = ExampleServer.runDomain("LendingDomain", 5021)

val pIssuer  = ExampleServer.runParticipant("pIssuer", 7111)
val pLender  = ExampleServer.runParticipant("pLender", 7121)
val pAlice   = ExampleServer.runParticipant("pAlice",  7131)

pIssuer.domains.connect_local(issuerDomain)
pAlice.domains.connect_local(issuerDomain)

pLender.domains.connect_local(lendingDomain)
pAlice.domains.connect_local(lendingDomain)

// Upload DARs
pIssuer.packages.upload( os.pwd/"../daml/.daml/dist/canton-rwa-0.1.0.dar" )
pLender.packages.upload( os.pwd/"../daml/.daml/dist/canton-rwa-0.1.0.dar" )

println("Canton topology started.")
SCALA

console --bootstrap ${SCRIPT_DIR}/runner.sc
