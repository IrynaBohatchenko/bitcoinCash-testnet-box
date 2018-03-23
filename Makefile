BITCOIND=bitcoinCashd
BITCOINGUI=bitcoinCash-qt
BITCOINCLI=bitcoinCash-cli
B1_FLAGS=-conf=bitcoinCash.conf
B2_FLAGS=-conf=bitcoinCash.conf
B1=-datadir=1 $(B1_FLAGS)
B2=-datadir=2 $(B2_FLAGS)
BLOCKS=1
ADDRESS=
AMOUNT=
ACCOUNT=

start:
	@$(BITCOIND) $(B1) -daemon
	@$(BITCOIND) $(B2) -daemon

start-gui:
	@$(BITCOINGUI) $(B1) &
	@$(BITCOINGUI) $(B2) &

generate:
	@$(BITCOINCLI) $(B1) generate $(BLOCKS)

getinfo:
	@echo "["
	@$(BITCOINCLI) $(B1) getinfo
	@echo ","
	@$(BITCOINCLI) $(B2) getinfo
	@echo "]"

sendfrom1:
	@$(BITCOINCLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom2:
	@$(BITCOINCLI) $(B2) sendtoaddress $(ADDRESS) $(AMOUNT)

address1:
	@$(BITCOINCLI) $(B1) getnewaddress $(ACCOUNT)

address2:
	@$(BITCOINCLI) $(B2) getnewaddress $(ACCOUNT)

stop:
	@$(BITCOINCLI) $(B1) stop
	@$(BITCOINCLI) $(B2) stop

clean:
	find 1/regtest/* -not -name 'server.*' -delete
	find 2/regtest/* -not -name 'server.*' -delete
