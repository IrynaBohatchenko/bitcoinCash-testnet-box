#!/bin/bash

make start
screen -S bth-testnet-blockcloser -d -m ./closeblock.sh
