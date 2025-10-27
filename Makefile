SHELL := /bin/bash

all: build

build:
	cd daml && daml build

run-canton:
	cd canton && ./run-canton.s

json-api:
	daml json-api --ledger-host localhost --ledger-port 7131 --http-port 7575 --allow-insecure-tokens

api:
	cd api && npm install && npm run build && npm run demo
