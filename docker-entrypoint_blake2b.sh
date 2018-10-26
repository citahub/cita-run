#!/bin/bash

echo "start run cita"
./scripts/create_cita_config.py create --nodes "127.0.0.1:4000,127.0.0.1:4001,127.0.0.1:4002,127.0.0.1:4003" --super_admin 0x4b5ae4567ad5d9fb92bc9afd6a657e6fa13a2523
./bin/cita setup test-chain/0
./bin/cita setup test-chain/1
./bin/cita setup test-chain/2
./bin/cita setup test-chain/3
nohup ./bin/cita start test-chain/0 &
nohup ./bin/cita start test-chain/1 &
nohup ./bin/cita start test-chain/2 &
nohup ./bin/cita start test-chain/3 &

/bin/bash -c "while true;do sleep 100;done"
