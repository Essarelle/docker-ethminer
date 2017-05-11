#!/bin/dumb-init /bin/sh

/cpp-ethereum/build/ethminer/ethminer -U \
--farm-recheck ${FARM_RECHECK} \
-S ${MAIN_POOL} \
-FS ${FAILOVER_POOL} \
-O ${WALLET}
